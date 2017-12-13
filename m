From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Use
	snd_soc_update_bits() in aic32x4_set_dai_fmt()" to the asoc tree
Date: Wed, 13 Dec 2017 15:44:59 +0000
Message-ID: <E1eP9DP-0002GA-1Y@debutante>
References: <20171212224311.24045-9-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B6A95267901
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 16:45:01 +0100 (CET)
In-Reply-To: <20171212224311.24045-9-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Use snd_soc_update_bits() in aic32x4_set_dai_fmt()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 60fb4be565c9c44f6999aaa9d18808f1ac49d6ef Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 12 Dec 2017 16:43:10 -0600
Subject: [PATCH] ASoC: tlv320aic32x4: Use snd_soc_update_bits() in
 aic32x4_set_dai_fmt()

Make the code easier to read by using snd_soc_update_bits() over
read/modify/write sequences.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 63a52cdb7afe..fea019343c3b 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -614,16 +614,9 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u8 iface_reg_1;
-	u8 iface_reg_2;
-	u8 iface_reg_3;
-
-	iface_reg_1 = snd_soc_read(codec, AIC32X4_IFACE1);
-	iface_reg_1 = iface_reg_1 & ~(3 << 6 | 3 << 2);
-	iface_reg_2 = snd_soc_read(codec, AIC32X4_IFACE2);
-	iface_reg_2 = 0;
-	iface_reg_3 = snd_soc_read(codec, AIC32X4_IFACE3);
-	iface_reg_3 = iface_reg_3 & ~(1 << 3);
+	u8 iface_reg_1 = 0;
+	u8 iface_reg_2 = 0;
+	u8 iface_reg_3 = 0;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -643,13 +636,13 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_DSP_A:
 		iface_reg_1 |= (AIC32X4_DSP_MODE <<
 				AIC32X4_IFACE1_DATATYPE_SHIFT);
-		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		iface_reg_3 |= AIC32X4_BCLKINV_MASK; /* invert bit clock */
 		iface_reg_2 = 0x01; /* add offset 1 */
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		iface_reg_1 |= (AIC32X4_DSP_MODE <<
 				AIC32X4_IFACE1_DATATYPE_SHIFT);
-		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		iface_reg_3 |= AIC32X4_BCLKINV_MASK; /* invert bit clock */
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		iface_reg_1 |= (AIC32X4_RIGHT_JUSTIFIED_MODE <<
@@ -664,9 +657,14 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, AIC32X4_IFACE1, iface_reg_1);
-	snd_soc_write(codec, AIC32X4_IFACE2, iface_reg_2);
-	snd_soc_write(codec, AIC32X4_IFACE3, iface_reg_3);
+	snd_soc_update_bits(codec, AIC32X4_IFACE1,
+			    AIC32X4_IFACE1_DATATYPE_MASK |
+			    AIC32X4_IFACE1_MASTER_MASK, iface_reg_1);
+	snd_soc_update_bits(codec, AIC32X4_IFACE2,
+			    AIC32X4_DATA_OFFSET_MASK, iface_reg_2);
+	snd_soc_update_bits(codec, AIC32X4_IFACE3,
+			    AIC32X4_BCLKINV_MASK, iface_reg_3);
+
 	return 0;
 }
 
-- 
2.15.1
