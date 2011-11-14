From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH 1/3] ASoC: sta32x: preserve coefficient RAM
Date: Mon, 14 Nov 2011 17:23:16 +0100
Message-ID: <1321287798-20462-2-git-send-email-js@sig21.net>
References: <1321287798-20462-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 3108624716
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 17:31:42 +0100 (CET)
In-Reply-To: <1321287798-20462-1-git-send-email-js@sig21.net>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The coefficient RAM must be saved in a shadow so it can
be restored when the codec is powered on using
regulator_bulk_enable().

Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Daniel Mack <daniel@zonque.org>
Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 sound/soc/codecs/sta32x.c |   63 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/sta32x.h |    1 +
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index bb82408..d2f3715 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -76,6 +76,8 @@ struct sta32x_priv {
 
 	unsigned int mclk;
 	unsigned int format;
+
+	u32 coef_shadow[STA32X_COEF_COUNT];
 };
 
 static const DECLARE_TLV_DB_SCALE(mvol_tlv, -12700, 50, 1);
@@ -227,6 +229,7 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
 	unsigned int cfud;
@@ -239,6 +242,11 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 	snd_soc_write(codec, STA32X_CFUD, cfud);
 
 	snd_soc_write(codec, STA32X_CFADDR2, index);
+	for (i = 0; i < numcoef && (index + i < STA32X_COEF_COUNT); i++)
+		sta32x->coef_shadow[index + i] =
+			  (ucontrol->value.bytes.data[3 * i] << 16)
+			| (ucontrol->value.bytes.data[3 * i + 1] << 8)
+			| (ucontrol->value.bytes.data[3 * i + 2]);
 	for (i = 0; i < 3 * numcoef; i++)
 		snd_soc_write(codec, STA32X_B1CF1 + i,
 			      ucontrol->value.bytes.data[i]);
@@ -252,6 +260,48 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
+{
+	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
+	unsigned int cfud;
+	int i;
+
+	/* preserve reserved bits in STA32X_CFUD */
+	cfud = snd_soc_read(codec, STA32X_CFUD) & 0xf0;
+
+	for (i = 0; i < STA32X_COEF_COUNT; i++) {
+		snd_soc_write(codec, STA32X_CFADDR2, i);
+		snd_soc_write(codec, STA32X_B1CF1,
+			      (sta32x->coef_shadow[i] >> 16) & 0xff);
+		snd_soc_write(codec, STA32X_B1CF2,
+			      (sta32x->coef_shadow[i] >> 8) & 0xff);
+		snd_soc_write(codec, STA32X_B1CF3,
+			      (sta32x->coef_shadow[i]) & 0xff);
+		/* chip documentation does not say if the bits are
+		 * self-clearing, so do it explicitly */
+		snd_soc_write(codec, STA32X_CFUD, cfud);
+		snd_soc_write(codec, STA32X_CFUD, cfud | 0x01);
+	}
+	return 0;
+}
+
+int sta32x_cache_sync(struct snd_soc_codec *codec)
+{
+	unsigned int mute;
+	int rc;
+
+	if (!codec->cache_sync)
+		return 0;
+
+	/* mute during register sync */
+	mute = snd_soc_read(codec, STA32X_MMUTE);
+	snd_soc_write(codec, STA32X_MMUTE, mute | STA32X_MMUTE_MMUTE);
+	sta32x_sync_coef_shadow(codec);
+	rc = snd_soc_cache_sync(codec);
+	snd_soc_write(codec, STA32X_MMUTE, mute);
+	return rc;
+}
+
 #define SINGLE_COEF(xname, index) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = sta32x_coefficient_info, \
@@ -661,7 +711,7 @@ static int sta32x_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
-			snd_soc_cache_sync(codec);
+			sta32x_cache_sync(codec);
 		}
 
 		/* Power up to mute */
@@ -790,6 +840,17 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 			    STA32X_CxCFG_OM_MASK,
 			    2 << STA32X_CxCFG_OM_SHIFT);
 
+	/* initialize coefficient shadow RAM with reset values */
+	for (i = 4; i <= 49; i += 5)
+		sta32x->coef_shadow[i] = 0x400000;
+	for (i = 50; i <= 54; i++)
+		sta32x->coef_shadow[i] = 0x7fffff;
+	sta32x->coef_shadow[55] = 0x5a9df7;
+	sta32x->coef_shadow[56] = 0x7fffff;
+	sta32x->coef_shadow[59] = 0x7fffff;
+	sta32x->coef_shadow[60] = 0x400000;
+	sta32x->coef_shadow[61] = 0x400000;
+
 	sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
diff --git a/sound/soc/codecs/sta32x.h b/sound/soc/codecs/sta32x.h
index b97ee5a..d8e32a6 100644
--- a/sound/soc/codecs/sta32x.h
+++ b/sound/soc/codecs/sta32x.h
@@ -19,6 +19,7 @@
 /* STA326 register addresses */
 
 #define STA32X_REGISTER_COUNT	0x2d
+#define STA32X_COEF_COUNT 62
 
 #define STA32X_CONFA	0x00
 #define STA32X_CONFB    0x01
-- 
1.7.7.2
