From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 2/5] ASoC: beagleboard - update DAPM pins
Date: Tue, 27 Apr 2010 15:54:17 +0100
Message-ID: <1272380060-12493-2-git-send-email-lrg@slimlogic.co.uk>
References: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 05DCD24393
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 16:54:47 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 21so1472040wya.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 07:54:47 -0700 (PDT)
In-Reply-To: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Add our NC pins to conserve power.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/omap/omap3beagle.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 240e097..f348d03 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -88,6 +88,31 @@ static struct snd_soc_ops omap3beagle_ops = {
 	.hw_params = omap3beagle_hw_params,
 };
 
+static int beagle_twl4030_init(struct snd_soc_codec *codec)
+{
+	/* Beagle pin config  */
+
+	/* Headphone Jack */
+	snd_soc_dapm_enable_pin(codec, "HSOR");
+	snd_soc_dapm_enable_pin(codec, "HSOL");
+
+	/* Line in */
+	snd_soc_dapm_enable_pin(codec, "AUXR");
+	snd_soc_dapm_enable_pin(codec, "AUXL");
+
+	/* TWL4030 not connected pins */
+	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
+	snd_soc_dapm_nc_pin(codec, "EARPIECE");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
+	snd_soc_dapm_nc_pin(codec, "CARKITL");
+	snd_soc_dapm_nc_pin(codec, "CARKITR");
+
+	return snd_soc_dapm_sync(codec);
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link omap3beagle_dai = {
 	.name = "TWL4030",
@@ -95,6 +120,7 @@ static struct snd_soc_dai_link omap3beagle_dai = {
 	.cpu_dai = &omap_mcbsp_dai[0],
 	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
 	.ops = &omap3beagle_ops,
+	.init = beagle_twl4030_init,
 };
 
 /* Audio machine driver */
-- 
1.6.3.3
