From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 05/16] ASoC: core: Add strobe control
Date: Tue, 13 Mar 2012 16:11:32 +0100
Message-ID: <1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
	[207.126.144.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E9D0F10437E
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:47 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
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
and where exposing the bit in a normal enum control
would require the user to first manually set then
again unset the bit again for the strobe to trigger.

Get/put accessors added.

snd_soc_get_enum_strobe
snd_soc_put_enum_strobe

Also a generic convenience macros added.

SOC_ENUM_STROBE

And a macro for declaration of the enum.

SOC_ENUM_STROBE_DECL

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h  |   11 +++++++++
 sound/soc/soc-core.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0437c12..a5e782c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -209,6 +209,11 @@
 	.rcount = 8, .count = xcount, \
 	.min = xmin, .max = xmax, .invert = xinvert})
 
+#define SOC_ENUM_STROBE(xname, xenum) \
+	SOC_ENUM_EXT(xname, xenum, \
+	snd_soc_get_enum_strobe, \
+	snd_soc_put_enum_strobe)
+
 /*
  * Simplified versions of above macros, declaring a struct and calculating
  * ARRAY_SIZE internally
@@ -225,6 +230,8 @@
 							ARRAY_SIZE(xtexts), xtexts, xvalues)
 #define SOC_VALUE_ENUM_SINGLE_DECL(name, xreg, xshift, xmask, xtexts, xvalues) \
 	SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
+#define SOC_ENUM_STROBE_DECL(name, xreg, xbit, xinvert, xtexts) \
+	struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xbit, xinvert, 2, xtexts)
 
 /*
  * Component probe and remove ordering levels for components with runtime
@@ -442,6 +449,10 @@ int snd_soc_get_m1r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_m1r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_get_enum_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_enum_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /**
  * struct snd_soc_reg_access - Describes whether a given register is
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16d071e..3a5e519 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2822,6 +2822,64 @@ int snd_soc_put_m1r_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_m1r_sx);
 
 /**
+ * snd_soc_get_enum_strobe - enum strobe get callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback get the value of an enum strobe mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_enum_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = e->reg;
+	unsigned int bit = e->shift_l;
+	unsigned int invert = e->shift_r != 0;
+	unsigned int value = snd_soc_read(codec, reg) & (1 << bit);
+
+	if (bit != 0 && value != 0)
+		value = value >> bit;
+	ucontrol->value.enumerated.item[0] = value ^ invert;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_enum_strobe);
+
+/**
+ * snd_soc_put_enum_strobe - enum strobe put callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback strobe a register bit to high then low (or the inverse)
+ * in one pass of a single mixer enum control.
+ *
+ * Returns 1 for success.
+ */
+int snd_soc_put_enum_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = e->reg;
+	unsigned int bit = e->shift_l;
+	unsigned int invert = e->shift_r != 0;
+	unsigned int strobe = ucontrol->value.enumerated.item[0] != 0;
+	unsigned int clr_mask = (strobe ^ invert) ? 0 : (1 << bit);
+	unsigned int set_mask = (strobe ^ invert) ? (1 << bit) : 0;
+	int err;
+
+	err = snd_soc_update_bits_locked(codec, reg, clr_mask, set_mask);
+	if (err < 0)
+		return err;
+	err = snd_soc_update_bits_locked(codec, reg, set_mask, clr_mask);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_enum_strobe);
+
+/**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
  * @clk_id: DAI specific clock ID
-- 
1.7.8.3
