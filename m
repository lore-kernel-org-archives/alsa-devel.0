From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 3/3] ASoC: TWL4030: Fix voice interface clock
	masters
Date: Fri, 19 Jun 2009 03:23:42 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B2BB1038AC
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 10:23:49 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Voice interface of twl4030 codec supports: CBM_CFM and
CBS_CFS. It doesn't support CBS_CFM.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 sound/soc/omap/sdp3430.c   |    2 +-
 sound/soc/omap/zoom2.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index fd5b30f..a6fb1d6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1969,7 +1969,7 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFM:
 		format &= ~(TWL4030_VIF_SLAVE_EN);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index b719e5d..c51594d 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -96,7 +96,7 @@ static int sdp3430_hw_voice_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_fmt(codec_dai,
 				SND_SOC_DAIFMT_DSP_A |
 				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBS_CFM);
+				SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
 		printk(KERN_ERR "can't set codec DAI configuration\n");
 		return ret;
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 17ae5c2..c84bc1c 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -89,7 +89,7 @@ static int zoom2_hw_voice_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_fmt(codec_dai,
 				SND_SOC_DAIFMT_DSP_A |
 				SND_SOC_DAIFMT_IB_NF |
-				SND_SOC_DAIFMT_CBS_CFM);
+				SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
 		printk(KERN_ERR "can't set codec DAI configuration\n");
 		return ret;
-- 
1.5.4.3
