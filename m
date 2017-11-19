From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: sst-firmware: Improve unlocking of a
 mutex in sst_block_alloc_scratch()
Date: Sun, 19 Nov 2017 10:56:37 +0100
Message-ID: <49e56746-f178-d0e1-7b01-c75bde63f72c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 14EF1266DE0
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 10:57:46 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 10:45:36 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace three calls by goto statements.

* Increase the lock scope.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/intel/common/sst-firmware.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 79a9fdf94d38..665e66670512 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1097,8 +1097,8 @@ int sst_block_alloc_scratch(struct sst_dsp *dsp)
 
 	if (dsp->scratch_size == 0) {
 		dev_info(dsp->dev, "no modules need scratch buffer\n");
-		mutex_unlock(&dsp->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 
 	/* allocate blocks for module scratch buffers */
@@ -1127,21 +1127,21 @@ int sst_block_alloc_scratch(struct sst_dsp *dsp)
 	}
 	if (ret < 0) {
 		dev_err(dsp->dev, "error: can't alloc scratch blocks\n");
-		mutex_unlock(&dsp->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	ret = block_list_prepare(dsp, &dsp->scratch_block_list);
 	if (ret < 0) {
 		dev_err(dsp->dev, "error: scratch block prepare failed\n");
-		mutex_unlock(&dsp->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	/* assign the same offset of scratch to each module */
 	dsp->scratch_offset = ba.offset;
+	ret = dsp->scratch_size;
+unlock:
 	mutex_unlock(&dsp->mutex);
-	return dsp->scratch_size;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sst_block_alloc_scratch);
 
-- 
2.15.0
