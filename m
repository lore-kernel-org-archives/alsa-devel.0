From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: sirf-audio-codec: Simplify the new
 bitmask value in regmap_update_bits
Date: Thu, 08 May 2014 16:29:49 +0800
Message-ID: <1399537789.21710.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id AB8032654E0
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 10:29:56 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id lc6so2831285vcb.16
 for <alsa-devel@alsa-project.org>; Thu, 08 May 2014 01:29:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Rongjun Ying <rongjun.ying@csr.com>, Barry Song <baohua@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Having the binary ones complement operator in the new bitmak value makes the
code hard to read.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
I think the binary ones complement operator in such use case is error prone:
For example:
To set BIT(1) and clear both BIT(2) and BIT(3):
The following code has wrong result:
regmap_update_bits(regmap, the_register, BIT(1), BIT(2), BIT(3),
                   BIT(1) | ~BIT(2) | ~BIT(3));

Axel
 sound/soc/codecs/sirf-audio-codec.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index c5177bc..d90cb0f 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -109,7 +109,7 @@ static void enable_and_reset_codec(struct regmap *regmap,
 {
 	regmap_update_bits(regmap, AUDIO_IC_CODEC_CTRL1,
 			codec_enable_bits | codec_reset_bits,
-			codec_enable_bits | ~codec_reset_bits);
+			codec_enable_bits);
 	msleep(20);
 	regmap_update_bits(regmap, AUDIO_IC_CODEC_CTRL1,
 			codec_reset_bits, codec_reset_bits);
@@ -128,8 +128,7 @@ static int atlas6_codec_enable_and_reset_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		regmap_update_bits(sirf_audio_codec->regmap,
-			AUDIO_IC_CODEC_CTRL1, ATLAS6_CODEC_ENABLE_BITS,
-			~ATLAS6_CODEC_ENABLE_BITS);
+			AUDIO_IC_CODEC_CTRL1, ATLAS6_CODEC_ENABLE_BITS, 0);
 		break;
 	default:
 		break;
@@ -151,8 +150,7 @@ static int prima2_codec_enable_and_reset_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		regmap_update_bits(sirf_audio_codec->regmap,
-			AUDIO_IC_CODEC_CTRL1, PRIMA2_CODEC_ENABLE_BITS,
-			~PRIMA2_CODEC_ENABLE_BITS);
+			AUDIO_IC_CODEC_CTRL1, PRIMA2_CODEC_ENABLE_BITS, 0);
 		break;
 	default:
 		break;
-- 
1.8.3.2
