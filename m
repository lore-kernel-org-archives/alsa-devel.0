From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 03/16] ASoC: core: Add range of reg control
	accessors
Date: Tue, 13 Mar 2012 16:11:30 +0100
Message-ID: <1331651503-16917-4-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D833104321
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

Added get/put accessors for controls that maps a range of
consecutive registers exposed as a multiple value control.

This is specifically useful for hardware that exposes for instance
a range of filter parameters as a range of registers that with
this could be written and read back in one single ioctl operation.

snd_soc_get_m1r_sx
snd_soc_put_m1r_sx

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h  |    4 +++
 sound/soc/soc-core.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d2e1d07..66953a6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -436,6 +436,10 @@ int snd_soc_get_xr8_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_xr8_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_get_m1r_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_m1r_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /**
  * struct snd_soc_reg_access - Describes whether a given register is
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b72f238..bacc465 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2726,6 +2726,78 @@ int snd_soc_put_xr8_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_xr8_sx);
 
 /**
+ * snd_soc_get_m1r_sx - multiple register get callback
+ * @kcontrol: mreg control
+ * @ucontrol: control element information
+ *
+ * Callback to get the all values of a control
+ * from a chunk of registers.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_m1r_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *mc =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = *mc->reg;
+	unsigned int count = mc->count;
+	unsigned int invert = mc->invert;
+	unsigned int idx;
+	long value;
+
+	for (idx = 0; idx < count; idx++) {
+		value = snd_soc_read(codec, reg + idx);
+		if (invert)
+			value = ~value;
+		ucontrol->value.integer.value[idx] = value;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_m1r_sx);
+
+/**
+ * snd_soc_put_m1r_sx - multiple register get callback
+ * @kcontrol: mreg control
+ * @ucontrol: control element information
+ *
+ * Callback to set the all values of a control
+ * from a chunk of registers.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_m1r_sx(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *mc =
+			(struct soc_mreg_control *) kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = *mc->reg;
+	unsigned int count = mc->count;
+	long min = mc->min;
+	long max = mc->max;
+	unsigned int invert = mc->invert;
+	unsigned int idx;
+	long value;
+
+	for (idx = 0; idx < count; idx++) {
+		value = ucontrol->value.integer.value[idx];
+		if (value > max)
+			value = max;
+		else if (value < min)
+			value = min;
+		if (invert)
+			value = ~value;
+		snd_soc_write(codec, reg + idx, value);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_m1r_sx);
+
+/**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
  * @clk_id: DAI specific clock ID
-- 
1.7.8.3
