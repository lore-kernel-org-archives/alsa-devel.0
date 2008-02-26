From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Add support for 12 MHz MCLK in
	TLV320AIC3X
Date: Tue, 26 Feb 2008 11:42:54 +0000
Message-ID: <1204026175-13316-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <>
	<1204026175-13316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 463922463B
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 12:42:56 +0100 (CET)
In-Reply-To: <1204026175-13316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 569ecac..fc63a93 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -660,33 +660,43 @@ struct aic3x_rate_divs {
 /* AIC3X codec mclk clock divider coefficients */
 static const struct aic3x_rate_divs aic3x_divs[] = {
 	/* 8k */
+	{12000000, 8000, 48000, 0xa, 16, 3840},
 	{22579200, 8000, 48000, 0xa, 8, 7075},
 	{33868800, 8000, 48000, 0xa, 5, 8049},
 	/* 11.025k */
+	{12000000, 11025, 44100, 0x6, 15, 528},
 	{22579200, 11025, 44100, 0x6, 8, 0},
 	{33868800, 11025, 44100, 0x6, 5, 3333},
 	/* 16k */
+	{12000000, 16000, 48000, 0x4, 16, 3840},
 	{22579200, 16000, 48000, 0x4, 8, 7075},
 	{33868800, 16000, 48000, 0x4, 5, 8049},
 	/* 22.05k */
+	{12000000, 22050, 44100, 0x2, 15, 528},
 	{22579200, 22050, 44100, 0x2, 8, 0},
 	{33868800, 22050, 44100, 0x2, 5, 3333},
 	/* 32k */
+	{12000000, 32000, 48000, 0x1, 16, 3840},
 	{22579200, 32000, 48000, 0x1, 8, 7075},
 	{33868800, 32000, 48000, 0x1, 5, 8049},
 	/* 44.1k */
+	{12000000, 44100, 44100, 0x0, 15, 528},
 	{22579200, 44100, 44100, 0x0, 8, 0},
 	{33868800, 44100, 44100, 0x0, 5, 3333},
 	/* 48k */
+	{12000000, 48000, 48000, 0x0, 16, 3840},
 	{22579200, 48000, 48000, 0x0, 8, 7075},
 	{33868800, 48000, 48000, 0x0, 5, 8049},
 	/* 64k */
+	{12000000, 64000, 96000, 0x1, 16, 3840},
 	{22579200, 64000, 96000, 0x1, 8, 7075},
 	{33868800, 64000, 96000, 0x1, 5, 8049},
 	/* 88.2k */
+	{12000000, 88200, 88200, 0x0, 15, 528},
 	{22579200, 88200, 88200, 0x0, 8, 0},
 	{33868800, 88200, 88200, 0x0, 5, 3333},
 	/* 96k */
+	{12000000, 96000, 96000, 0x0, 16, 3840},
 	{22579200, 96000, 96000, 0x0, 8, 7075},
 	{33868800, 96000, 96000, 0x0, 5, 8049},
 };
@@ -807,6 +817,7 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 	struct aic3x_priv *aic3x = codec->private_data;
 
 	switch (freq) {
+	case 12000000:
 	case 22579200:
 	case 33868800:
 		aic3x->sysclk = freq;
-- 
1.5.4.3
