From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/8] ASoC: AD1836: drop hardcoded register init
Date: Tue, 14 Jun 2011 17:34:22 -0400
Message-ID: <1308087268-11464-2-git-send-email-vapier@gentoo.org>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 43CDE243E7
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 23:34:07 +0200 (CEST)
In-Reply-To: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Drop hardcoded setup and let the user configure things as they so desire.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index d368539..78c24f8 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -230,25 +230,6 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* default setting for ad1836 */
-	/* de-emphasis: 48kHz, power-on dac */
-	snd_soc_write(codec, AD1836_DAC_CTRL1, 0x300);
-	/* unmute dac channels */
-	snd_soc_write(codec, AD1836_DAC_CTRL2, 0x0);
-	/* high-pass filter enable, power-on adc */
-	snd_soc_write(codec, AD1836_ADC_CTRL1, 0x100);
-	/* unmute adc channles, adc aux mode */
-	snd_soc_write(codec, AD1836_ADC_CTRL2, 0x180);
-	/* left/right diff:PGA/MUX */
-	snd_soc_write(codec, AD1836_ADC_CTRL3, 0x3A);
-	/* volume */
-	snd_soc_write(codec, AD1836_DAC_L1_VOL, 0x3FF);
-	snd_soc_write(codec, AD1836_DAC_R1_VOL, 0x3FF);
-	snd_soc_write(codec, AD1836_DAC_L2_VOL, 0x3FF);
-	snd_soc_write(codec, AD1836_DAC_R2_VOL, 0x3FF);
-	snd_soc_write(codec, AD1836_DAC_L3_VOL, 0x3FF);
-	snd_soc_write(codec, AD1836_DAC_R3_VOL, 0x3FF);
-
 	snd_soc_add_controls(codec, ad1836_snd_controls,
 			     ARRAY_SIZE(ad1836_snd_controls));
 	snd_soc_dapm_new_controls(dapm, ad1836_dapm_widgets,
-- 
1.7.5.3
