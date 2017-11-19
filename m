From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: cht_bsw_rt5645: Use common error
 handling code in cht_codec_fixup()
Date: Sun, 19 Nov 2017 10:00:56 +0100
Message-ID: <287c2ccc-2411-8a6d-bb1b-8b1062b92738@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id ED351266DE0
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 10:02:02 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 09:53:56 +0100

* Add a jump target so that a specific error message is stored only once
  at the end of this function implementation.

* Replace two calls of the function "dev_err" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 18d129caa974..bf3ffc2b0d8f 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -357,20 +357,16 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 					SND_SOC_DAIFMT_NB_NF   |
 					SND_SOC_DAIFMT_CBS_CFS
 			);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			goto report_failure;
 
 		ret = snd_soc_dai_set_fmt(rtd->codec_dai,
 					SND_SOC_DAIFMT_I2S     |
 					SND_SOC_DAIFMT_NB_NF   |
 					SND_SOC_DAIFMT_CBS_CFS
 			);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			goto report_failure;
 
 		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 16);
 		if (ret < 0) {
@@ -403,6 +399,10 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		}
 	}
 	return 0;
+
+report_failure:
+	dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+	return ret;
 }
 
 static int cht_aif1_startup(struct snd_pcm_substream *substream)
-- 
2.15.0
