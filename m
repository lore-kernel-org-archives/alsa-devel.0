From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: Enable SYSCLK last when enabling
	WM8962 mic detection
Date: Tue,  1 Nov 2011 18:40:40 +0000
Message-ID: <1320172842-15790-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A3CB103861
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 19:40:46 +0100 (CET)
In-Reply-To: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure everything is set up before we start detecting.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7f0e6dff..e3ca7b1 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3672,8 +3672,6 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	if (jack) {
 		irq_mask = 0;
 		enable = WM8962_MICDET_ENA;
-
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
 	} else {
 		irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
 		enable = 0;
@@ -3688,6 +3686,9 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	snd_soc_jack_report(wm8962->jack, 0,
 			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
 
+	if (jack)
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm8962_mic_detect);
-- 
1.7.7.1
