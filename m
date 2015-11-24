From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: cs42xx8: fix the noise in the right dac
	channel when playback mono wav with record in background
Date: Tue, 24 Nov 2015 10:18:27 +0800
Message-ID: <09c04620e3394cb10fe3e170947c6f426d51f8be.1448331450.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 26EA426583F
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 03:16:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brian.austin@cirrus.com
Cc: Zidan Wang <zidan.wang@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

When playback mono wav with record in background, there will be some
nosie in the right dac channel. It seems that the ADC data has been
routed to the dac channel.

The cs42888 have 8 dac channels, it's appropriate to mute the unused
dac channels, and the noise will disappear.

Steps to reproduce this issue:
arecord -D hw:0,0 -f S16_LE -r 48000 -c 1 a.wav &
aplay -Dhw:0,0 audio48k16M.wav

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/cs42xx8.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index d562e1b..1179101 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -44,6 +44,7 @@ struct cs42xx8_priv {
 
 	bool slave_mode;
 	unsigned long sysclk;
+	u32 tx_channels;
 };
 
 /* -127.5dB to 0dB with step of 0.5dB */
@@ -257,6 +258,9 @@ static int cs42xx8_hw_params(struct snd_pcm_substream *substream,
 	u32 ratio = cs42xx8->sysclk / params_rate(params);
 	u32 i, fm, val, mask;
 
+	if (tx)
+		cs42xx8->tx_channels = params_channels(params);
+
 	for (i = 0; i < ARRAY_SIZE(cs42xx8_ratios); i++) {
 		if (cs42xx8_ratios[i].ratio == ratio)
 			break;
@@ -283,9 +287,11 @@ static int cs42xx8_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct cs42xx8_priv *cs42xx8 = snd_soc_codec_get_drvdata(codec);
+	u8 dac_unmute = cs42xx8->tx_channels ?
+		        ~((0x1 << cs42xx8->tx_channels) - 1) : 0;
 
-	regmap_update_bits(cs42xx8->regmap, CS42XX8_DACMUTE,
-			   CS42XX8_DACMUTE_ALL, mute ? CS42XX8_DACMUTE_ALL : 0);
+	regmap_write(cs42xx8->regmap, CS42XX8_DACMUTE,
+		     mute ? CS42XX8_DACMUTE_ALL : dac_unmute);
 
 	return 0;
 }
-- 
1.9.1
