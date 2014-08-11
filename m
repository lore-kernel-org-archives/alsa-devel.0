From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Wait Baytrail ADSP boot at
	resume_early stage
Date: Mon, 11 Aug 2014 14:15:37 +0300
Message-ID: <1407755738-31693-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BAEE261AFF
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 13:15:47 +0200 (CEST)
In-Reply-To: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove sst_byt_pcm_dev_resume() and move waiting of firmware boot into
sst_byt_pcm_dev_resume_early(). Now suspend_late and resume_early phases are
in sync with each other so that we know that ADSP was put into reset and was
unpowered after suspend_late and is ready to resume IO after resume_early
during resume stage in sst_byt_pcm_trigger().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Borun Fu <borun.fu@intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index ba7ed9720732..eb7b31e13565 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -423,18 +423,14 @@ static int sst_byt_pcm_dev_suspend_late(struct device *dev)
 static int sst_byt_pcm_dev_resume_early(struct device *dev)
 {
 	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
+	int ret;
 
 	dev_dbg(dev, "resume early\n");
 
 	/* load fw and boot DSP */
-	return sst_byt_dsp_boot(dev, sst_pdata);
-}
-
-static int sst_byt_pcm_dev_resume(struct device *dev)
-{
-	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
-
-	dev_dbg(dev, "resume\n");
+	ret = sst_byt_dsp_boot(dev, sst_pdata);
+	if (ret)
+		return ret;
 
 	/* wait for FW to finish booting */
 	return sst_byt_dsp_wait_for_ready(dev, sst_pdata);
@@ -443,7 +439,6 @@ static int sst_byt_pcm_dev_resume(struct device *dev)
 static const struct dev_pm_ops sst_byt_pm_ops = {
 	.suspend_late = sst_byt_pcm_dev_suspend_late,
 	.resume_early = sst_byt_pcm_dev_resume_early,
-	.resume = sst_byt_pcm_dev_resume,
 };
 
 #define SST_BYT_PM_OPS	(&sst_byt_pm_ops)
-- 
2.0.1
