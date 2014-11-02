From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: Intel: fix missing mutex
Date: Sun,  2 Nov 2014 12:04:41 +0530
Message-ID: <1414910081-2487-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id E1973260532
 for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2014 07:34:55 +0100 (CET)
Received: by mail-pd0-f171.google.com with SMTP id r10so9699468pdi.30
 for <alsa-devel@alsa-project.org>; Sat, 01 Nov 2014 23:34:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

on error in block prepare, we were returning the error code while still
holding the mutex. We are releasing the mutex in this patch before
return.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/intel/sst-firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 35788ad..dca6d9a 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -1120,6 +1120,7 @@ int sst_block_alloc_scratch(struct sst_dsp *dsp)
 	ret = block_list_prepare(dsp, &dsp->scratch_block_list);
 	if (ret < 0) {
 		dev_err(dsp->dev, "error: scratch block prepare failed\n");
+		mutex_unlock(&dsp->mutex);
 		return ret;
 	}
 
-- 
1.8.1.2
