From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Wed, 9 Nov 2011 14:30:01 +0100
Message-ID: <20111109133001.GA7394@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 07B6B103862
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 14:30:14 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

sta32x resets and loses all configuration during ESD test.
Work around by preserving coefficient RAM in a shadow,
poll once a second on the CONFA register and restore
all coeffcients and registers when CONFA changes unexpectedly.

Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Daniel Mack <daniel@zonque.org>
Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
ESD test means they are shooting the poor thing with a taser
and then sneer at the weakling when it keels over in shock.
You wouldn't believe what atrocities some "engineers" are capable
of, all in the name of "quality assurance".

The patch applies cleanly against both for-3.2 and for-3.3
of git://opensource.wolfsonmicro.com/linux-2.6-asoc.git.

 sound/soc/codecs/sta32x.c |   75 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sta32x.h |    1 +
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index bb82408..3caa7c3 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -76,6 +77,10 @@ struct sta32x_priv {
 
 	unsigned int mclk;
 	unsigned int format;
+
+	u32 coef_shadow[STA32X_COEF_COUNT];
+	struct delayed_work watchdog_work;
+	int shutdown;
 };
 
 static const DECLARE_TLV_DB_SCALE(mvol_tlv, -12700, 50, 1);
@@ -227,6 +232,7 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
 	unsigned int cfud;
@@ -239,6 +245,11 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 	snd_soc_write(codec, STA32X_CFUD, cfud);
 
 	snd_soc_write(codec, STA32X_CFADDR2, index);
+	for (i = 0; i < numcoef && (index + (i + 1) * 3 < STA32X_COEF_COUNT); i++)
+		sta32x->coef_shadow[index + i] =
+			  (ucontrol->value.bytes.data[3 * i    ] << 16)
+			| (ucontrol->value.bytes.data[3 * i + 1] << 8)
+			| (ucontrol->value.bytes.data[3 * i + 2]);
 	for (i = 0; i < 3 * numcoef; i++)
 		snd_soc_write(codec, STA32X_B1CF1 + i,
 			      ucontrol->value.bytes.data[i]);
@@ -252,6 +263,55 @@ static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/* work around ESD issue where sta32x resets and loses all configuration */
+static void sta32x_watchdog(struct work_struct *work)
+{
+	struct sta32x_priv *sta32x = container_of(work, struct sta32x_priv,
+						  watchdog_work.work);
+	struct snd_soc_codec *codec = sta32x->codec;
+	unsigned int value;
+	unsigned int cfud;
+	unsigned int mute;
+	unsigned int confa;
+	int i;
+
+	/* check if sta32x has reset itself */
+	snd_soc_cache_read(codec, STA32X_CONFA, &confa);
+	if (confa == codec->hw_read(codec, STA32X_CONFA))
+		goto ok;
+
+	/* mute during restore */
+	snd_soc_cache_read(codec, STA32X_MMUTE, &mute);
+	snd_soc_write(codec, STA32X_MMUTE, mute | STA32X_MMUTE_MMUTE);
+
+	for (i = 0; i < STA32X_REGISTER_COUNT; i++) {
+		if (snd_soc_codec_volatile_register(codec, i))
+			continue;
+		snd_soc_cache_read(codec, i, &value);
+		snd_soc_write(codec, i, value);
+	}
+
+	/* preserve reserved bits in STA32X_CFUD */
+	cfud = snd_soc_read(codec, STA32X_CFUD) & 0xf0;
+
+	for (i = 0; i < STA32X_COEF_COUNT; i++) {
+		snd_soc_write(codec, STA32X_CFADDR2, i);
+		snd_soc_write(codec, STA32X_B1CF1, (sta32x->coef_shadow[i] >> 16) & 0xff);
+		snd_soc_write(codec, STA32X_B1CF2, (sta32x->coef_shadow[i] >>  8) & 0xff);
+		snd_soc_write(codec, STA32X_B1CF3, (sta32x->coef_shadow[i]      ) & 0xff);
+		/* chip documentation does not say if the bits are self clearing,
+		 * so do it explicitly */
+		snd_soc_write(codec, STA32X_CFUD, cfud);
+		snd_soc_write(codec, STA32X_CFUD, cfud | 0x01);
+	}
+	snd_soc_write(codec, STA32X_MMUTE, mute);
+
+ok:
+	if (!sta32x->shutdown)
+		schedule_delayed_work(&sta32x->watchdog_work,
+				      round_jiffies_relative(HZ));
+}
+
 #define SINGLE_COEF(xname, index) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = sta32x_coefficient_info, \
@@ -790,10 +850,23 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 			    STA32X_CxCFG_OM_MASK,
 			    2 << STA32X_CxCFG_OM_SHIFT);
 
+	/* initialize coefficient shadow RAM with reset values */
+	for (i = 4; i <= 49; i += 5)
+		sta32x->coef_shadow[i] = 0x400000;
+	for (i = 50; i <= 54; i ++)
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
 
+	INIT_DELAYED_WORK(&sta32x->watchdog_work, sta32x_watchdog);
+	schedule_delayed_work(&sta32x->watchdog_work, round_jiffies_relative(HZ));
 	return 0;
 
 err_get:
@@ -806,6 +879,8 @@ static int sta32x_remove(struct snd_soc_codec *codec)
 {
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 
+	sta32x->shutdown = 1;
+	cancel_delayed_work_sync(&sta32x->watchdog_work);
 	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 	regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
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
