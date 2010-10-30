From: Christian Wisner-Carlson <christian@freedomofknowledge.org>
Subject: Balanced output support for Xonar: Patches for
 Virtuoso driver to add mixer option for balanced mono output (PCM179x dacs)
Date: Sat, 30 Oct 2010 06:24:19 -0400
Message-ID: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DB46F1037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 12:24:20 +0200 (CEST)
Received: by fxm1 with SMTP id 1so3814311fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 30 Oct 2010 03:24:20 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

This patch adds a mixer switch for soundcards using the snd-virtuoso
driver and pcm1796/pcm1792(a) DAC(s) which switches between Stereo,
Balanced Left, and Balanced Right output modes.

The PCM179x series has a "Monaural Mode" that outputs a single channel
in differential (and therefore balanced, because of the buffer
circuit) mode, which boosts the SNR and allows for common mode
rejection (with the proper cable). Simply use the left output as the
noninverting signal and the right output as the inverting output. The
datasheets for both the pcm1792a and pcm1796 provide application
suggestions, which boil down mainly to "connect an XLR jack to the
outputs of the normal application circuit".

I tested this thoroughly with an Asus Xonar Essence ST, although it
should also work with the HDAV, Essence STX, and probably other cards.
I get no noticeable interference when running balanced audio from the
card over approximately 150ft of unshielded twisted pair cable which I
have running through my walls.

The driver defaults to stereo output and this patch will not cause
issues for users who do not need/want this feature. The patches that I
am posting only give one control regardless of whether or not more
than one DAC is connected. I have another patchset that gives
individual control of all 4 dacs in the Xonar Essence ST+H6 and
HDAV+H6 setups (H6 is an optional daughterboard for surround sound).
It allows for 4 balanced outputs, 8 unbalanced outputs, or any
combination of balanced and unbalanced outputs. HOWEVER, it adds 4
mixer controls and the code isn't very pretty. If people want it, I'll
post it as well and/or take suggestions on how to improve it.

Here is a diff of xonar_pcm179x.c, which is the only changed file. The
diff is against alsa-driver 1.0.23 but should cleanly patch the GIT
revision. Please tell me if this is not the correct way to post a
patch, and tell me if it seems like a candidate to be merged.

Christian Wisner-Carlson

--- ./alsa-driver-1.0.23/alsa-kernel/pci/oxygen/xonar_pcm179x.c	2010-04-16
07:10:10.000000000 -0400
+++ ./anothermono/alsa-driver-1.0.23/alsa-kernel/pci/oxygen/xonar_pcm179x.c	2010-10-30
05:28:55.000000000 -0400
@@ -176,6 +176,8 @@
 	unsigned int current_rate;
 	bool os_128;
 	bool hp_active;
+	bool monomode;
+	bool rightmono;
 	s8 hp_gain_offset;
 	bool has_cs2000;
 	u8 cs2000_fun_cfg_1;
@@ -532,6 +534,13 @@
 		reg = PCM1796_OS_64;
 	else
 		reg = PCM1796_OS_32;
+	
+	if (data->monomode)
+	        reg = reg | PCM1796_MONO;
+	
+	if (data->rightmono)
+	        reg = reg | PCM1796_CHSL_RIGHT;
+	
 	for (i = 0; i < data->dacs; ++i)
 		pcm1796_write_cached(chip, i, 20, reg);
 }
@@ -719,6 +728,19 @@
 	return 0;
 }

+static int monomode_info(struct snd_kcontrol *ctl, struct
snd_ctl_elem_info *info)
+{
+	static const char *const names[3] = { "Stereo", "Balanced Left",
"Balanced Right" };
+
+	info->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	info->count = 1;
+	info->value.enumerated.items = 3;
+	if (info->value.enumerated.item >= 3)
+		info->value.enumerated.item = 0;
+	strcpy(info->value.enumerated.name, names[info->value.enumerated.item]);
+	return 0;
+}
+
 static int os_128_get(struct snd_kcontrol *ctl,
 		      struct snd_ctl_elem_value *value)
 {
@@ -729,6 +751,18 @@
 	return 0;
 }

+static int monomode_get(struct snd_kcontrol *ctl,
+		      struct snd_ctl_elem_value *value)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct xonar_pcm179x *data = chip->model_data;
+	int newvalue;
+	newvalue = data->monomode + (data->monomode & data->rightmono);
+
+	value->value.enumerated.item[0] = newvalue;
+	return 0;
+}
+
 static int os_128_put(struct snd_kcontrol *ctl,
 		      struct snd_ctl_elem_value *value)
 {
@@ -751,6 +785,25 @@
 	return changed;
 }

+static int monomode_put(struct snd_kcontrol *ctl,
+		      struct snd_ctl_elem_value *value)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct xonar_pcm179x *data = chip->model_data;
+	int changed;
+
+	mutex_lock(&chip->mutex);
+	changed = value->value.enumerated.item[0] !=
+	   (data->monomode + (data->monomode & data->rightmono));
+	if (changed) {
+		data->monomode = (value->value.enumerated.item[0]) ? 1 : 0;
+		data->rightmono = (value->value.enumerated.item[0] == 2) ? 1 : 0;
+		update_pcm1796_oversampling(chip);
+	}
+	mutex_unlock(&chip->mutex);
+	return changed;
+}
+
 static const struct snd_kcontrol_new os_128_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "DAC Oversampling Playback Enum",
@@ -759,6 +812,14 @@
 	.put = os_128_put,
 };

+static const struct snd_kcontrol_new monomode_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "DAC Mono Mode Playback Enum",
+	.info = monomode_info,
+	.get = monomode_get,
+	.put = monomode_put,
+};
+
 static int st_output_switch_info(struct snd_kcontrol *ctl,
 				 struct snd_ctl_elem_info *info)
 {
@@ -932,6 +993,9 @@
 	err = snd_ctl_add(chip->card, snd_ctl_new1(&os_128_control, chip));
 	if (err < 0)
 		return err;
+	err = snd_ctl_add(chip->card, snd_ctl_new1(&monomode_control, chip));
+	if (err < 0)
+		return err;
 	return 0;
 }




I am also in the process of adding a Phase Invert switch and
(possibly) Deemphasis control for the PCM179x DACs as well, and will
post patches if anyone is interested.
