From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 02/16] ASoC: core: Add 8bit multi reg control
	accessors
Date: Tue, 13 Mar 2012 16:11:29 +0100
Message-ID: <1331651503-16917-3-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog109.obsmtp.com (eu1sys200aog109.obsmtp.com
	[207.126.144.127])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BC8910431C
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:17 +0100 (CET)
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

Added get/put accessors for controls that span multiple 8bit registers
which together forms a single signed value in a MSB/LSB manner.

snd_soc_get_xr8_sx
snd_soc_put_xr8_sx

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h  |    4 ++
 sound/soc/soc-core.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index dac20e0..d2e1d07 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -432,6 +432,10 @@ int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_get_xr8_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_xr8_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /**
  * struct snd_soc_reg_access - Describes whether a given register is
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b5ecf6d..b72f238 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2641,6 +2641,91 @@ int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
 
 /**
+ * snd_soc_get_xr8_sx - signed multi register get callback
+ * @kcontrol: mreg control
+ * @ucontrol: control element information
+ *
+ * Callback to get the value of a control that can
+ * span multiple 8bit codec registers which together
+ * forms a single signed value in a MSB/LSB manner.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_xr8_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int *reg = mc->reg;
+	unsigned int rcount = mc->rcount;
+	long min = mc->min;
+	long max = mc->max;
+	unsigned int invert = mc->invert;
+	unsigned long mask = abs(min) | abs(max);
+	long value = 0;
+	int i, rvalue;
+
+	for (i = 0; i < rcount; i++) {
+		rvalue = snd_soc_read(codec, reg[i]) & 0xff;
+		value |= rvalue << (8 * (rcount - i - 1));
+	}
+	value &= mask;
+	if (min < 0 && value > max)
+		value |= ~mask;
+	if (invert)
+		value = ~value;
+	ucontrol->value.integer.value[0] = value;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_xr8_sx);
+
+/**
+ * snd_soc_put_xr8_sx - signed multi register get callback
+ * @kcontrol: mreg control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value of a control that can
+ * span multiple 8bit codec registers which together
+ * forms a single signed value in a MSB/LSB manner.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_xr8_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int *reg = mc->reg;
+	unsigned int rcount = mc->rcount;
+	long min = mc->min;
+	long max = mc->max;
+	unsigned int invert = mc->invert;
+	unsigned long mask = abs(min) | abs(max);
+	long value = ucontrol->value.integer.value[0];
+	int i, rvalue, err;
+
+	if (invert)
+		value = ~value;
+	if (value > max)
+		value = max;
+	else if (value < min)
+		value = min;
+	value &= mask;
+	for (i = 0; i < rcount; i++) {
+		rvalue = (value >> (8 * (rcount - i - 1))) & 0xff;
+		err = snd_soc_write(codec, reg[i], rvalue);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_xr8_sx);
+
+/**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
  * @clk_id: DAI specific clock ID
-- 
1.7.8.3
