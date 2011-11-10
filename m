From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 1/2] ASoC: Remove unused defines in alc5632
	codec.
Date: Thu, 10 Nov 2011 21:22:15 +0200
Message-ID: <1320952936-14935-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id C8C3124470
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 20:22:38 +0100 (CET)
Received: by faaa20 with SMTP id a20so3435967faa.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 11:22:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 68465d8..0fff98e 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -964,27 +964,6 @@ static int alc5632_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-#define ALC5632_REC_UNMUTE (ALC5632_ADC_REC_MIC2 \
-		| ALC5632_ADC_REC_LINE_IN | ALC5632_ADC_REC_AUX \
-		| ALC5632_ADC_REC_HP | ALC5632_ADC_REC_SPK \
-		| ALC5632_ADC_REC_MONOMIX)
-
-#define ALC5632_MIC_ROUTE (ALC5632_MIC_ROUTE_HP \
-		| ALC5632_MIC_ROUTE_SPK \
-		| ALC5632_MIC_ROUTE_MONOMIX)
-
-#define ALC5632_PWR_DEFAULT (ALC5632_PWR_ADC_STATUS \
-		| ALC5632_PWR_DAC_STATUS \
-		| ALC5632_PWR_AMIX_STATUS \
-		| ALC5632_PWR_VREF_STATUS)
-
-#define ALC5632_ADC_REC_GAIN_COMP(x) (int)((x - ALC5632_ADC_REC_GAIN_BASE) \
-		/ ALC5632_ADC_REC_GAIN_STEP)
-
-#define ALC5632_MIC_BOOST_COMP(x) (int)(x / ALC5632_MIC_BOOST_STEP)
-
-#define ALC5632_SPK_OUT_VOL_COMP(x) (int)(x / ALC5632_SPK_OUT_VOL_STEP)
-
 static int alc5632_probe(struct snd_soc_codec *codec)
 {
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
-- 
1.7.3.4
