From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 2/8] ASoC: core: Add strobe control
Date: Fri, 20 Apr 2012 11:32:44 +0200
Message-ID: <1334914364-27373-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 79C2210B95A
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 11:32:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
List-Id: alsa-devel@alsa-project.org

From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>

Added support for a control that strobes a bit in
a register to high then back to low (or the inverse).

This is typically useful for hardware that requires
strobing a singe bit to trigger some functionality
and where exposing the bit in a normal single control
would require the user to first manually set then
again unset the bit again for the strobe to trigger.

Added convenience macro.

SOC_SINGLE_STROBE

Added accessor implementations.

snd_soc_get_strobe
snd_soc_put_strobe

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h  |    8 ++++++
 sound/soc/soc-core.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8888adc..bda0cd2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -209,6 +209,10 @@
 		{.regbase = xregbase, .regcount = xregcount, .nbits = xnbits, \
 		.invert = xinvert, .min = xmin, .max = xmax} }
 
+#define SOC_SINGLE_STROBE(xname, xreg, xshift, xinvert) \
+	SOC_SINGLE_EXT(xname, xreg, xshift, 1, xinvert, \
+		snd_soc_get_strobe, snd_soc_put_strobe)
+
 /*
  * Simplified versions of above macros, declaring a struct and calculating
  * ARRAY_SIZE internally
@@ -448,6 +452,10 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_get_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /**
  * struct snd_soc_reg_access - Describes whether a given register is
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7fc7294b..e9c5850 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2966,6 +2966,69 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_xr_sx);
 
 /**
+ * snd_soc_get_strobe - strobe get callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback get the value of a strobe mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = 1 << shift;
+	unsigned int invert = mc->invert != 0;
+	unsigned int val = snd_soc_read(codec, reg) & mask;
+
+	if (shift != 0 && val != 0)
+		val = val >> shift;
+	ucontrol->value.enumerated.item[0] = val ^ invert;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_strobe);
+
+/**
+ * snd_soc_put_strobe - strobe put callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback strobe a register bit to high then low (or the inverse)
+ * in one pass of a single mixer enum control.
+ *
+ * Returns 1 for success.
+ */
+int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = 1 << shift;
+	unsigned int invert = mc->invert != 0;
+	unsigned int strobe = ucontrol->value.enumerated.item[0] != 0;
+	unsigned int val1 = (strobe ^ invert) ? mask : 0;
+	unsigned int val2 = (strobe ^ invert) ? 0 : mask;
+	int err;
+
+	err = snd_soc_update_bits_locked(codec, reg, mask, val1);
+	if (err < 0)
+		return err;
+
+	err = snd_soc_update_bits_locked(codec, reg, mask, val2);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_strobe);
+
+/**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
  * @clk_id: DAI specific clock ID
-- 
1.7.8.3
