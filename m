From: apatard@mandriva.com
Subject: [patch 3/6] ASoC: Add SOC_DOUBLE_R_SX_TLV control
Date: Sat, 15 May 2010 17:30:01 +0200
Message-ID: <20100515153130.338630785@mandriva.com>
References: <20100515152958.899927802@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 11E80243A3
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 17:31:16 +0200 (CEST)
Content-Disposition: inline; filename=add_soc_double_r_sx_tlv.patch
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
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch is adding a new control which has the following capabilities:
- tlv
- variable data size (for instance, 7 ou 8 bit)
- double mixer
- data range centered around 0

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/include/sound/soc.h
===================================================================
--- sound-2.6.orig/include/sound/soc.h	2010-05-14 09:28:38.152498194 +0200
+++ sound-2.6/include/sound/soc.h	2010-05-14 09:31:47.204499340 +0200
@@ -170,6 +170,21 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&xenum }
 
+#define SOC_DOUBLE_R_SX_TLV(xname, xreg_left, xreg_right, xshift,\
+		xmin, xmax, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_2r_sx, \
+	.get = snd_soc_get_volsw_2r_sx, \
+	.put = snd_soc_put_volsw_2r_sx, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg_left, \
+		 .rreg = xreg_right, .shift = xshift, \
+		 .min = xmin, .max = xmax} }
+
+
 /*
  * Simplified versions of above macros, declaring a struct and calculating
  * ARRAY_SIZE internally
@@ -329,6 +344,12 @@ int snd_soc_put_volsw_s8(struct snd_kcon
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max);
+int snd_soc_info_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 
 /**
  * struct snd_soc_jack_pin - Describes a pin to update based on jack detection
Index: sound-2.6/sound/soc/soc-core.c
===================================================================
--- sound-2.6.orig/sound/soc/soc-core.c	2010-05-14 09:28:38.180548514 +0200
+++ sound-2.6/sound/soc/soc-core.c	2010-05-14 09:31:47.264497529 +0200
@@ -2352,6 +2352,101 @@ int snd_soc_limit_volume(struct snd_soc_
 EXPORT_SYMBOL_GPL(snd_soc_limit_volume);
 
 /**
+ * snd_soc_info_volsw_2r_sx - double with tlv and variable data size
+ *  mixer info callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int max = mc->max;
+	int min = mc->min;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = max-min;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r_sx);
+
+/**
+ * snd_soc_get_volsw_2r_sx - double with tlv and variable data size
+ *  mixer get callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int mask = (1<<mc->shift)-1;
+	int min = mc->min;
+	int val = snd_soc_read(codec, mc->reg) & mask;
+	int valr = snd_soc_read(codec, mc->rreg) & mask;
+
+	ucontrol->value.integer.value[0] = ((val & 0xff)-min);
+	ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);
+
+/**
+ * snd_soc_put_volsw_2r_sx - double with tlv and variable data size
+ *  mixer put callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int mask = (1<<mc->shift)-1;
+	int min = mc->min;
+	int ret;
+	unsigned int val, valr, oval, ovalr;
+
+	val = ((ucontrol->value.integer.value[0]+min) & 0xff);
+	val &= mask;
+	valr = ((ucontrol->value.integer.value[1]+min) & 0xff);
+	valr &= mask;
+
+	oval = snd_soc_read(codec, mc->reg) & mask;
+	ovalr = snd_soc_read(codec, mc->rreg) & mask;
+
+	ret = 0;
+	if (oval != val) {
+		ret = snd_soc_write(codec, mc->reg, val);
+		if (ret < 0)
+			return 0;
+		ret = 1;
+	}
+	if (ovalr != valr) {
+		ret = snd_soc_write(codec, mc->rreg, valr);
+		if (ret < 0)
+			return 0;
+		ret = 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
+
+/**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
  * @clk_id: DAI specific clock ID
