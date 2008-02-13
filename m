From: Rainer Zimmermann <mail@lightshed.de>
Subject: Maya44 revised patch
Date: Thu, 14 Feb 2008 00:36:07 +0100
Message-ID: <47B37EE7.5000905@lightshed.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000600080204050005040009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server9.dnshoster.de (server9.dnshoster.de [213.202.245.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 5134E2438D
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 00:35:57 +0100 (CET)
Received: from fcf35.f.ppp-pool.de ([195.4.207.53] helo=[192.168.178.10])
	by server9.dnshoster.de with esmtpa (Exim 4.68)
	(envelope-from <mail@lightshed.de>) id 1JPR8f-0000WB-CK
	for alsa-devel@alsa-project.org; Thu, 14 Feb 2008 00:35:50 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000600080204050005040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable


This is the revised version of the ESI Maya44 patch.
changes are mainly coding style, some cleanups and using a patch file for=
=20
ice1724.c .

The added code now (mostly) passes checkpatch.pl, except for some "#if 0"=
's=20
which I'd leave in for the development phase.

Also, I changed the rate setting logic, which (for now) allows all rates =
up to=20
192kHz even for capturing. As capturing actually only supports 96 kHz, wh=
ile=20
capturing & playback rates are linked, this is not really ok. I'd appreci=
ate=20
suggestions about how this could be handled properly, while still support=
ing=20
playback up to 192 kHz...


Again, feedback & testing is appreciated.

For more information, see doc/README.maya44 .


-Rainer



--=20
Lightshed IT Services
L=F6fflerstr. 27, 22765 Hamburg, Germany * mail@lightshed.de * www.lights=
hed.de

--------------000600080204050005040009
Content-Type: text/x-patch;
 name="maya44_03.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maya44_03.diff"

diff -r 5715d75f833f alsa-kernel
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/alsa-kernel	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+../alsa-kernel
\ No newline at end of file
diff -r 5715d75f833f doc/README.maya44
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/doc/README.maya44	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,158 @@
+
+STATE OF DEVELOPMENT:
+
+This driver is being developed on the initiative of Piotr Makowski (oponek@gmail.com) and financed by Lars Bergmann.
+Development is carried out by Rainer Zimmermann (mail@lightshed.de).
+
+ESI provided a sample Maya44 card for the development work.
+
+However, unfortunately it has turned out difficult to get detailed programming information, so I (Rainer Zimmermann) had to find out some card-specific information by experiment and conjecture. Some information (in particular, several GPIO bits) is still missing.
+
+This is the first testing version of the Maya44 driver released to the alsa-devel mailing list (Feb 5, 2008).
+
+
+The following functions work, as tested by Rainer Zimmermann and Piotr Makowski:
+
+- playback and capture at all sampling rates
+- input/output level
+- crossmixing
+- line/mic switch
+- phantom power switch
+- analogue monitor a.k.a bypass
+
+
+The following functions *should* work, but are not fully tested:
+
+- Channel 3+4 analogue - S/PDIF input switching
+- S/PDIF output
+- all inputs/outputs on the M/IO/DIO extension card
+- internal/external clock selection
+
+
+*In particular, we would appreciate testing of these functions by anyone who has access to an M/IO/DIO extension card.*
+
+
+Things that do not seem to work:
+
+- The level meters ("multi track") in 'alsamixer' do not seem to react to signals in (if this is a bug, it would probably be in the existing ICE1724 code).
+
+- Ardour 2.1 seems to work only via JACK, not using ALSA directly or via OSS. This still needs to be tracked down.
+
+
+DRIVER DETAILS:
+
+the following files were added:
+
+pci/ice1724/maya44.c        - Maya44 specific code
+pci/ice1724/maya44.h
+pci/ice1724/ice1724.patch
+pci/ice1724/ice1724.h.patch - PROPOSED patch to ice1724.h (see SAMPLING RATES)
+i2c/other/wm8776.c  - low-level access routines for Wolfson WM8776 codecs 
+include/wm8776.h
+
+
+Note that the wm8776.c code is meant to be card-independent and does not actually register the codec with the ALSA infrastructure.
+This is done in maya44.c, mainly because some of the WM8776 controls are used in Maya44-specific ways, and should be named appropriately.
+
+
+the following files were created in pci/ice1724, simply #including the corresponding file from the alsa-kernel tree:
+
+wtm.h
+vt1720_mobo.h
+revo.h
+prodigy192.h
+pontis.h
+phase.h
+maya44.h
+juli.h
+aureon.h
+amp.h
+envy24ht.h
+se.h
+prodigy_hifi.h
+
+
+*I hope this is the correct way to do things.*
+
+
+SAMPLING RATES:
+
+The Maya44 card (or more exactly, the Wolfson WM8776 codecs) allow a maximum sampling rate of 192 kHz for playback and 92 kHz for capture.
+
+As the ICE1724 chip only allows one global sampling rate, this is handled as follows:
+
+* setting the sampling rate on any open PCM device on the maya44 card will always set the *global* sampling rate for all playback and capture channels.
+
+* In the current state of the driver, setting rates of up to 192 kHz is permitted even for capture devices.
+
+*AVOID CAPTURING AT RATES ABOVE 96kHz*, even though it may appear to work. The codec cannot actually capture at such rates, meaning poor quality.
+
+
+I propose some additional code for limiting the sampling rate when setting on a capture pcm device. However because of the global sampling rate, this logic would be somewhat problematic.
+
+The proposed code (currently deactivated) is in ice1712.h.patch, ice1724.c and maya44.c (in pci/ice1712).
+
+
+SOUND DEVICES:
+
+PCM devices correspond to inputs/outputs as follows (assuming Maya44 is card #0):
+
+hw:0,0 input - stereo, analog input 1+2
+hw:0,0 output - stereo, analog output 1+2
+hw:0,1 input - stereo, analog input 3+4 OR S/PDIF input
+hw:0,1 output - stereo, analog output 3+4 (and SPDIF out)
+
+
+NAMING OF MIXER CONTROLS:
+
+(for more information about the signal flow, please refer to the block diagram on p.24 of the ESI Maya44 manual, or in the ESI windows software).
+
+
+PCM: (digital) output level for channel 1+2
+PCM 1: same for channel 3+4
+
+Mic Phantom+48V: switch for +48V phantom power for electrostatic microphones on input 1/2.
+    Make sure this is not turned on while any other source is connected to input 1/2.
+    It might damage the source and/or the maya44 card.
+
+Mic/Line input: if switch is is on, input jack 1/2 is microphone input (mono), otherwise line input (stereo).
+
+Bypass: analogue bypass from ADC input to output for channel 1+2. Same as "Monitor" in the windows driver.
+Bypass 1: same for channel 3+4.
+
+Crossmix: cross-mixer from channels 1+2 to channels 3+4
+Crossmix 1: cross-mixer from channels 3+4 to channels 1+2
+
+IEC958 Output: switch for S/PDIF output.
+    This is not supported by the ESI windows driver.
+    S/PDIF should output the same signal as channel 3+4. [untested!]
+
+
+Digitial output selectors:
+
+    These switches allow a direct digital routing from the ADCs to the DACs.
+    Each switch determines where the digital input data to one of the DACs comes from.
+    They are not supported by the ESI windows driver.
+    For normal operation, they should all be set to "PCM out".
+
+H/W: Output source channel 1
+H/W 1: Output source channel 2
+H/W 2: Output source channel 3
+H/W 3: Output source channel 4
+
+H/W 4 ... H/W 9: unknown function, left in to enable testing.
+    Possibly some of these control S/PDIF output(s).
+    If these turn out to be unused, they will go away in later driver versions.
+
+Selectable values for each of the digital output selectors are:
+   "PCM out" -> DAC output of the corresponding channel (default setting)
+   "Input 1"...
+   "Input 4" -> direct routing from ADC output of the selected input channel
+
+
+--------
+
+Feb 14, 2008
+Rainer Zimmermann
+mail@lightshed.de
+
diff -r 5715d75f833f i2c/other/Makefile
--- a/i2c/other/Makefile	Wed Feb 13 08:45:05 2008 +0100
+++ b/i2c/other/Makefile	Thu Feb 14 00:22:51 2008 +0100
@@ -5,7 +5,12 @@ include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
-export-objs += ak4xxx-adda.o ak4114.o ak4117.o pt2258.o
+export-objs += ak4xxx-adda.o ak4114.o ak4117.o pt2258.o wm8776.o
+
+snd-wm8776-objs := wm8776.o
+
+# Module Dependency
+obj-$(CONFIG_SND_ICE1724) += snd-wm8776.o
 
 # Toplevel Module Dependency
 # hack for tea575x support
diff -r 5715d75f833f i2c/other/wm8776.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/i2c/other/wm8776.c	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,406 @@
+/*
+ *   Low-level routines for Wolfson WM8776 codec
+ *
+ *	Copyright (c) 2007 Rainer Zimmermann <mail@lightshed.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+/*
+ * not implemented:
+ * ADC highpass,
+ * AGC/limiter functions,
+ * DAC output phase+output control
+ * de-emphasis mode
+ * etc...
+ */
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
+#include <wm8776.h>
+
+MODULE_AUTHOR("Rainer Zimmermann <mail@lightshed.de>");
+MODULE_DESCRIPTION("Routines for control of WM8776 codecs");
+MODULE_LICENSE("GPL");
+
+/*
+ * If defined, ADC attenuation down to -103dB will be allowed, using the
+ * WM8776's digital attenuator. IMO this is rather useless because it will
+ * not prevent ADC overdrive, and digital attenuation can always be done in
+ *  software.
+ * If not defined, ADC level runs from -21 to +24dB, using the analogue PGA.
+ *
+ * NOTE: this driver does not currently support input mute. Since input level
+ * applies also to the analogue bypass besides the ADC, muting should be
+ * done using MUTERA/MUTELA in R21, rather than the digital mute using
+ * R14/R15.
+ */
+#undef WM8776_ALLOW_ADC_DIGITAL_ATTEN
+
+/*
+ * dB tables
+ */
+/* headphone output: mute, -73..+6db (1db step) */
+static const DECLARE_TLV_DB_SCALE(tlv_scale_headphone, -7400, 100, 1);
+/* DAC output: mute, -127..0db (0.5db step) */
+static const DECLARE_TLV_DB_SCALE(tlv_scale_dac, -12750, 50, 1);
+
+#ifdef WM8776_ALLOW_ADC_DIGITAL_ATTEN
+#define ADC_REG_LOW 0x01
+/* ADC gain: mute, -103..+24db (0.5db step) */
+static const DECLARE_TLV_DB_SCALE(tlv_scale_adcgain, -10300, 50, 0);
+#else
+#define ADC_REG_LOW 0xa5
+/* ADC gain: mute, -21..+24db (0.5db step) */
+static const DECLARE_TLV_DB_SCALE(tlv_scale_adcgain, -2100, 50, 0);
+#endif
+
+static struct snd_wm8776_volume_info volumeinfo[WM8776_NUM_VOLUMES] =
+{
+	[WM8776_VOL_HEADPHONE_L] = {
+		.nlvl = 80,
+		.tlv_scale = tlv_scale_headphone,
+		.reg_idx = WM8776_REG_HEADPHONE_L,
+		.reg_mask = 0x7f,
+		.reg_low = 0x30,
+		.reg_mute = 0x00
+	},
+	[WM8776_VOL_HEADPHONE_R] = {
+		.nlvl = 80,
+		.tlv_scale = tlv_scale_headphone,
+		.reg_idx = WM8776_REG_HEADPHONE_R,
+		.reg_mask = 0x7f,
+		.reg_low = 0x30,
+		.reg_mute = 0x00
+	},
+	[WM8776_VOL_DAC_L] = {
+		.nlvl = 255,
+		.tlv_scale = tlv_scale_dac,
+		.reg_idx = WM8776_REG_DAC_ATTEN_L,
+		.reg_mask = 0xff,
+		.reg_low = 0x01,
+		.reg_mute = 0x00
+	},
+	[WM8776_VOL_DAC_R] = {
+		.nlvl = 255,
+		.tlv_scale = tlv_scale_dac,
+		.reg_idx = WM8776_REG_DAC_ATTEN_R,
+		.reg_mask = 0xff,
+		.reg_low = 0x01,
+		.reg_mute = 0x00
+	},
+	[WM8776_VOL_ADC_GAIN_L] = {
+		.nlvl = 91,
+		.tlv_scale = tlv_scale_adcgain,
+		.reg_idx = WM8776_REG_ADC_ATTEN_L,
+		.reg_mask = 0xff,
+		.reg_low = ADC_REG_LOW,
+		.reg_mute = ADC_REG_LOW
+	},
+	[WM8776_VOL_ADC_GAIN_R] = {
+		.nlvl = 91,
+		.tlv_scale = tlv_scale_adcgain,
+		.reg_idx = WM8776_REG_ADC_ATTEN_R,
+		.reg_mask = 0xff,
+		.reg_low = ADC_REG_LOW,
+		.reg_mute = ADC_REG_LOW
+	}
+};
+
+static struct snd_wm8776_switch_info switchinfo[WM8776_NUM_SWITCHES] =
+{
+	[WM8776_SW_OUT_DAC] = {
+		.n_states = 2,
+		.reg_idx = 0x16,
+		.reg_inv = 0,
+		.reg_mask = 0x01
+	},
+	[WM8776_SW_OUT_AUX] = {
+		.n_states = 2,
+		.reg_idx = 0x16,
+		.reg_inv = 0,
+		.reg_mask = 0x02
+	},
+	[WM8776_SW_OUT_BYPASS] = {
+		.n_states = 2,
+		.reg_idx = 0x16,
+		.reg_inv = 0,
+		.reg_mask = 0x04
+	},
+	[WM8776_SW_IN_1] = {
+		.n_states = 2,
+		.reg_idx = 0x15,
+		.reg_inv = 0,
+		.reg_mask = 0x01
+	},
+	[WM8776_SW_IN_2] = {
+		.n_states = 2,
+		.reg_idx = 0x15,
+		.reg_inv = 0,
+		.reg_mask = 0x02
+	},
+	[WM8776_SW_IN_3] = {
+		.n_states = 2,
+		.reg_idx = 0x15,
+		.reg_inv = 0,
+		.reg_mask = 0x04
+	},
+	[WM8776_SW_IN_4] = {
+		.n_states = 2,
+		.reg_idx = 0x15,
+		.reg_inv = 0,
+		.reg_mask = 0x08
+	},
+	[WM8776_SW_IN_5] = {
+		.n_states = 2,
+		.reg_idx = 0x15,
+		.reg_inv = 0,
+		.reg_mask = 0x10
+	}
+};
+
+/* write the given register and save the data to the cache */
+void snd_wm8776_reg_write(struct snd_wm8776 *wm, unsigned char reg,
+						unsigned short val)
+{
+/*	printk(KERN_DEBUG "wm8776: wm8776_reg_write\n"); */
+
+	mutex_lock(&wm->wm_mutex);
+	wm->ops.write(wm->private_data, wm->chip, reg, val);
+	wm->regs[reg] = val;
+	mutex_unlock(&wm->wm_mutex);
+}
+EXPORT_SYMBOL(snd_wm8776_reg_write);
+
+/*
+ * update the given register with and/or mask and save the data to the cache
+ */
+void snd_wm8776_reg_mask(struct snd_wm8776 *wm, unsigned char reg,
+			unsigned short and_mask, unsigned short or_mask)
+{
+	unsigned short val = (wm->regs[reg] & and_mask) | or_mask;
+	if (val != wm->regs[reg]) {
+		mutex_lock(&wm->wm_mutex);
+		wm->ops.write(wm->private_data, wm->chip, reg, val);
+		wm->regs[reg] = val;
+		mutex_unlock(&wm->wm_mutex);
+	}
+}
+
+/*
+ * change a volume setting on a WM8776 codec.
+ * index is one of the WM8776_VOL_XXX constants defined in wm8776.h.
+ * value runs from 1 to nlvl specified in volume_info, or 0 for mute.
+ * returns 1 if changed, 0 otherwise
+ */
+int snd_wm8776_set_volume(struct snd_wm8776 *wm, int index, int value)
+{
+	struct snd_wm8776_volume_info *vi = &volumeinfo[index];
+	unsigned short flags;
+
+	if (wm->volumes[index] == value) return 0;
+	wm->volumes[index] = value;
+
+	/*
+	 * HEADPHONE (index<2): UPDATE and zero cross enable (0x180),
+	 * ADC GAIN: zero cross enable (0x100),
+	 * DAC ATTEN: UPDATE (0x100)
+	 */
+	flags = (index < 2) ? 0x180 : 0x100;
+	snd_wm8776_reg_write(wm, vi->reg_idx,
+		((value == 0) ? vi->reg_mute : vi->reg_low+value-1)|flags );
+
+	/* handle ADC mute */
+	if (index == WM8776_VOL_ADC_GAIN_L)
+		snd_wm8776_reg_mask(wm, WM8776_REG_ADC_MUX, ~0x80,
+						(value == 0) ? 0x80 : 0 );
+
+	if (index == WM8776_VOL_ADC_GAIN_R)
+		snd_wm8776_reg_mask(wm, WM8776_REG_ADC_MUX, ~0x40,
+						(value == 0) ? 0x40 : 0 );
+
+	return 1;
+}
+EXPORT_SYMBOL(snd_wm8776_set_volume);
+
+int snd_wm8776_get_volume(struct snd_wm8776 *wm, int index)
+{
+	return wm->volumes[index];
+}
+EXPORT_SYMBOL(snd_wm8776_get_volume);
+
+const struct snd_wm8776_volume_info *snd_wm8776_get_volume_info(int index)
+{
+	return volumeinfo+index;
+}
+EXPORT_SYMBOL(snd_wm8776_get_volume_info);
+
+/* return 1 if changed, 0 otherwise */
+int snd_wm8776_set_switch(struct snd_wm8776 *wm, int index, int value)
+{
+	struct snd_wm8776_switch_info *vi = &switchinfo[index];
+	unsigned int mask = 1<<index;
+	unsigned int sw = (wm->switches & ~mask) | (value?mask:0);
+	if (sw == wm->switches) return 0;
+	wm->switches = sw;
+	if (vi->reg_inv) value = !value;
+	snd_wm8776_reg_mask(wm, vi->reg_idx, ~vi->reg_mask,
+						value?vi->reg_mask:0 );
+	return 1;
+}
+EXPORT_SYMBOL(snd_wm8776_set_switch);
+
+int snd_wm8776_get_switch(struct snd_wm8776 *wm, int index)
+{
+	return (wm->switches & (1<<index)) != 0;
+}
+EXPORT_SYMBOL(snd_wm8776_get_switch);
+
+const struct snd_wm8776_switch_info *snd_wm8776_get_switch_info(int index)
+{
+	return switchinfo+index;
+}
+EXPORT_SYMBOL(snd_wm8776_get_switch_info);
+
+/*
+ * this currently sets the same rate for ADC and DAC, but limits ADC rate
+ * to 256X (96kHz). For 256X mode (96kHz), this sets ADC oversampling to 64x,
+ * as recommended by WM8776 datasheet. Setting the rate is not really
+ * necessary in slave mode.
+ */
+void snd_wm8776_set_rate(struct snd_wm8776 *wm, unsigned char clock_ratio)
+{
+	unsigned char adc_ratio = clock_ratio;
+	if (adc_ratio < WM8776_CLOCK_RATIO_256FS)
+		adc_ratio = WM8776_CLOCK_RATIO_256FS;
+
+	snd_wm8776_reg_mask(wm, WM8776_REG_MASTER_MODE_CONTROL,
+		0x180,
+		adc_ratio | ((adc_ratio == WM8776_CLOCK_RATIO_256FS)?8:0)
+				| (clock_ratio<<4));
+}
+EXPORT_SYMBOL(snd_wm8776_set_rate);
+
+
+/*
+ * reset a WM8776 codec
+ * @state: 1 = reset codec only, 0 = reset and restore the registers
+ *
+ * assert the reset operation and restores the register values to the chips.
+ */
+void snd_wm8776_reset(struct snd_wm8776 *wm, int state)
+{
+	unsigned char reg;
+
+	snd_wm8776_reg_write(wm, WM8776_REG_RESET, 0);  /* reset */
+
+	if (state) {
+		/* mute DAC */
+		snd_wm8776_reg_write(wm, WM8776_REG_DAC_MUTE, 1);
+	} else {
+		/* update registers from stored values */
+
+		/* restore attenuation levels, with update bit (0x100) set */
+		for (reg = 0; reg < 6; reg++)
+			snd_wm8776_reg_mask(wm, reg, 0xff, 0x100);
+
+		/* restore all other registers except reset register (0x17) */
+		for (reg = 6; reg < 23; reg++)
+			snd_wm8776_reg_mask(wm, reg, 0x1ff, 0);
+	}
+}
+EXPORT_SYMBOL(snd_wm8776_reset);
+
+/*
+ * initialize a wm8776 chip
+ */
+void snd_wm8776_init(struct snd_wm8776 *wm, struct snd_card *card,
+				void *private_data, int chip,
+				const struct snd_wm8776_ops *ops)
+{
+	static const unsigned short inits_wm8776[] = {
+		0x02, 0x100, /* R2: headphone L+R muted + update */
+		0x05, 0x100, /* R5: DAC output L+R muted + update */
+		0x06, 0x000, /* R6: DAC output phase normal */
+		0x07, 0x091, /* R7: DAC enable zero cross detection,
+				normal output */
+		0x08, 0x000, /* R8: DAC soft mute off */
+		0x09, 0x000, /* R9: no deemph, DAC zero detect disabled */
+		0x0a, 0x022, /* R10: DAC I2C mode, std polarities, 24bit */
+		0x0b, 0x022, /* R11: ADC I2C mode, std polarities, 24bit,
+				highpass filter enabled */
+		0x0c, 0x042, /* R12: ADC+DAC slave, ADC+DAC 44,1kHz */
+		0x0d, 0x000, /* R13: all power up */
+		0x0e, 0x100, /* R14: ADC left muted,
+				enable zero cross detection */
+		0x0f, 0x100, /* R15: ADC right muted,
+				enable zero cross detection */
+			     /* R16: ALC...*/
+		0x11, 0x000, /* R17: disable ALC */
+			     /* R18: ALC...*/
+			     /* R19: noise gate...*/
+		0x15, 0x000, /* R21: ADC input mux init, mute all inputs */
+		0x16, 0x001, /* R22: output mux, select DAC */
+		0xff, 0xff
+	};
+
+	const unsigned short *ptr;
+	unsigned char reg;
+	unsigned short data;
+
+	mutex_init(&wm->wm_mutex);
+	wm->card = card;
+	wm->chip = chip;
+	wm->private_data = private_data;
+	memcpy(&wm->ops, ops, sizeof(wm->ops));
+
+	memset(wm->regs, 0, sizeof(wm->regs));
+	memset(wm->volumes, 0, sizeof(wm->volumes));
+
+	/* enable DAC output; mute bypass, aux & all inputs */
+	wm->switches = (1<<WM8776_SW_OUT_DAC);
+
+	ptr = inits_wm8776;
+	while (*ptr != 0xff) {
+		reg = *ptr++;
+		data = *ptr++;
+		snd_wm8776_reg_write(wm, reg, data);
+	}
+	printk(KERN_DEBUG "wm8776: init done, wm=%p, priv=%p, chip %i\n",
+				wm, wm->private_data, chip);
+}
+EXPORT_SYMBOL(snd_wm8776_init);
+
+
+static int __init alsa_wm8776_module_init(void)
+{
+	return 0;
+}
+
+static void __exit alsa_wm8776_module_exit(void)
+{
+}
+
+
+module_init(alsa_wm8776_module_init)
+module_exit(alsa_wm8776_module_exit)
+
+
diff -r 5715d75f833f include/sound
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/sound	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+../alsa-kernel/include
\ No newline at end of file
diff -r 5715d75f833f include/wm8776.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/wm8776.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,149 @@
+#ifndef __SOUND_WM8776_H
+#define __SOUND_WM8776_H
+
+/*
+ *   Low-level routines for Wolfson WM8776 codec
+ *
+ *	Copyright (c) 2007 Rainer Zimmermann <mail@lightshed.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+struct snd_wm8776;
+
+/* register indexes */
+#define WM8776_REG_HEADPHONE_L 0x00
+#define WM8776_REG_HEADPHONE_R 0x01
+#define WM8776_REG_HEADPHONE_MASTER 0x02
+/* digital attenuation */
+#define WM8776_REG_DAC_ATTEN_L 0x03
+#define WM8776_REG_DAC_ATTEN_R 0x04
+#define WM8776_REG_DAC_ATTEN_MASTER 0x05
+#define WM8776_REG_DAC_PHASE 0x06
+#define WM8776_REG_DAC_CONTROL 0x07
+#define WM8776_REG_DAC_MUTE 0x08
+#define WM8776_REG_DAC_DEEMPH 0x09
+#define WM8776_REG_DAC_IF_CONTROL 0x0a
+#define WM8776_REG_ADC_IF_CONTROL 0x0b
+#define WM8776_REG_MASTER_MODE_CONTROL 0x0c
+#define WM8776_REG_POWERDOWN 0x0d
+/* analogue input pga + digital attenuation */
+#define WM8776_REG_ADC_ATTEN_L 0x0e
+#define WM8776_REG_ADC_ATTEN_R 0x0f
+#define WM8776_REG_ADC_ALC1 0x10
+#define WM8776_REG_ADC_ALC2 0x11
+#define WM8776_REG_ADC_ALC3 0x12
+#define WM8776_REG_ADC_NOISE_GATE 0x13
+#define WM8776_REG_ADC_LIMITER 0x14
+#define WM8776_REG_ADC_MUX 0x15
+#define WM8776_REG_OUTPUT_MUX 0x16
+#define WM8776_REG_RESET 0x17
+
+#define WM8776_NUM_REGS 0x18
+
+
+/* clock ratio identifiers for snd_wm8776_set_rate() */
+#define WM8776_CLOCK_RATIO_128FS 0
+#define WM8776_CLOCK_RATIO_192FS 1
+#define WM8776_CLOCK_RATIO_256FS 2
+#define WM8776_CLOCK_RATIO_384FS 3
+#define WM8776_CLOCK_RATIO_512FS 4
+#define WM8776_CLOCK_RATIO_768FS 5
+
+
+enum {
+	WM8776_VOL_HEADPHONE_L = 0,
+	WM8776_VOL_HEADPHONE_R,
+	WM8776_VOL_DAC_L,
+	WM8776_VOL_DAC_R,
+	WM8776_VOL_ADC_GAIN_L,
+	WM8776_VOL_ADC_GAIN_R,
+
+	WM8776_NUM_VOLUMES
+};
+
+enum {
+	WM8776_SW_OUT_DAC = 0,
+	WM8776_SW_OUT_AUX,
+	WM8776_SW_OUT_BYPASS,
+	WM8776_SW_IN_1,
+	WM8776_SW_IN_2,
+	WM8776_SW_IN_3,
+	WM8776_SW_IN_4,
+	WM8776_SW_IN_5,
+
+	WM8776_NUM_SWITCHES
+};
+
+
+struct snd_wm8776_ops {
+	/* currently only 1 op... */
+	void (*write)(void *private_data, int chip, unsigned char reg,
+		      unsigned short val);
+};
+
+struct snd_wm8776 {
+	struct snd_card *card;
+	unsigned char chip;
+	void *private_data;
+	struct snd_wm8776_ops ops;
+	unsigned short regs[WM8776_NUM_REGS];
+	unsigned char volumes[WM8776_NUM_VOLUMES];
+	unsigned int switches:WM8776_NUM_SWITCHES; /* bit field */
+	struct mutex wm_mutex; /* mutex for WM8776 register access */
+};
+
+struct snd_wm8776_volume_info {
+	/* number of levels (not counting mute) */
+	unsigned char nlvl;
+	/* declaration of dB scale (using DECLARE_TLV_DB_SCALE) */
+	const unsigned int *tlv_scale;
+
+	/*private data*/
+	unsigned char reg_idx;
+	unsigned short reg_mask;
+	unsigned short reg_low;   /* register value for lowest level */
+	unsigned short reg_mute;  /* register value for mute */
+};
+
+struct snd_wm8776_switch_info {
+	unsigned char n_states;
+
+	/*private data*/
+	unsigned char reg_idx;
+	unsigned char reg_inv;
+	unsigned short reg_mask;
+};
+
+void snd_wm8776_reset(struct snd_wm8776 *wm, int state);
+void snd_wm8776_init(struct snd_wm8776 *wm, struct snd_card *card,
+			void *private_data, int chip,
+			const struct snd_wm8776_ops *ops);
+
+void snd_wm8776_reg_write(struct snd_wm8776 *wm, unsigned char reg,
+			unsigned short val);
+#define snd_wm8776_reg_get(wm, reg) ((wm)->regs[(reg)])
+
+int snd_wm8776_set_volume(struct snd_wm8776 *wm, int index, int value);
+int snd_wm8776_get_volume(struct snd_wm8776 *wm, int index);
+const struct snd_wm8776_volume_info *snd_wm8776_get_volume_info(int index);
+int snd_wm8776_set_switch(struct snd_wm8776 *wm, int index, int value);
+int snd_wm8776_get_switch(struct snd_wm8776 *wm, int index);
+const struct snd_wm8776_switch_info *snd_wm8776_get_switch_info(int index);
+void snd_wm8776_set_rate(struct snd_wm8776 *wm, unsigned char clock_ratio);
+
+
+#endif /* __SOUND_WM8776_H */
diff -r 5715d75f833f pci/Makefile
--- a/pci/Makefile	Wed Feb 13 08:45:05 2008 +0100
+++ b/pci/Makefile	Thu Feb 14 00:22:51 2008 +0100
@@ -12,7 +12,7 @@ clean-files := ad1889.c atiixp.c atiixp_
 clean-files := ad1889.c atiixp.c atiixp_modem.c bt87x.c cmipci.c ens1370.c \
 	fm801.c intel8x0.c maestro3.c via82xx.c via82xx_modem.c
 
-obj-$(CONFIG_SND) += pdplus/ asihpi/
+obj-$(CONFIG_SND) += pdplus/ asihpi/ ice1712/
 
 #
 #
diff -r 5715d75f833f pci/ice1712/Makefile
--- a/pci/ice1712/Makefile	Wed Feb 13 08:45:05 2008 +0100
+++ b/pci/ice1712/Makefile	Thu Feb 14 00:22:51 2008 +0100
@@ -5,8 +5,14 @@ include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
+clean-files := ice1724.c ice1712.h
 export-objs = ak4xxx.o
 
 include $(SND_TOPDIR)/alsa-kernel/pci/ice1712/Makefile
 
+snd-ice1724-objs += maya44.o
+
 include $(SND_TOPDIR)/Rules.make
+
+ice1724.c: ice1724.patch $(SND_TOPDIR)/alsa-kernel/pci/ice1712/ice1724.c
+ice1712.h: ice1712.h.patch $(SND_TOPDIR)/alsa-kernel/pci/ice1712/ice1712.h
diff -r 5715d75f833f pci/ice1712/amp.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/amp.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/amp.h"
diff -r 5715d75f833f pci/ice1712/aureon.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/aureon.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/aureon.h"
diff -r 5715d75f833f pci/ice1712/envy24ht.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/envy24ht.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/envy24ht.h"
diff -r 5715d75f833f pci/ice1712/ice1712.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/ice1712.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/ice1712.h"
diff -r 5715d75f833f pci/ice1712/ice1712.h.patch
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/ice1712.h.patch	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,10 @@
+--- ../../alsa-kernel/pci/ice1712/ice1712.h	2008-02-01 17:52:14.000000000 +0100
++++ ice1712.h	2008-02-08 13:32:03.000000000 +0100
+@@ -340,6 +340,7 @@
+ 	struct mutex open_mutex;
+ 	struct snd_pcm_substream *pcm_reserved[4];
+ 	struct snd_pcm_hw_constraint_list *hw_rates; /* card-specific rate constraints */
++	struct snd_pcm_hw_constraint_list *hw_rates_adc; /* card-specific rate constraints for ADC */
+ 
+ 	unsigned int akm_codecs;
+ 	struct snd_akm4xxx *akm;
diff -r 5715d75f833f pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c	Wed Feb 13 08:45:05 2008 +0100
+++ b/pci/ice1712/ice1724.c	Thu Feb 14 00:22:51 2008 +0100
@@ -1,2 +1,2580 @@
 #include "adriver.h"
-#include "../../alsa-kernel/pci/ice1712/ice1724.c"
+/*
+ *   ALSA driver for VT1724 ICEnsemble ICE1724 / VIA VT1724 (Envy24HT)
+ *                   VIA VT1720 (Envy24PT)
+ *
+ *	Copyright (c) 2000 Jaroslav Kysela <perex@perex.cz>
+ *                    2002 James Stafford <jstafford@ampltd.com>
+ *                    2003 Takashi Iwai <tiwai@suse.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */      
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <sound/core.h>
+#include <sound/info.h>
+#include <sound/mpu401.h>
+#include <sound/initval.h>
+
+#include <sound/asoundef.h>
+
+#include "ice1712.h"
+#include "envy24ht.h"
+
+/* lowlevel routines */
+#include "amp.h"
+#include "revo.h"
+#include "aureon.h"
+#include "vt1720_mobo.h"
+#include "pontis.h"
+#include "prodigy192.h"
+#include "prodigy_hifi.h"
+#include "juli.h"
+#include "maya44.h"
+#include "phase.h"
+#include "wtm.h"
+#include "se.h"
+
+MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
+MODULE_DESCRIPTION("VIA ICEnsemble ICE1724/1720 (Envy24HT/PT)");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{"
+	       REVO_DEVICE_DESC
+	       AMP_AUDIO2000_DEVICE_DESC
+	       AUREON_DEVICE_DESC
+	       VT1720_MOBO_DEVICE_DESC
+	       PONTIS_DEVICE_DESC
+	       PRODIGY192_DEVICE_DESC
+	       PRODIGY_HIFI_DEVICE_DESC
+	       JULI_DEVICE_DESC
+	       MAYA44_DEVICE_DESC
+	       PHASE_DEVICE_DESC
+	       WTM_DEVICE_DESC
+	       SE_DEVICE_DESC
+		"{VIA,VT1720},"
+		"{VIA,VT1724},"
+		"{ICEnsemble,Generic ICE1724},"
+		"{ICEnsemble,Generic Envy24HT}"
+		"{ICEnsemble,Generic Envy24PT}}");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;		/* Enable this card */
+static char *model[SNDRV_CARDS];
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for ICE1724 soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for ICE1724 soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable ICE1724 soundcard.");
+module_param_array(model, charp, NULL, 0444);
+MODULE_PARM_DESC(model, "Use the given board model.");
+
+
+/* Both VT1720 and VT1724 have the same PCI IDs */
+static const struct pci_device_id snd_vt1724_ids[] = {
+	{ PCI_VENDOR_ID_ICE, PCI_DEVICE_ID_VT1724, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, snd_vt1724_ids);
+
+
+static int PRO_RATE_LOCKED;
+static int PRO_RATE_RESET = 1;
+static unsigned int PRO_RATE_DEFAULT = 44100;
+
+/*
+ *  Basic I/O
+ */
+ 
+/* check whether the clock mode is spdif-in */
+static inline int is_spdif_master(struct snd_ice1712 *ice)
+{
+	return (inb(ICEMT1724(ice, RATE)) & VT1724_SPDIF_MASTER) ? 1 : 0;
+}
+
+static inline int is_pro_rate_locked(struct snd_ice1712 *ice)
+{
+	return is_spdif_master(ice) || PRO_RATE_LOCKED;
+}
+
+/*
+ * ac97 section
+ */
+
+static unsigned char snd_vt1724_ac97_ready(struct snd_ice1712 *ice)
+{
+	unsigned char old_cmd;
+	int tm;
+	for (tm = 0; tm < 0x10000; tm++) {
+		old_cmd = inb(ICEMT1724(ice, AC97_CMD));
+		if (old_cmd & (VT1724_AC97_WRITE | VT1724_AC97_READ))
+			continue;
+		if (!(old_cmd & VT1724_AC97_READY))
+			continue;
+		return old_cmd;
+	}
+	snd_printd(KERN_ERR "snd_vt1724_ac97_ready: timeout\n");
+	return old_cmd;
+}
+
+static int snd_vt1724_ac97_wait_bit(struct snd_ice1712 *ice, unsigned char bit)
+{
+	int tm;
+	for (tm = 0; tm < 0x10000; tm++)
+		if ((inb(ICEMT1724(ice, AC97_CMD)) & bit) == 0)
+			return 0;
+	snd_printd(KERN_ERR "snd_vt1724_ac97_wait_bit: timeout\n");
+	return -EIO;
+}
+
+static void snd_vt1724_ac97_write(struct snd_ac97 *ac97,
+				  unsigned short reg,
+				  unsigned short val)
+{
+	struct snd_ice1712 *ice = ac97->private_data;
+	unsigned char old_cmd;
+
+	old_cmd = snd_vt1724_ac97_ready(ice);
+	old_cmd &= ~VT1724_AC97_ID_MASK;
+	old_cmd |= ac97->num;
+	outb(reg, ICEMT1724(ice, AC97_INDEX));
+	outw(val, ICEMT1724(ice, AC97_DATA));
+	outb(old_cmd | VT1724_AC97_WRITE, ICEMT1724(ice, AC97_CMD));
+	snd_vt1724_ac97_wait_bit(ice, VT1724_AC97_WRITE);
+}
+
+static unsigned short snd_vt1724_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
+{
+	struct snd_ice1712 *ice = ac97->private_data;
+	unsigned char old_cmd;
+
+	old_cmd = snd_vt1724_ac97_ready(ice);
+	old_cmd &= ~VT1724_AC97_ID_MASK;
+	old_cmd |= ac97->num;
+	outb(reg, ICEMT1724(ice, AC97_INDEX));
+	outb(old_cmd | VT1724_AC97_READ, ICEMT1724(ice, AC97_CMD));
+	if (snd_vt1724_ac97_wait_bit(ice, VT1724_AC97_READ) < 0)
+		return ~0;
+	return inw(ICEMT1724(ice, AC97_DATA));
+}
+
+
+/*
+ * GPIO operations
+ */
+
+/* set gpio direction 0 = read, 1 = write */
+static void snd_vt1724_set_gpio_dir(struct snd_ice1712 *ice, unsigned int data)
+{
+	outl(data, ICEREG1724(ice, GPIO_DIRECTION));
+	inw(ICEREG1724(ice, GPIO_DIRECTION)); /* dummy read for pci-posting */
+}
+
+/* set the gpio mask (0 = writable) */
+static void snd_vt1724_set_gpio_mask(struct snd_ice1712 *ice, unsigned int data)
+{
+	outw(data, ICEREG1724(ice, GPIO_WRITE_MASK));
+	if (! ice->vt1720) /* VT1720 supports only 16 GPIO bits */
+		outb((data >> 16) & 0xff, ICEREG1724(ice, GPIO_WRITE_MASK_22));
+	inw(ICEREG1724(ice, GPIO_WRITE_MASK)); /* dummy read for pci-posting */
+}
+
+static void snd_vt1724_set_gpio_data(struct snd_ice1712 *ice, unsigned int data)
+{
+	outw(data, ICEREG1724(ice, GPIO_DATA));
+	if (! ice->vt1720)
+		outb(data >> 16, ICEREG1724(ice, GPIO_DATA_22));
+	inw(ICEREG1724(ice, GPIO_DATA)); /* dummy read for pci-posting */
+}
+
+static unsigned int snd_vt1724_get_gpio_data(struct snd_ice1712 *ice)
+{
+	unsigned int data;
+	if (! ice->vt1720)
+		data = (unsigned int)inb(ICEREG1724(ice, GPIO_DATA_22));
+	else
+		data = 0;
+	data = (data << 16) | inw(ICEREG1724(ice, GPIO_DATA));
+	return data;
+}
+
+/*
+ *  Interrupt handler
+ */
+
+static irqreturn_t snd_vt1724_interrupt(int irq, void *dev_id)
+{
+	struct snd_ice1712 *ice = dev_id;
+	unsigned char status;
+	int handled = 0;
+
+	while (1) {
+		status = inb(ICEREG1724(ice, IRQSTAT));
+		if (status == 0)
+			break;
+
+		handled = 1;		
+		/* these should probably be separated at some point, 
+		 * but as we don't currently have MPU support on the board
+		 * I will leave it
+		 */
+		if ((status & VT1724_IRQ_MPU_RX)||(status & VT1724_IRQ_MPU_TX)) {
+			if (ice->rmidi[0])
+				snd_mpu401_uart_interrupt(irq, ice->rmidi[0]->private_data);
+			outb(status & (VT1724_IRQ_MPU_RX|VT1724_IRQ_MPU_TX), ICEREG1724(ice, IRQSTAT));
+			status &= ~(VT1724_IRQ_MPU_RX|VT1724_IRQ_MPU_TX);
+		}
+		if (status & VT1724_IRQ_MTPCM) {
+			/*
+			 * Multi-track PCM
+			 * PCM assignment are:
+			 * Playback DMA0 (M/C) = playback_pro_substream
+			 * Playback DMA1 = playback_con_substream_ds[0]
+			 * Playback DMA2 = playback_con_substream_ds[1]
+			 * Playback DMA3 = playback_con_substream_ds[2]
+			 * Playback DMA4 (SPDIF) = playback_con_substream
+			 * Record DMA0 = capture_pro_substream
+			 * Record DMA1 = capture_con_substream
+			 */
+			unsigned char mtstat = inb(ICEMT1724(ice, IRQ));
+			if (mtstat & VT1724_MULTI_PDMA0) {
+				if (ice->playback_pro_substream)
+					snd_pcm_period_elapsed(ice->playback_pro_substream);
+			}
+			if (mtstat & VT1724_MULTI_RDMA0) {
+				if (ice->capture_pro_substream)
+					snd_pcm_period_elapsed(ice->capture_pro_substream);
+			}
+			if (mtstat & VT1724_MULTI_PDMA1) {
+				if (ice->playback_con_substream_ds[0])
+					snd_pcm_period_elapsed(ice->playback_con_substream_ds[0]);
+			}
+			if (mtstat & VT1724_MULTI_PDMA2) {
+				if (ice->playback_con_substream_ds[1])
+					snd_pcm_period_elapsed(ice->playback_con_substream_ds[1]);
+			}
+			if (mtstat & VT1724_MULTI_PDMA3) {
+				if (ice->playback_con_substream_ds[2])
+					snd_pcm_period_elapsed(ice->playback_con_substream_ds[2]);
+			}
+			if (mtstat & VT1724_MULTI_PDMA4) {
+				if (ice->playback_con_substream)
+					snd_pcm_period_elapsed(ice->playback_con_substream);
+			}
+			if (mtstat & VT1724_MULTI_RDMA1) {
+				if (ice->capture_con_substream)
+					snd_pcm_period_elapsed(ice->capture_con_substream);
+			}
+			/* ack anyway to avoid freeze */
+			outb(mtstat, ICEMT1724(ice, IRQ));
+			/* ought to really handle this properly */
+			if (mtstat & VT1724_MULTI_FIFO_ERR) {
+				unsigned char fstat = inb(ICEMT1724(ice, DMA_FIFO_ERR));
+				outb(fstat, ICEMT1724(ice, DMA_FIFO_ERR));	
+				outb(VT1724_MULTI_FIFO_ERR | inb(ICEMT1724(ice, DMA_INT_MASK)), ICEMT1724(ice, DMA_INT_MASK));	
+				/* If I don't do this, I get machine lockup due to continual interrupts */
+			}
+
+		}
+	}
+	return IRQ_RETVAL(handled);
+}
+
+/*
+ *  PCM code - professional part (multitrack)
+ */
+
+static unsigned int rates[] = {
+	8000, 9600, 11025, 12000, 16000, 22050, 24000,
+	32000, 44100, 48000, 64000, 88200, 96000,
+	176400, 192000,
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_rates_96 = {
+	.count = ARRAY_SIZE(rates) - 2, /* up to 96000 */
+	.list = rates,
+	.mask = 0,
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_rates_48 = {
+	.count = ARRAY_SIZE(rates) - 5, /* up to 48000 */
+	.list = rates,
+	.mask = 0,
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_rates_192 = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+struct vt1724_pcm_reg {
+	unsigned int addr;	/* ADDR register offset */
+	unsigned int size;	/* SIZE register offset */
+	unsigned int count;	/* COUNT register offset */
+	unsigned int start;	/* start & pause bit */
+};
+
+static int snd_vt1724_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	unsigned char what;
+	unsigned char old;
+	struct snd_pcm_substream *s;
+
+	what = 0;
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (snd_pcm_substream_chip(s) == ice) {
+			const struct vt1724_pcm_reg *reg;
+			reg = s->runtime->private_data;
+			what |= reg->start;
+			snd_pcm_trigger_done(s, substream);
+		}
+	}
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		spin_lock(&ice->reg_lock);
+		old = inb(ICEMT1724(ice, DMA_PAUSE));
+		if (cmd == SNDRV_PCM_TRIGGER_PAUSE_PUSH)
+			old |= what;
+		else
+			old &= ~what;
+		outb(old, ICEMT1724(ice, DMA_PAUSE));
+		spin_unlock(&ice->reg_lock);
+		break;
+
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_STOP:
+		spin_lock(&ice->reg_lock);
+		old = inb(ICEMT1724(ice, DMA_CONTROL));
+		if (cmd == SNDRV_PCM_TRIGGER_START)
+			old |= what;
+		else
+			old &= ~what;
+		outb(old, ICEMT1724(ice, DMA_CONTROL));
+		spin_unlock(&ice->reg_lock);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ */
+
+#define DMA_STARTS	(VT1724_RDMA0_START|VT1724_PDMA0_START|VT1724_RDMA1_START|\
+	VT1724_PDMA1_START|VT1724_PDMA2_START|VT1724_PDMA3_START|VT1724_PDMA4_START)
+#define DMA_PAUSES	(VT1724_RDMA0_PAUSE|VT1724_PDMA0_PAUSE|VT1724_RDMA1_PAUSE|\
+	VT1724_PDMA1_PAUSE|VT1724_PDMA2_PAUSE|VT1724_PDMA3_PAUSE|VT1724_PDMA4_PAUSE)
+
+static int get_max_rate(struct snd_ice1712 *ice)
+{
+	if (ice->eeprom.data[ICE_EEP2_ACLINK] & VT1724_CFG_PRO_I2S) {
+		if ((ice->eeprom.data[ICE_EEP2_I2S] & 0x08) && !ice->vt1720)
+			return 192000;
+		else
+			return 96000;
+	} else
+		return 48000;
+}
+
+static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
+				    int force)
+{
+	unsigned long flags;
+	unsigned char val, old;
+	unsigned int i, mclk_change;
+
+	printk(KERN_DEBUG
+	       "ice1712: set_pro_rate, rate=%i, max_rate=%i, force=%i, "
+	       "locked=%i\n",
+	       rate, get_max_rate(ice), force, is_pro_rate_locked(ice));
+
+	if (rate > get_max_rate(ice))
+		return -EINVAL;
+
+	switch (rate) {
+	case 8000: val = 6; break;
+	case 9600: val = 3; break;
+	case 11025: val = 10; break;
+	case 12000: val = 2; break;
+	case 16000: val = 5; break;
+	case 22050: val = 9; break;
+	case 24000: val = 1; break;
+	case 32000: val = 4; break;
+	case 44100: val = 8; break;
+	case 48000: val = 0; break;
+	case 64000: val = 15; break;
+	case 88200: val = 11; break;
+	case 96000: val = 7; break;
+	case 176400: val = 12; break;
+	case 192000: val = 14; break;
+	default:
+		snd_BUG();
+		val = 0;
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&ice->reg_lock, flags);
+	if ((inb(ICEMT1724(ice, DMA_CONTROL)) & DMA_STARTS) || 
+	    (inb(ICEMT1724(ice, DMA_PAUSE)) & DMA_PAUSES)) {
+		/* running? we cannot change the rate now... */
+		spin_unlock_irqrestore(&ice->reg_lock, flags);
+		return -EBUSY;
+	}
+	if (!force && is_pro_rate_locked(ice)) {
+		spin_unlock_irqrestore(&ice->reg_lock, flags);
+		return (rate == ice->cur_rate) ? 0 : -EBUSY;
+	}
+
+	old = inb(ICEMT1724(ice, RATE));
+	if (force || old != val)
+		outb(val, ICEMT1724(ice, RATE));
+	else if (rate == ice->cur_rate) {
+		spin_unlock_irqrestore(&ice->reg_lock, flags);
+		return 0;
+	}
+
+	ice->cur_rate = rate;
+
+	/* check MT02 */
+	mclk_change = 0;
+	if (ice->eeprom.data[ICE_EEP2_ACLINK] & VT1724_CFG_PRO_I2S) {
+		val = old = inb(ICEMT1724(ice, I2S_FORMAT));
+		if (rate > 96000)
+			val |= VT1724_MT_I2S_MCLK_128X; /* 128x MCLK */
+		else
+			val &= ~VT1724_MT_I2S_MCLK_128X; /* 256x MCLK */
+		if (val != old) {
+			outb(val, ICEMT1724(ice, I2S_FORMAT));
+			mclk_change = 1;
+		}
+	}
+	spin_unlock_irqrestore(&ice->reg_lock, flags);
+
+	if (mclk_change && ice->gpio.i2s_mclk_changed)
+		ice->gpio.i2s_mclk_changed(ice);
+	if (ice->gpio.set_pro_rate)
+		ice->gpio.set_pro_rate(ice, rate);
+
+	/* set up codecs */
+	for (i = 0; i < ice->akm_codecs; i++) {
+		if (ice->akm[i].ops.set_rate_val)
+			ice->akm[i].ops.set_rate_val(&ice->akm[i], rate);
+	}
+	if (ice->spdif.ops.setup_rate)
+		ice->spdif.ops.setup_rate(ice, rate);
+
+	return 0;
+}
+
+static int snd_vt1724_pcm_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	int i, chs, err;
+
+	chs = params_channels(hw_params);
+	mutex_lock(&ice->open_mutex);
+	/* mark surround channels */
+	if (substream == ice->playback_pro_substream) {
+		/* PDMA0 can be multi-channel up to 8 */
+		chs = chs / 2 - 1;
+		for (i = 0; i < chs; i++) {
+			if (ice->pcm_reserved[i] &&
+			    ice->pcm_reserved[i] != substream) {
+				mutex_unlock(&ice->open_mutex);
+				return -EBUSY;
+			}
+			ice->pcm_reserved[i] = substream;
+		}
+		for (; i < 3; i++) {
+			if (ice->pcm_reserved[i] == substream)
+				ice->pcm_reserved[i] = NULL;
+		}
+	} else {
+		for (i = 0; i < 3; i++) {
+			/* check individual playback stream */
+			if (ice->playback_con_substream_ds[i] == substream) {
+				if (ice->pcm_reserved[i] &&
+				    ice->pcm_reserved[i] != substream) {
+					mutex_unlock(&ice->open_mutex);
+					return -EBUSY;
+				}
+				ice->pcm_reserved[i] = substream;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&ice->open_mutex);
+
+	err = snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
+	if ( err < 0 )
+		return err;
+
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_vt1724_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	int i;
+
+	mutex_lock(&ice->open_mutex);
+	/* unmark surround channels */
+	for (i = 0; i < 3; i++)
+		if (ice->pcm_reserved[i] == substream)
+			ice->pcm_reserved[i] = NULL;
+	mutex_unlock(&ice->open_mutex);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int snd_vt1724_playback_pro_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	unsigned char val;
+	unsigned int size;
+
+	spin_lock_irq(&ice->reg_lock);
+	val = (8 - substream->runtime->channels) >> 1;
+	outb(val, ICEMT1724(ice, BURST));
+
+	outl(substream->runtime->dma_addr, ICEMT1724(ice, PLAYBACK_ADDR));
+
+	size = (snd_pcm_lib_buffer_bytes(substream) >> 2) - 1;
+	// outl(size, ICEMT1724(ice, PLAYBACK_SIZE));
+	outw(size, ICEMT1724(ice, PLAYBACK_SIZE));
+	outb(size >> 16, ICEMT1724(ice, PLAYBACK_SIZE) + 2);
+	size = (snd_pcm_lib_period_bytes(substream) >> 2) - 1;
+	// outl(size, ICEMT1724(ice, PLAYBACK_COUNT));
+	outw(size, ICEMT1724(ice, PLAYBACK_COUNT));
+	outb(size >> 16, ICEMT1724(ice, PLAYBACK_COUNT) + 2);
+
+	spin_unlock_irq(&ice->reg_lock);
+
+	// printk("pro prepare: ch = %d, addr = 0x%x, buffer = 0x%x, period = 0x%x\n", substream->runtime->channels, (unsigned int)substream->runtime->dma_addr, snd_pcm_lib_buffer_bytes(substream), snd_pcm_lib_period_bytes(substream));
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_vt1724_playback_pro_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	size_t ptr;
+
+	if (!(inl(ICEMT1724(ice, DMA_CONTROL)) & VT1724_PDMA0_START))
+		return 0;
+#if 0 /* read PLAYBACK_ADDR */
+	ptr = inl(ICEMT1724(ice, PLAYBACK_ADDR));
+	if (ptr < substream->runtime->dma_addr) {
+		snd_printd("ice1724: invalid negative ptr\n");
+		return 0;
+	}
+	ptr -= substream->runtime->dma_addr;
+	ptr = bytes_to_frames(substream->runtime, ptr);
+	if (ptr >= substream->runtime->buffer_size) {
+		snd_printd("ice1724: invalid ptr %d (size=%d)\n",
+			   (int)ptr, (int)substream->runtime->period_size);
+		return 0;
+	}
+#else /* read PLAYBACK_SIZE */
+	ptr = inl(ICEMT1724(ice, PLAYBACK_SIZE)) & 0xffffff;
+	ptr = (ptr + 1) << 2;
+	ptr = bytes_to_frames(substream->runtime, ptr);
+	if (! ptr)
+		;
+	else if (ptr <= substream->runtime->buffer_size)
+		ptr = substream->runtime->buffer_size - ptr;
+	else {
+		snd_printd("ice1724: invalid ptr %d (size=%d)\n",
+			   (int)ptr, (int)substream->runtime->buffer_size);
+		ptr = 0;
+	}
+#endif
+	return ptr;
+}
+
+static int snd_vt1724_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
+
+	spin_lock_irq(&ice->reg_lock);
+	outl(substream->runtime->dma_addr, ice->profi_port + reg->addr);
+	outw((snd_pcm_lib_buffer_bytes(substream) >> 2) - 1,
+	     ice->profi_port + reg->size);
+	outw((snd_pcm_lib_period_bytes(substream) >> 2) - 1,
+	     ice->profi_port + reg->count);
+	spin_unlock_irq(&ice->reg_lock);
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_vt1724_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
+	size_t ptr;
+
+	if (!(inl(ICEMT1724(ice, DMA_CONTROL)) & reg->start))
+		return 0;
+#if 0 /* use ADDR register */
+	ptr = inl(ice->profi_port + reg->addr);
+	ptr -= substream->runtime->dma_addr;
+	return bytes_to_frames(substream->runtime, ptr);
+#else /* use SIZE register */
+	ptr = inw(ice->profi_port + reg->size);
+	ptr = (ptr + 1) << 2;
+	ptr = bytes_to_frames(substream->runtime, ptr);
+	if (! ptr)
+		;
+	else if (ptr <= substream->runtime->buffer_size)
+		ptr = substream->runtime->buffer_size - ptr;
+	else {
+		snd_printd("ice1724: invalid ptr %d (size=%d)\n",
+			   (int)ptr, (int)substream->runtime->buffer_size);
+		ptr = 0;
+	}
+	return ptr;
+#endif
+}
+
+static const struct vt1724_pcm_reg vt1724_pdma0_reg = {
+	.addr = VT1724_MT_PLAYBACK_ADDR,
+	.size = VT1724_MT_PLAYBACK_SIZE,
+	.count = VT1724_MT_PLAYBACK_COUNT,
+	.start = VT1724_PDMA0_START,
+};
+
+static const struct vt1724_pcm_reg vt1724_pdma4_reg = {
+	.addr = VT1724_MT_PDMA4_ADDR,
+	.size = VT1724_MT_PDMA4_SIZE,
+	.count = VT1724_MT_PDMA4_COUNT,
+	.start = VT1724_PDMA4_START,
+};
+
+static const struct vt1724_pcm_reg vt1724_rdma0_reg = {
+	.addr = VT1724_MT_CAPTURE_ADDR,
+	.size = VT1724_MT_CAPTURE_SIZE,
+	.count = VT1724_MT_CAPTURE_COUNT,
+	.start = VT1724_RDMA0_START,
+};
+
+static const struct vt1724_pcm_reg vt1724_rdma1_reg = {
+	.addr = VT1724_MT_RDMA1_ADDR,
+	.size = VT1724_MT_RDMA1_SIZE,
+	.count = VT1724_MT_RDMA1_COUNT,
+	.start = VT1724_RDMA1_START,
+};
+
+#define vt1724_playback_pro_reg vt1724_pdma0_reg
+#define vt1724_playback_spdif_reg vt1724_pdma4_reg
+#define vt1724_capture_pro_reg vt1724_rdma0_reg
+#define vt1724_capture_spdif_reg vt1724_rdma1_reg
+
+
+static const struct snd_pcm_hardware snd_vt1724_playback_pro =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID |
+				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_SYNC_START),
+	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_192000,
+	.rate_min =		8000,
+	.rate_max =		192000,
+	.channels_min =		2,
+	.channels_max =		8,
+	.buffer_bytes_max =	(1UL << 21),	/* 19bits dword */
+	.period_bytes_min =	8 * 4 * 2,	/* FIXME: constraints needed */
+	.period_bytes_max =	(1UL << 21),
+	.periods_min =		2,
+	.periods_max =		1024,
+};
+
+static const struct snd_pcm_hardware snd_vt1724_spdif =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID |
+				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_SYNC_START),
+	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
+	.rates =	        (SNDRV_PCM_RATE_32000|SNDRV_PCM_RATE_44100|
+				 SNDRV_PCM_RATE_48000|SNDRV_PCM_RATE_88200|
+				 SNDRV_PCM_RATE_96000|SNDRV_PCM_RATE_176400|
+				 SNDRV_PCM_RATE_192000),
+	.rate_min =		32000,
+	.rate_max =		192000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	(1UL << 18),	/* 16bits dword */
+	.period_bytes_min =	2 * 4 * 2,
+	.period_bytes_max =	(1UL << 18),
+	.periods_min =		2,
+	.periods_max =		1024,
+};
+
+static const struct snd_pcm_hardware snd_vt1724_2ch_stereo =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID |
+				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_SYNC_START),
+	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_192000,
+	.rate_min =		8000,
+	.rate_max =		192000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	(1UL << 18),	/* 16bits dword */
+	.period_bytes_min =	2 * 4 * 2,
+	.period_bytes_max =	(1UL << 18),
+	.periods_min =		2,
+	.periods_max =		1024,
+};
+
+/*
+ * set rate constraints
+ */
+static int set_rate_constraints(struct snd_ice1712 *ice,
+				struct snd_pcm_substream *substream,
+				unsigned char is_adc)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_hw_constraint_list *hw_rates;
+
+#if 0
+/*
+ * allow separate ADC/DAC rates - for ESI Maya44
+ * requires change in ice1712.h (struct ice definition)
+ * see ice1712.h.patch
+ */
+
+	hw_rates = (is_adc && ice->hw_rates_adc) ?
+			ice->hw_rates_adc : ice->hw_rates;
+
+	if (hw_rates) {
+		/* hardware specific */
+		runtime->hw.rate_min = hw_rates->list[0];
+		runtime->hw.rate_max = hw_rates->list[hw_rates->count - 1];
+		runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
+		return snd_pcm_hw_constraint_list(runtime, 0,
+						  SNDRV_PCM_HW_PARAM_RATE,
+						  hw_rates);
+	}
+#else
+/*
+ * original code - common rate set for ADC and DAC
+ */
+	if (ice->hw_rates) {
+		/* hardware specific */
+		runtime->hw.rate_min = ice->hw_rates->list[0];
+		runtime->hw.rate_max = ice->hw_rates->list[ice->hw_rates->count - 1];
+		runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
+		return snd_pcm_hw_constraint_list(runtime, 0,
+						  SNDRV_PCM_HW_PARAM_RATE,
+						  ice->hw_rates);
+	}
+#endif
+	if (ice->eeprom.data[ICE_EEP2_ACLINK] & VT1724_CFG_PRO_I2S) {
+		/* I2S */
+		/* VT1720 doesn't support more than 96kHz */
+		if ((ice->eeprom.data[ICE_EEP2_I2S] & 0x08) && !ice->vt1720)
+			return snd_pcm_hw_constraint_list(runtime, 0,
+							  SNDRV_PCM_HW_PARAM_RATE,
+							  &hw_constraints_rates_192);
+		else {
+			runtime->hw.rates = SNDRV_PCM_RATE_KNOT |
+				SNDRV_PCM_RATE_8000_96000;
+			runtime->hw.rate_max = 96000;
+			return snd_pcm_hw_constraint_list(runtime, 0,
+							  SNDRV_PCM_HW_PARAM_RATE,
+							  &hw_constraints_rates_96);
+		}
+	} else if (ice->ac97) {
+		/* ACLINK */
+		runtime->hw.rate_max = 48000;
+		runtime->hw.rates = SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000;
+		return snd_pcm_hw_constraint_list(runtime, 0,
+						  SNDRV_PCM_HW_PARAM_RATE,
+						  &hw_constraints_rates_48);
+	}
+	return 0;
+}
+
+/* multi-channel playback needs alignment 8x32bit regardless of the channels
+ * actually used
+ */
+#define VT1724_BUFFER_ALIGN	0x20
+
+static int snd_vt1724_playback_pro_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	int chs;
+
+	runtime->private_data = (void *)&vt1724_playback_pro_reg;
+	ice->playback_pro_substream = substream;
+	runtime->hw = snd_vt1724_playback_pro;
+	snd_pcm_set_sync(substream);
+	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	set_rate_constraints(ice, substream, 0);
+	mutex_lock(&ice->open_mutex);
+	/* calculate the currently available channels */
+	for (chs = 0; chs < 3; chs++) {
+		if (ice->pcm_reserved[chs])
+			break;
+	}
+	chs = (chs + 1) * 2;
+	runtime->hw.channels_max = chs;
+	if (chs > 2) /* channels must be even */
+		snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+	mutex_unlock(&ice->open_mutex);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	return 0;
+}
+
+static int snd_vt1724_capture_pro_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->private_data = (void *)&vt1724_capture_pro_reg;
+	ice->capture_pro_substream = substream;
+
+	runtime->hw = snd_vt1724_2ch_stereo;
+	snd_pcm_set_sync(substream);
+	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	set_rate_constraints(ice, substream, 1);
+
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	return 0;
+}
+
+static int snd_vt1724_playback_pro_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+
+	if (PRO_RATE_RESET)
+		snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 0);
+	ice->playback_pro_substream = NULL;
+
+	return 0;
+}
+
+static int snd_vt1724_capture_pro_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+
+	if (PRO_RATE_RESET)
+		snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 0);
+	ice->capture_pro_substream = NULL;
+
+	return 0;
+}
+
+static struct snd_pcm_ops snd_vt1724_playback_pro_ops = {
+	.open =		snd_vt1724_playback_pro_open,
+	.close =	snd_vt1724_playback_pro_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_vt1724_pcm_hw_params,
+	.hw_free =	snd_vt1724_pcm_hw_free,
+	.prepare =	snd_vt1724_playback_pro_prepare,
+	.trigger =	snd_vt1724_pcm_trigger,
+	.pointer =	snd_vt1724_playback_pro_pointer,
+};
+
+static struct snd_pcm_ops snd_vt1724_capture_pro_ops = {
+	.open =		snd_vt1724_capture_pro_open,
+	.close =	snd_vt1724_capture_pro_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_vt1724_pcm_hw_params,
+	.hw_free =	snd_vt1724_pcm_hw_free,
+	.prepare =	snd_vt1724_pcm_prepare,
+	.trigger =	snd_vt1724_pcm_trigger,
+	.pointer =	snd_vt1724_pcm_pointer,
+};
+
+static int __devinit snd_vt1724_pcm_profi(struct snd_ice1712 * ice, int device)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(ice->card, "ICE1724", device, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_vt1724_playback_pro_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_vt1724_capture_pro_ops);
+
+	pcm->private_data = ice;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "ICE1724");
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(ice->pci),
+					      256*1024, 256*1024);
+
+	ice->pcm_pro = pcm;
+
+	return 0;
+}
+
+
+/*
+ * SPDIF PCM
+ */
+
+/* update spdif control bits; call with reg_lock */
+static void update_spdif_bits(struct snd_ice1712 *ice, unsigned int val)
+{
+	unsigned char cbit, disabled;
+
+	cbit = inb(ICEREG1724(ice, SPDIF_CFG));
+	disabled = cbit & ~VT1724_CFG_SPDIF_OUT_EN;
+	if (cbit != disabled)
+		outb(disabled, ICEREG1724(ice, SPDIF_CFG));
+	outw(val, ICEMT1724(ice, SPDIF_CTRL));
+	if (cbit != disabled)
+		outb(cbit, ICEREG1724(ice, SPDIF_CFG));
+	outw(val, ICEMT1724(ice, SPDIF_CTRL));
+}
+
+/* update SPDIF control bits according to the given rate */
+static void update_spdif_rate(struct snd_ice1712 *ice, unsigned int rate)
+{
+	unsigned int val, nval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ice->reg_lock, flags);
+	nval = val = inw(ICEMT1724(ice, SPDIF_CTRL));
+	nval &= ~(7 << 12);
+	switch (rate) {
+	case 44100: break;
+	case 48000: nval |= 2 << 12; break;
+	case 32000: nval |= 3 << 12; break;
+	case 88200: nval |= 4 << 12; break;
+	case 96000: nval |= 5 << 12; break;
+	case 192000: nval |= 6 << 12; break;
+	case 176400: nval |= 7 << 12; break;
+	}
+	if (val != nval)
+		update_spdif_bits(ice, nval);
+	spin_unlock_irqrestore(&ice->reg_lock, flags);
+}
+
+static int snd_vt1724_playback_spdif_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	if (! ice->force_pdma4)
+		update_spdif_rate(ice, substream->runtime->rate);
+	return snd_vt1724_pcm_prepare(substream);
+}
+
+static int snd_vt1724_playback_spdif_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->private_data = (void *)&vt1724_playback_spdif_reg;
+	ice->playback_con_substream = substream;
+	if (ice->force_pdma4) {
+		runtime->hw = snd_vt1724_2ch_stereo;
+		set_rate_constraints(ice, substream, 0);
+	} else
+		runtime->hw = snd_vt1724_spdif;
+	snd_pcm_set_sync(substream);
+	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	return 0;
+}
+
+static int snd_vt1724_playback_spdif_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+
+	if (PRO_RATE_RESET)
+		snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 0);
+	ice->playback_con_substream = NULL;
+
+	return 0;
+}
+
+static int snd_vt1724_capture_spdif_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->private_data = (void *)&vt1724_capture_spdif_reg;
+	ice->capture_con_substream = substream;
+	if (ice->force_rdma1) {
+		runtime->hw = snd_vt1724_2ch_stereo;
+		set_rate_constraints(ice, substream, 1);
+	} else
+		runtime->hw = snd_vt1724_spdif;
+	snd_pcm_set_sync(substream);
+	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				   VT1724_BUFFER_ALIGN);
+	return 0;
+}
+
+static int snd_vt1724_capture_spdif_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+
+	if (PRO_RATE_RESET)
+		snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 0);
+	ice->capture_con_substream = NULL;
+
+	return 0;
+}
+
+static struct snd_pcm_ops snd_vt1724_playback_spdif_ops = {
+	.open =		snd_vt1724_playback_spdif_open,
+	.close =	snd_vt1724_playback_spdif_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_vt1724_pcm_hw_params,
+	.hw_free =	snd_vt1724_pcm_hw_free,
+	.prepare =	snd_vt1724_playback_spdif_prepare,
+	.trigger =	snd_vt1724_pcm_trigger,
+	.pointer =	snd_vt1724_pcm_pointer,
+};
+
+static struct snd_pcm_ops snd_vt1724_capture_spdif_ops = {
+	.open =		snd_vt1724_capture_spdif_open,
+	.close =	snd_vt1724_capture_spdif_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_vt1724_pcm_hw_params,
+	.hw_free =	snd_vt1724_pcm_hw_free,
+	.prepare =	snd_vt1724_pcm_prepare,
+	.trigger =	snd_vt1724_pcm_trigger,
+	.pointer =	snd_vt1724_pcm_pointer,
+};
+
+
+static int __devinit snd_vt1724_pcm_spdif(struct snd_ice1712 * ice, int device)
+{
+	char *name;
+	struct snd_pcm *pcm;
+	int play, capt;
+	int err;
+
+	if (ice->force_pdma4 ||
+	    (ice->eeprom.data[ICE_EEP2_SPDIF] & VT1724_CFG_SPDIF_OUT_INT)) {
+		play = 1;
+		ice->has_spdif = 1;
+	} else
+		play = 0;
+	if (ice->force_rdma1 ||
+	    (ice->eeprom.data[ICE_EEP2_SPDIF] & VT1724_CFG_SPDIF_IN)) {
+		capt = 1;
+		ice->has_spdif = 1;
+	} else
+		capt = 0;
+	if (! play && ! capt)
+		return 0; /* no spdif device */
+
+	if (ice->force_pdma4 || ice->force_rdma1)
+		name = "ICE1724 Secondary";
+	else
+		name = "ICE1724 IEC958";
+	err = snd_pcm_new(ice->card, name, device, play, capt, &pcm);
+	if (err < 0)
+		return err;
+
+	if (play)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				&snd_vt1724_playback_spdif_ops);
+	if (capt)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+				&snd_vt1724_capture_spdif_ops);
+
+	pcm->private_data = ice;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, name);
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(ice->pci),
+					      64*1024, 64*1024);
+
+	ice->pcm = pcm;
+
+	return 0;
+}
+
+
+/*
+ * independent surround PCMs
+ */
+
+static const struct vt1724_pcm_reg vt1724_playback_dma_regs[3] = {
+	{
+		.addr = VT1724_MT_PDMA1_ADDR,
+		.size = VT1724_MT_PDMA1_SIZE,
+		.count = VT1724_MT_PDMA1_COUNT,
+		.start = VT1724_PDMA1_START,
+	},
+	{
+		.addr = VT1724_MT_PDMA2_ADDR,
+		.size = VT1724_MT_PDMA2_SIZE,
+		.count = VT1724_MT_PDMA2_COUNT,
+		.start = VT1724_PDMA2_START,
+	},
+	{
+		.addr = VT1724_MT_PDMA3_ADDR,
+		.size = VT1724_MT_PDMA3_SIZE,
+		.count = VT1724_MT_PDMA3_COUNT,
+		.start = VT1724_PDMA3_START,
+	},
+};
+
+static int snd_vt1724_playback_indep_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	unsigned char val;
+
+	spin_lock_irq(&ice->reg_lock);
+	val = 3 - substream->number;
+	if (inb(ICEMT1724(ice, BURST)) < val)
+		outb(val, ICEMT1724(ice, BURST));
+	spin_unlock_irq(&ice->reg_lock);
+	return snd_vt1724_pcm_prepare(substream);
+}
+
+static int snd_vt1724_playback_indep_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	mutex_lock(&ice->open_mutex);
+	/* already used by PDMA0? */
+	if (ice->pcm_reserved[substream->number]) {
+		mutex_unlock(&ice->open_mutex);
+		return -EBUSY; /* FIXME: should handle blocking mode properly */
+	}
+	mutex_unlock(&ice->open_mutex);
+	runtime->private_data = (void *)&vt1724_playback_dma_regs[substream->number];
+	ice->playback_con_substream_ds[substream->number] = substream;
+	runtime->hw = snd_vt1724_2ch_stereo;
+	snd_pcm_set_sync(substream);
+	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	set_rate_constraints(ice, substream, 0);
+	return 0;
+}
+
+static int snd_vt1724_playback_indep_close(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+
+	if (PRO_RATE_RESET)
+		snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 0);
+	ice->playback_con_substream_ds[substream->number] = NULL;
+	ice->pcm_reserved[substream->number] = NULL;
+
+	return 0;
+}
+
+static struct snd_pcm_ops snd_vt1724_playback_indep_ops = {
+	.open =		snd_vt1724_playback_indep_open,
+	.close =	snd_vt1724_playback_indep_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_vt1724_pcm_hw_params,
+	.hw_free =	snd_vt1724_pcm_hw_free,
+	.prepare =	snd_vt1724_playback_indep_prepare,
+	.trigger =	snd_vt1724_pcm_trigger,
+	.pointer =	snd_vt1724_pcm_pointer,
+};
+
+
+static int __devinit snd_vt1724_pcm_indep(struct snd_ice1712 * ice, int device)
+{
+	struct snd_pcm *pcm;
+	int play;
+	int err;
+
+	play = ice->num_total_dacs / 2 - 1;
+	if (play <= 0)
+		return 0;
+
+	err = snd_pcm_new(ice->card, "ICE1724 Surrounds", device, play, 0, &pcm);
+	if (err < 0)
+		return err;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_vt1724_playback_indep_ops);
+
+	pcm->private_data = ice;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "ICE1724 Surround PCM");
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(ice->pci),
+					      64*1024, 64*1024);
+
+	ice->pcm_ds = pcm;
+
+	return 0;
+}
+
+
+/*
+ *  Mixer section
+ */
+
+static int __devinit snd_vt1724_ac97_mixer(struct snd_ice1712 * ice)
+{
+	int err;
+
+	if (! (ice->eeprom.data[ICE_EEP2_ACLINK] & VT1724_CFG_PRO_I2S)) {
+		struct snd_ac97_bus *pbus;
+		struct snd_ac97_template ac97;
+		static struct snd_ac97_bus_ops ops = {
+			.write = snd_vt1724_ac97_write,
+			.read = snd_vt1724_ac97_read,
+		};
+
+		/* cold reset */
+		outb(inb(ICEMT1724(ice, AC97_CMD)) | 0x80, ICEMT1724(ice, AC97_CMD));
+		mdelay(5); /* FIXME */
+		outb(inb(ICEMT1724(ice, AC97_CMD)) & ~0x80, ICEMT1724(ice, AC97_CMD));
+
+		if ((err = snd_ac97_bus(ice->card, 0, &ops, NULL, &pbus)) < 0)
+			return err;
+		memset(&ac97, 0, sizeof(ac97));
+		ac97.private_data = ice;
+		if ((err = snd_ac97_mixer(pbus, &ac97, &ice->ac97)) < 0)
+			printk(KERN_WARNING "ice1712: cannot initialize pro ac97, skipped\n");
+		else
+			return 0;
+	}
+	/* I2S mixer only */
+	strcat(ice->card->mixername, "ICE1724 - multitrack");
+	return 0;
+}
+
+/*
+ *
+ */
+
+static inline unsigned int eeprom_triple(struct snd_ice1712 *ice, int idx)
+{
+	return (unsigned int)ice->eeprom.data[idx] | \
+		((unsigned int)ice->eeprom.data[idx + 1] << 8) | \
+		((unsigned int)ice->eeprom.data[idx + 2] << 16);
+}
+
+static void snd_vt1724_proc_read(struct snd_info_entry *entry, 
+				 struct snd_info_buffer *buffer)
+{
+	struct snd_ice1712 *ice = entry->private_data;
+	unsigned int idx;
+
+	snd_iprintf(buffer, "%s\n\n", ice->card->longname);
+	snd_iprintf(buffer, "EEPROM:\n");
+
+	snd_iprintf(buffer, "  Subvendor        : 0x%x\n", ice->eeprom.subvendor);
+	snd_iprintf(buffer, "  Size             : %i bytes\n", ice->eeprom.size);
+	snd_iprintf(buffer, "  Version          : %i\n", ice->eeprom.version);
+	snd_iprintf(buffer, "  System Config    : 0x%x\n",
+		    ice->eeprom.data[ICE_EEP2_SYSCONF]);
+	snd_iprintf(buffer, "  ACLink           : 0x%x\n",
+		    ice->eeprom.data[ICE_EEP2_ACLINK]);
+	snd_iprintf(buffer, "  I2S              : 0x%x\n",
+		    ice->eeprom.data[ICE_EEP2_I2S]);
+	snd_iprintf(buffer, "  S/PDIF           : 0x%x\n",
+		    ice->eeprom.data[ICE_EEP2_SPDIF]);
+	snd_iprintf(buffer, "  GPIO direction   : 0x%x\n",
+		    ice->eeprom.gpiodir);
+	snd_iprintf(buffer, "  GPIO mask        : 0x%x\n",
+		    ice->eeprom.gpiomask);
+	snd_iprintf(buffer, "  GPIO state       : 0x%x\n",
+		    ice->eeprom.gpiostate);
+	for (idx = 0x12; idx < ice->eeprom.size; idx++)
+		snd_iprintf(buffer, "  Extra #%02i        : 0x%x\n",
+			    idx, ice->eeprom.data[idx]);
+
+	snd_iprintf(buffer, "\nRegisters:\n");
+
+	snd_iprintf(buffer, "  PSDOUT03 : 0x%08x\n",
+		    (unsigned)inl(ICEMT1724(ice, ROUTE_PLAYBACK)));
+	for (idx = 0x0; idx < 0x20 ; idx++)
+		snd_iprintf(buffer, "  CCS%02x    : 0x%02x\n",
+			    idx, inb(ice->port+idx));
+	for (idx = 0x0; idx < 0x30 ; idx++)
+		snd_iprintf(buffer, "  MT%02x     : 0x%02x\n",
+			    idx, inb(ice->profi_port+idx));
+}
+
+static void __devinit snd_vt1724_proc_init(struct snd_ice1712 * ice)
+{
+	struct snd_info_entry *entry;
+
+	if (! snd_card_proc_new(ice->card, "ice1724", &entry))
+		snd_info_set_text_ops(entry, ice, snd_vt1724_proc_read);
+}
+
+/*
+ *
+ */
+
+static int snd_vt1724_eeprom_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = sizeof(struct snd_ice1712_eeprom);
+	return 0;
+}
+
+static int snd_vt1724_eeprom_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	
+	memcpy(ucontrol->value.bytes.data, &ice->eeprom, sizeof(ice->eeprom));
+	return 0;
+}
+
+static struct snd_kcontrol_new snd_vt1724_eeprom __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.name = "ICE1724 EEPROM",
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_vt1724_eeprom_info,
+	.get = snd_vt1724_eeprom_get
+};
+
+/*
+ */
+static int snd_vt1724_spdif_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static unsigned int encode_spdif_bits(struct snd_aes_iec958 *diga)
+{
+	unsigned int val, rbits;
+
+	val = diga->status[0] & 0x03; /* professional, non-audio */
+	if (val & 0x01) {
+		/* professional */
+		if ((diga->status[0] & IEC958_AES0_PRO_EMPHASIS) ==
+		    IEC958_AES0_PRO_EMPHASIS_5015)
+			val |= 1U << 3;
+		rbits = (diga->status[4] >> 3) & 0x0f;
+		if (rbits) {
+			switch (rbits) {
+			case 2: val |= 5 << 12; break; /* 96k */
+			case 3: val |= 6 << 12; break; /* 192k */
+			case 10: val |= 4 << 12; break; /* 88.2k */
+			case 11: val |= 7 << 12; break; /* 176.4k */
+			}
+		} else {
+			switch (diga->status[0] & IEC958_AES0_PRO_FS) {
+			case IEC958_AES0_PRO_FS_44100:
+				break;
+			case IEC958_AES0_PRO_FS_32000:
+				val |= 3U << 12;
+				break;
+			default:
+				val |= 2U << 12;
+				break;
+			}
+		}
+	} else {
+		/* consumer */
+		val |= diga->status[1] & 0x04; /* copyright */
+		if ((diga->status[0] & IEC958_AES0_CON_EMPHASIS) ==
+		    IEC958_AES0_CON_EMPHASIS_5015)
+			val |= 1U << 3;
+		val |= (unsigned int)(diga->status[1] & 0x3f) << 4; /* category */
+		val |= (unsigned int)(diga->status[3] & IEC958_AES3_CON_FS) << 12; /* fs */
+	}
+	return val;
+}
+
+static void decode_spdif_bits(struct snd_aes_iec958 *diga, unsigned int val)
+{
+	memset(diga->status, 0, sizeof(diga->status));
+	diga->status[0] = val & 0x03; /* professional, non-audio */
+	if (val & 0x01) {
+		/* professional */
+		if (val & (1U << 3))
+			diga->status[0] |= IEC958_AES0_PRO_EMPHASIS_5015;
+		switch ((val >> 12) & 0x7) {
+		case 0:
+			break;
+		case 2:
+			diga->status[0] |= IEC958_AES0_PRO_FS_32000;
+			break;
+		default:
+			diga->status[0] |= IEC958_AES0_PRO_FS_48000;
+			break;
+		}
+	} else {
+		/* consumer */
+		diga->status[0] |= val & (1U << 2); /* copyright */
+		if (val & (1U << 3))
+			diga->status[0] |= IEC958_AES0_CON_EMPHASIS_5015;
+		diga->status[1] |= (val >> 4) & 0x3f; /* category */
+		diga->status[3] |= (val >> 12) & 0x07; /* fs */
+	}
+}
+
+static int snd_vt1724_spdif_default_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	val = inw(ICEMT1724(ice, SPDIF_CTRL));
+	decode_spdif_bits(&ucontrol->value.iec958, val);
+	return 0;
+}
+
+static int snd_vt1724_spdif_default_put(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	unsigned int val, old;
+
+	val = encode_spdif_bits(&ucontrol->value.iec958);
+	spin_lock_irq(&ice->reg_lock);
+	old = inw(ICEMT1724(ice, SPDIF_CTRL));
+	if (val != old)
+		update_spdif_bits(ice, val);
+	spin_unlock_irq(&ice->reg_lock);
+	return (val != old);
+}
+
+static struct snd_kcontrol_new snd_vt1724_spdif_default __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.info =		snd_vt1724_spdif_info,
+	.get =		snd_vt1724_spdif_default_get,
+	.put =		snd_vt1724_spdif_default_put
+};
+
+static int snd_vt1724_spdif_maskc_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.iec958.status[0] = IEC958_AES0_NONAUDIO |
+						     IEC958_AES0_PROFESSIONAL |
+						     IEC958_AES0_CON_NOT_COPYRIGHT |
+						     IEC958_AES0_CON_EMPHASIS;
+	ucontrol->value.iec958.status[1] = IEC958_AES1_CON_ORIGINAL |
+						     IEC958_AES1_CON_CATEGORY;
+	ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
+	return 0;
+}
+
+static int snd_vt1724_spdif_maskp_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.iec958.status[0] = IEC958_AES0_NONAUDIO |
+						     IEC958_AES0_PROFESSIONAL |
+						     IEC958_AES0_PRO_FS |
+						     IEC958_AES0_PRO_EMPHASIS;
+	return 0;
+}
+
+static struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
+	.info =		snd_vt1724_spdif_info,
+	.get =		snd_vt1724_spdif_maskc_get,
+};
+
+static struct snd_kcontrol_new snd_vt1724_spdif_maskp __devinitdata =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,PRO_MASK),
+	.info =		snd_vt1724_spdif_info,
+	.get =		snd_vt1724_spdif_maskp_get,
+};
+
+#define snd_vt1724_spdif_sw_info		snd_ctl_boolean_mono_info
+
+static int snd_vt1724_spdif_sw_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = inb(ICEREG1724(ice, SPDIF_CFG)) &
+		VT1724_CFG_SPDIF_OUT_EN ? 1 : 0;
+	return 0;
+}
+
+static int snd_vt1724_spdif_sw_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	unsigned char old, val;
+
+	spin_lock_irq(&ice->reg_lock);
+	old = val = inb(ICEREG1724(ice, SPDIF_CFG));
+	val &= ~VT1724_CFG_SPDIF_OUT_EN;
+	if (ucontrol->value.integer.value[0])
+		val |= VT1724_CFG_SPDIF_OUT_EN;
+	if (old != val)
+		outb(val, ICEREG1724(ice, SPDIF_CFG));
+	spin_unlock_irq(&ice->reg_lock);
+	return old != val;
+}
+
+static struct snd_kcontrol_new snd_vt1724_spdif_switch __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	/* FIXME: the following conflict with IEC958 Playback Route */
+	// .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH),
+	.name =         SNDRV_CTL_NAME_IEC958("Output ",NONE,SWITCH),
+	.info =		snd_vt1724_spdif_sw_info,
+	.get =		snd_vt1724_spdif_sw_get,
+	.put =		snd_vt1724_spdif_sw_put
+};
+
+
+#if 0 /* NOT USED YET */
+/*
+ * GPIO access from extern
+ */
+
+#define snd_vt1724_gpio_info		snd_ctl_boolean_mono_info
+
+int snd_vt1724_gpio_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int shift = kcontrol->private_value & 0xff;
+	int invert = (kcontrol->private_value & (1<<24)) ? 1 : 0;
+	
+	snd_ice1712_save_gpio_status(ice);
+	ucontrol->value.integer.value[0] =
+		(snd_ice1712_gpio_read(ice) & (1 << shift) ? 1 : 0) ^ invert;
+	snd_ice1712_restore_gpio_status(ice);
+	return 0;
+}
+
+int snd_ice1712_gpio_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int shift = kcontrol->private_value & 0xff;
+	int invert = (kcontrol->private_value & (1<<24)) ? mask : 0;
+	unsigned int val, nval;
+
+	if (kcontrol->private_value & (1 << 31))
+		return -EPERM;
+	nval = (ucontrol->value.integer.value[0] ? (1 << shift) : 0) ^ invert;
+	snd_ice1712_save_gpio_status(ice);
+	val = snd_ice1712_gpio_read(ice);
+	nval |= val & ~(1 << shift);
+	if (val != nval)
+		snd_ice1712_gpio_write(ice, nval);
+	snd_ice1712_restore_gpio_status(ice);
+	return val != nval;
+}
+#endif /* NOT USED YET */
+
+/*
+ *  rate
+ */
+static int snd_vt1724_pro_internal_clock_info(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts_1724[] = {
+		"8000",		/* 0: 6 */
+		"9600",		/* 1: 3 */
+		"11025",	/* 2: 10 */
+		"12000",	/* 3: 2 */
+		"16000",	/* 4: 5 */
+		"22050",	/* 5: 9 */
+		"24000",	/* 6: 1 */
+		"32000",	/* 7: 4 */
+		"44100",	/* 8: 8 */
+		"48000",	/* 9: 0 */
+		"64000",	/* 10: 15 */
+		"88200",	/* 11: 11 */
+		"96000",	/* 12: 7 */
+		"176400",	/* 13: 12 */
+		"192000",	/* 14: 14 */
+		"IEC958 Input",	/* 15: -- */
+	};
+	static const char * const texts_1720[] = {
+		"8000",		/* 0: 6 */
+		"9600",		/* 1: 3 */
+		"11025",	/* 2: 10 */
+		"12000",	/* 3: 2 */
+		"16000",	/* 4: 5 */
+		"22050",	/* 5: 9 */
+		"24000",	/* 6: 1 */
+		"32000",	/* 7: 4 */
+		"44100",	/* 8: 8 */
+		"48000",	/* 9: 0 */
+		"64000",	/* 10: 15 */
+		"88200",	/* 11: 11 */
+		"96000",	/* 12: 7 */
+		"IEC958 Input",	/* 13: -- */
+	};
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = ice->vt1720 ? 14 : 16;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       ice->vt1720 ? texts_1720[uinfo->value.enumerated.item] :
+	       texts_1724[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_vt1724_pro_internal_clock_get(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	static const unsigned char xlate[16] = {
+		9, 6, 3, 1, 7, 4, 0, 12, 8, 5, 2, 11, 13, 255, 14, 10
+	};
+	unsigned char val;
+	
+	spin_lock_irq(&ice->reg_lock);
+	if (is_spdif_master(ice)) {
+		ucontrol->value.enumerated.item[0] = ice->vt1720 ? 13 : 15;
+	} else {
+		val = xlate[inb(ICEMT1724(ice, RATE)) & 15];
+		if (val == 255) {
+			snd_BUG();
+			val = 0;
+		}
+		ucontrol->value.enumerated.item[0] = val;
+	}
+	spin_unlock_irq(&ice->reg_lock);
+	return 0;
+}
+
+static int snd_vt1724_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	unsigned char oval;
+	int rate;
+	int change = 0;
+	int spdif = ice->vt1720 ? 13 : 15;
+
+	spin_lock_irq(&ice->reg_lock);
+	oval = inb(ICEMT1724(ice, RATE));
+	if (ucontrol->value.enumerated.item[0] == spdif) {
+		unsigned char i2s_oval;
+		outb(oval | VT1724_SPDIF_MASTER, ICEMT1724(ice, RATE));
+		/* setting 256fs */
+		i2s_oval = inb(ICEMT1724(ice, I2S_FORMAT));
+		outb(i2s_oval & ~VT1724_MT_I2S_MCLK_128X,
+		     ICEMT1724(ice, I2S_FORMAT));
+	} else {
+		rate = rates[ucontrol->value.integer.value[0] % 15];
+		if (rate <= get_max_rate(ice)) {
+			PRO_RATE_DEFAULT = rate;
+			spin_unlock_irq(&ice->reg_lock);
+			snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 1);
+			spin_lock_irq(&ice->reg_lock);
+		}
+	}
+	change = inb(ICEMT1724(ice, RATE)) != oval;
+	spin_unlock_irq(&ice->reg_lock);
+
+	if ((oval & VT1724_SPDIF_MASTER) !=
+	    (inb(ICEMT1724(ice, RATE)) & VT1724_SPDIF_MASTER)) {
+		/* notify akm chips as well */
+		if (is_spdif_master(ice)) {
+			unsigned int i;
+			for (i = 0; i < ice->akm_codecs; i++) {
+				if (ice->akm[i].ops.set_rate_val)
+					ice->akm[i].ops.set_rate_val(&ice->akm[i], 0);
+			}
+		}
+	}
+	return change;
+}
+
+static struct snd_kcontrol_new snd_vt1724_pro_internal_clock __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Multi Track Internal Clock",
+	.info = snd_vt1724_pro_internal_clock_info,
+	.get = snd_vt1724_pro_internal_clock_get,
+	.put = snd_vt1724_pro_internal_clock_put
+};
+
+#define snd_vt1724_pro_rate_locking_info	snd_ctl_boolean_mono_info
+
+static int snd_vt1724_pro_rate_locking_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = PRO_RATE_LOCKED;
+	return 0;
+}
+
+static int snd_vt1724_pro_rate_locking_put(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int change = 0, nval;
+
+	nval = ucontrol->value.integer.value[0] ? 1 : 0;
+	spin_lock_irq(&ice->reg_lock);
+	change = PRO_RATE_LOCKED != nval;
+	PRO_RATE_LOCKED = nval;
+	spin_unlock_irq(&ice->reg_lock);
+	return change;
+}
+
+static struct snd_kcontrol_new snd_vt1724_pro_rate_locking __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Multi Track Rate Locking",
+	.info = snd_vt1724_pro_rate_locking_info,
+	.get = snd_vt1724_pro_rate_locking_get,
+	.put = snd_vt1724_pro_rate_locking_put
+};
+
+#define snd_vt1724_pro_rate_reset_info		snd_ctl_boolean_mono_info
+
+static int snd_vt1724_pro_rate_reset_get(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = PRO_RATE_RESET ? 1 : 0;
+	return 0;
+}
+
+static int snd_vt1724_pro_rate_reset_put(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int change = 0, nval;
+
+	nval = ucontrol->value.integer.value[0] ? 1 : 0;
+	spin_lock_irq(&ice->reg_lock);
+	change = PRO_RATE_RESET != nval;
+	PRO_RATE_RESET = nval;
+	spin_unlock_irq(&ice->reg_lock);
+	return change;
+}
+
+static struct snd_kcontrol_new snd_vt1724_pro_rate_reset __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Multi Track Rate Reset",
+	.info = snd_vt1724_pro_rate_reset_info,
+	.get = snd_vt1724_pro_rate_reset_get,
+	.put = snd_vt1724_pro_rate_reset_put
+};
+
+
+/*
+ * routing
+ */
+static int snd_vt1724_pro_route_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = {
+		"PCM Out", /* 0 */
+		"H/W In 0", "H/W In 1", /* 1-2 */
+		"IEC958 In L", "IEC958 In R", /* 3-4 */
+	};
+	
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 5;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+/*
+ * spcial routing for MAYA44
+ */
+static int snd_vt1724_pro_route_maya44_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = {
+		"PCM Out", /* 0 */
+		"Input 1", "Input 2", "Input 3", "Input 4"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 5;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item =
+			uinfo->value.enumerated.items - 1;
+
+	strcpy(uinfo->value.enumerated.name,
+					texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static inline int analog_route_shift(int idx)
+{
+	return (idx % 2) * 12 + ((idx / 2) * 3) + 8;
+}
+
+static inline int digital_route_shift(int idx)
+{
+	return idx * 3;
+}
+
+static inline int maya44_route_shift(int idx)
+{
+	static const unsigned char shift[10] =
+				{ 8, 20, 0, 3, 11, 23, 14, 26, 17, 29 };
+	return shift[idx%10];
+}
+
+static int get_route_val(struct snd_ice1712 *ice, int shift)
+{
+	unsigned long val;
+	unsigned char eitem;
+	static const unsigned char xlate[8] = {
+		0, 255, 1, 2, 255, 255, 3, 4,
+	};
+
+	val = inl(ICEMT1724(ice, ROUTE_PLAYBACK));
+	val >>= shift;
+	val &= 7;	//we now have 3 bits per output
+	eitem = xlate[val];
+	if (eitem == 255) {
+		snd_BUG();
+		return 0;
+	}
+	return eitem;
+}
+
+static int put_route_val(struct snd_ice1712 *ice, unsigned int val, int shift)
+{
+	unsigned int old_val, nval;
+	int change;
+	static const unsigned char xroute[8] = {
+		0, /* PCM */
+		2, /* PSDIN0 Left */
+		3, /* PSDIN0 Right */
+		6, /* SPDIN Left */
+		7, /* SPDIN Right */
+	};
+
+	nval = xroute[val % 5];
+	val = old_val = inl(ICEMT1724(ice, ROUTE_PLAYBACK));
+	val &= ~(0x07 << shift);
+	val |= nval << shift;
+	change = val != old_val;
+	if (change)
+		outl(val, ICEMT1724(ice, ROUTE_PLAYBACK));
+	return change;
+}
+
+static int snd_vt1724_pro_route_analog_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	ucontrol->value.enumerated.item[0] =
+		get_route_val(ice, analog_route_shift(idx));
+	return 0;
+}
+
+static int snd_vt1724_pro_route_analog_put(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	return put_route_val(ice, ucontrol->value.enumerated.item[0],
+			     analog_route_shift(idx));
+}
+
+static int snd_vt1724_pro_route_spdif_get(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	ucontrol->value.enumerated.item[0] =
+		get_route_val(ice, digital_route_shift(idx));
+	return 0;
+}
+
+static int snd_vt1724_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	return put_route_val(ice, ucontrol->value.enumerated.item[0],
+			     digital_route_shift(idx));
+}
+
+static int snd_vt1724_pro_route_maya44_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	ucontrol->value.enumerated.item[0] =
+		get_route_val(ice, maya44_route_shift(idx));
+	return 0;
+}
+
+static int snd_vt1724_pro_route_maya44_put(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	return put_route_val(ice, ucontrol->value.enumerated.item[0],
+			     maya44_route_shift(idx));
+}
+
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata =
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "H/W Playback Route",
+	.info = snd_vt1724_pro_route_info,
+	.get = snd_vt1724_pro_route_analog_get,
+	.put = snd_vt1724_pro_route_analog_put,
+};
+
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_maya44_route __devinitdata =
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "H/W Playback Route",
+	.info = snd_vt1724_pro_route_maya44_info,
+	.get = snd_vt1724_pro_route_maya44_get,
+	.put = snd_vt1724_pro_route_maya44_put,
+#if 1
+	.count = 10  /* XXX check whether controls 5-9 have any meaning */
+#else
+	.count = 4
+#endif
+};
+
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Route",
+	.info = snd_vt1724_pro_route_info,
+	.get = snd_vt1724_pro_route_spdif_get,
+	.put = snd_vt1724_pro_route_spdif_put,
+	.count = 2,
+};
+
+
+static int snd_vt1724_pro_peak_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 22; /* FIXME: for compatibility with ice1712... */
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 255;
+	return 0;
+}
+
+static int snd_vt1724_pro_peak_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx;
+	
+	spin_lock_irq(&ice->reg_lock);
+	for (idx = 0; idx < 22; idx++) {
+		outb(idx, ICEMT1724(ice, MONITOR_PEAKINDEX));
+		ucontrol->value.integer.value[idx] =
+			inb(ICEMT1724(ice, MONITOR_PEAKDATA));
+	}
+	spin_unlock_irq(&ice->reg_lock);
+	return 0;
+}
+
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Multi Track Peak",
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info = snd_vt1724_pro_peak_info,
+	.get = snd_vt1724_pro_peak_get
+};
+
+/*
+ *
+ */
+
+static struct snd_ice1712_card_info no_matched __devinitdata;
+
+static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
+	snd_vt1724_revo_cards,
+	snd_vt1724_amp_cards, 
+	snd_vt1724_aureon_cards,
+	snd_vt1720_mobo_cards,
+	snd_vt1720_pontis_cards,
+	snd_vt1724_prodigy_hifi_cards,
+	snd_vt1724_prodigy192_cards,
+	snd_vt1724_juli_cards,
+	snd_vt1724_maya44_cards,
+	snd_vt1724_phase_cards,
+	snd_vt1724_wtm_cards,
+	snd_vt1724_se_cards,
+	NULL,
+};
+
+
+/*
+ */
+
+static void wait_i2c_busy(struct snd_ice1712 *ice)
+{
+	int t = 0x10000;
+	while ((inb(ICEREG1724(ice, I2C_CTRL)) & VT1724_I2C_BUSY) && t--)
+		;
+	if (t == -1)
+		printk(KERN_ERR "ice1724: i2c busy timeout\n");
+}
+
+unsigned char snd_vt1724_read_i2c(struct snd_ice1712 *ice,
+				  unsigned char dev, unsigned char addr)
+{
+	unsigned char val;
+
+	mutex_lock(&ice->i2c_mutex);
+	wait_i2c_busy(ice);
+	outb(addr, ICEREG1724(ice, I2C_BYTE_ADDR));
+	outb(dev & ~VT1724_I2C_WRITE, ICEREG1724(ice, I2C_DEV_ADDR));
+	wait_i2c_busy(ice);
+	val = inb(ICEREG1724(ice, I2C_DATA));
+	mutex_unlock(&ice->i2c_mutex);
+	//printk("i2c_read: [0x%x,0x%x] = 0x%x\n", dev, addr, val);
+	return val;
+}
+
+void snd_vt1724_write_i2c(struct snd_ice1712 *ice,
+			  unsigned char dev, unsigned char addr, unsigned char data)
+{
+	mutex_lock(&ice->i2c_mutex);
+	wait_i2c_busy(ice);
+	//printk("i2c_write: [0x%x,0x%x] = 0x%x\n", dev, addr, data);
+	outb(addr, ICEREG1724(ice, I2C_BYTE_ADDR));
+	outb(data, ICEREG1724(ice, I2C_DATA));
+	outb(dev | VT1724_I2C_WRITE, ICEREG1724(ice, I2C_DEV_ADDR));
+	wait_i2c_busy(ice);
+	mutex_unlock(&ice->i2c_mutex);
+}
+
+static int __devinit snd_vt1724_read_eeprom(struct snd_ice1712 *ice,
+					    const char *modelname)
+{
+	const int dev = 0xa0;		/* EEPROM device address */
+	unsigned int i, size;
+	struct snd_ice1712_card_info * const *tbl, *c;
+
+	if (! modelname || ! *modelname) {
+		ice->eeprom.subvendor = 0;
+		if ((inb(ICEREG1724(ice, I2C_CTRL)) & VT1724_I2C_EEPROM) != 0)
+			ice->eeprom.subvendor =
+				(snd_vt1724_read_i2c(ice, dev, 0x00) << 0) |
+				(snd_vt1724_read_i2c(ice, dev, 0x01) << 8) | 
+				(snd_vt1724_read_i2c(ice, dev, 0x02) << 16) | 
+				(snd_vt1724_read_i2c(ice, dev, 0x03) << 24);
+		if (ice->eeprom.subvendor == 0 ||
+		    ice->eeprom.subvendor == (unsigned int)-1) {
+			/* invalid subvendor from EEPROM, try the PCI
+			 * subststem ID instead
+			 */
+			u16 vendor, device;
+			pci_read_config_word(ice->pci, PCI_SUBSYSTEM_VENDOR_ID,
+					     &vendor);
+			pci_read_config_word(ice->pci, PCI_SUBSYSTEM_ID, &device);
+			ice->eeprom.subvendor =
+				((unsigned int)swab16(vendor) << 16) | swab16(device);
+			if (ice->eeprom.subvendor == 0 ||
+			    ice->eeprom.subvendor == (unsigned int)-1) {
+				printk(KERN_ERR "ice1724: No valid ID is found\n");
+				return -ENXIO;
+			}
+		}
+	}
+	for (tbl = card_tables; *tbl; tbl++) {
+		for (c = *tbl; c->subvendor; c++) {
+			if (modelname && c->model &&
+			    ! strcmp(modelname, c->model)) {
+				printk(KERN_INFO "ice1724: Using board model %s\n",
+				       c->name);
+				ice->eeprom.subvendor = c->subvendor;
+			} else if (c->subvendor != ice->eeprom.subvendor)
+				continue;
+			if (! c->eeprom_size || ! c->eeprom_data)
+				goto found;
+			/* if the EEPROM is given by the driver, use it */
+			snd_printdd("using the defined eeprom..\n");
+			ice->eeprom.version = 2;
+			ice->eeprom.size = c->eeprom_size + 6;
+			memcpy(ice->eeprom.data, c->eeprom_data, c->eeprom_size);
+			goto read_skipped;
+		}
+	}
+	printk(KERN_WARNING "ice1724: No matching model found for ID 0x%x\n",
+	       ice->eeprom.subvendor);
+
+ found:
+	ice->eeprom.size = snd_vt1724_read_i2c(ice, dev, 0x04);
+	if (ice->eeprom.size < 6)
+		ice->eeprom.size = 32;
+	else if (ice->eeprom.size > 32) {
+		printk(KERN_ERR "ice1724: Invalid EEPROM (size = %i)\n",
+		       ice->eeprom.size);
+		return -EIO;
+	}
+	ice->eeprom.version = snd_vt1724_read_i2c(ice, dev, 0x05);
+	if (ice->eeprom.version != 2)
+		printk(KERN_WARNING "ice1724: Invalid EEPROM version %i\n",
+		       ice->eeprom.version);
+	size = ice->eeprom.size - 6;
+	for (i = 0; i < size; i++)
+		ice->eeprom.data[i] = snd_vt1724_read_i2c(ice, dev, i + 6);
+
+ read_skipped:
+	ice->eeprom.gpiomask = eeprom_triple(ice, ICE_EEP2_GPIO_MASK);
+	ice->eeprom.gpiostate = eeprom_triple(ice, ICE_EEP2_GPIO_STATE);
+	ice->eeprom.gpiodir = eeprom_triple(ice, ICE_EEP2_GPIO_DIR);
+
+	return 0;
+}
+
+
+
+static int __devinit snd_vt1724_chip_init(struct snd_ice1712 *ice)
+{
+	outb(VT1724_RESET , ICEREG1724(ice, CONTROL));
+	inb(ICEREG1724(ice, CONTROL)); /* pci posting flush */
+	udelay(200);
+	outb(0, ICEREG1724(ice, CONTROL));
+	inb(ICEREG1724(ice, CONTROL)); /* pci posting flush */
+	udelay(200);
+
+#if 0
+/* chip config check */
+	printk(KERN_INFO "ICE reset state: SYSCONF = %02x\n",
+					inb(ICEREG1724(ice, SYS_CFG)));
+	printk(KERN_INFO "ICE reset state: ACLINK  = %02x\n",
+					inb(ICEREG1724(ice, AC97_CFG)));
+	printk(KERN_INFO "ICE reset state: I2S     = %02x\n",
+					inb(ICEREG1724(ice, I2S_FEATURES)));
+	printk(KERN_INFO "ICE reset state: SPDIF   = %02x\n",
+					inb(ICEREG1724(ice, SPDIF_CFG)));
+#endif
+
+	outb(ice->eeprom.data[ICE_EEP2_SYSCONF], ICEREG1724(ice, SYS_CFG));
+	outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97_CFG));
+	outb(ice->eeprom.data[ICE_EEP2_I2S], ICEREG1724(ice, I2S_FEATURES));
+	outb(ice->eeprom.data[ICE_EEP2_SPDIF], ICEREG1724(ice, SPDIF_CFG));
+
+	ice->gpio.write_mask = ice->eeprom.gpiomask;
+	ice->gpio.direction = ice->eeprom.gpiodir;
+	snd_vt1724_set_gpio_mask(ice, ice->eeprom.gpiomask);
+	snd_vt1724_set_gpio_dir(ice, ice->eeprom.gpiodir);
+	snd_vt1724_set_gpio_data(ice, ice->eeprom.gpiostate);
+
+#if 0
+/* XXX GPIO check */
+	snd_vt1724_set_gpio_mask(ice, 0);
+	snd_vt1724_set_gpio_data(ice, 0xffffff);
+	printk(KERN_INFO "Maya44 GPIO state 1: %06x\n",
+					snd_vt1724_get_gpio_data(ice));
+	snd_vt1724_set_gpio_data(ice, 0);
+	printk(KERN_INFO "Maya44 GPIO state 0: %06x\n",
+					snd_vt1724_get_gpio_data(ice));
+#endif
+
+	snd_vt1724_set_gpio_mask(ice, ice->eeprom.gpiomask);
+	snd_vt1724_set_gpio_data(ice, ice->eeprom.gpiostate);
+
+	outb(0, ICEREG1724(ice, POWERDOWN));
+
+	return 0;
+}
+
+static int __devinit snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
+{
+	int err;
+	struct snd_kcontrol *kctl;
+
+	snd_assert(ice->pcm != NULL, return -EIO);
+
+	if (ice->eeprom.subvendor != VT1724_SUBDEVICE_MAYA44) {
+		err = snd_ctl_add(ice->card,
+			snd_ctl_new1(&snd_vt1724_mixer_pro_spdif_route, ice));
+		if (err < 0)
+			return err;
+	}
+
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_spdif_switch, ice));
+	if (err < 0)
+		return err;
+
+	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice));
+	if (err < 0)
+		return err;
+	kctl->id.device = ice->pcm->device;
+	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice));
+	if (err < 0)
+		return err;
+	kctl->id.device = ice->pcm->device;
+	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice));
+	if (err < 0)
+		return err;
+	kctl->id.device = ice->pcm->device;
+#if 0 /* use default only */
+	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_stream, ice));
+	if (err < 0)
+		return err;
+	kctl->id.device = ice->pcm->device;
+	ice->spdif.stream_ctl = kctl;
+#endif
+	return 0;
+}
+
+
+static int __devinit snd_vt1724_build_controls(struct snd_ice1712 *ice)
+{
+	int err;
+
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_eeprom, ice));
+	if (err < 0)
+		return err;
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_pro_internal_clock, ice));
+	if (err < 0)
+		return err;
+
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_pro_rate_locking, ice));
+	if (err < 0)
+		return err;
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_pro_rate_reset, ice));
+	if (err < 0)
+		return err;
+
+	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_MAYA44) {
+		err = snd_ctl_add(ice->card,
+			snd_ctl_new1(&snd_vt1724_mixer_pro_maya44_route, ice));
+		if (err < 0)
+			return err;
+	} else if (ice->num_total_dacs > 0) {
+		struct snd_kcontrol_new tmp = snd_vt1724_mixer_pro_analog_route;
+		tmp.count = ice->num_total_dacs;
+		if (ice->vt1720 && tmp.count > 2)
+			tmp.count = 2;
+		err = snd_ctl_add(ice->card, snd_ctl_new1(&tmp, ice));
+		if (err < 0)
+			return err;
+	}
+
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_mixer_pro_peak, ice));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int snd_vt1724_free(struct snd_ice1712 *ice)
+{
+	if (! ice->port)
+		goto __hw_end;
+	/* mask all interrupts */
+	outb(0xff, ICEMT1724(ice, DMA_INT_MASK));
+	outb(0xff, ICEREG1724(ice, IRQMASK));
+	/* --- */
+      __hw_end:
+	if (ice->irq >= 0) {
+		synchronize_irq(ice->irq);
+		free_irq(ice->irq, ice);
+	}
+	pci_release_regions(ice->pci);
+	snd_ice1712_akm4xxx_free(ice);
+	pci_disable_device(ice->pci);
+	kfree(ice->spec);
+	kfree(ice);
+	return 0;
+}
+
+static int snd_vt1724_dev_free(struct snd_device *device)
+{
+	struct snd_ice1712 *ice = device->device_data;
+	return snd_vt1724_free(ice);
+}
+
+static int __devinit snd_vt1724_create(struct snd_card *card,
+				       struct pci_dev *pci,
+				       const char *modelname,
+				       struct snd_ice1712 ** r_ice1712)
+{
+	struct snd_ice1712 *ice;
+	int err;
+	unsigned char mask;
+	static struct snd_device_ops ops = {
+		.dev_free =	snd_vt1724_dev_free,
+	};
+
+	*r_ice1712 = NULL;
+
+        /* enable PCI device */
+	if ((err = pci_enable_device(pci)) < 0)
+		return err;
+
+	ice = kzalloc(sizeof(*ice), GFP_KERNEL);
+	if (ice == NULL) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+	ice->vt1724 = 1;
+	spin_lock_init(&ice->reg_lock);
+	mutex_init(&ice->gpio_mutex);
+	mutex_init(&ice->open_mutex);
+	mutex_init(&ice->i2c_mutex);
+	ice->gpio.set_mask = snd_vt1724_set_gpio_mask;
+	ice->gpio.set_dir = snd_vt1724_set_gpio_dir;
+	ice->gpio.set_data = snd_vt1724_set_gpio_data;
+	ice->gpio.get_data = snd_vt1724_get_gpio_data;
+	ice->card = card;
+	ice->pci = pci;
+	ice->irq = -1;
+	pci_set_master(pci);
+	snd_vt1724_proc_init(ice);
+	synchronize_irq(pci->irq);
+
+	if ((err = pci_request_regions(pci, "ICE1724")) < 0) {
+		kfree(ice);
+		pci_disable_device(pci);
+		return err;
+	}
+	ice->port = pci_resource_start(pci, 0);
+	ice->profi_port = pci_resource_start(pci, 1);
+
+	if (request_irq(pci->irq, snd_vt1724_interrupt,
+			IRQF_SHARED, "ICE1724", ice)) {
+		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		snd_vt1724_free(ice);
+		return -EIO;
+	}
+
+	ice->irq = pci->irq;
+
+	if (snd_vt1724_read_eeprom(ice, modelname) < 0) {
+		snd_vt1724_free(ice);
+		return -EIO;
+	}
+	if (snd_vt1724_chip_init(ice) < 0) {
+		snd_vt1724_free(ice);
+		return -EIO;
+	}
+
+	/* unmask used interrupts */
+	if (! (ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_MPU401))
+		mask = VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX;
+	else
+		mask = 0;
+	outb(mask, ICEREG1724(ice, IRQMASK));
+	/* don't handle FIFO overrun/underruns (just yet),
+	 * since they cause machine lockups
+	 */
+	outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK));
+
+	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops)) < 0) {
+		snd_vt1724_free(ice);
+ 		return err;
+	}
+
+	snd_card_set_dev(card, &pci->dev);
+
+	*r_ice1712 = ice;
+	return 0;
+}
+
+
+/*
+ *
+ * Registration
+ *
+ */
+
+static int __devinit snd_vt1724_probe(struct pci_dev *pci,
+				      const struct pci_device_id *pci_id)
+{
+	static int dev;
+	struct snd_card *card;
+	struct snd_ice1712 *ice;
+	int pcm_dev = 0, err;
+	struct snd_ice1712_card_info * const *tbl, *c;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+
+	strcpy(card->driver, "ICE1724");
+	strcpy(card->shortname, "ICEnsemble ICE1724");
+	
+	if ((err = snd_vt1724_create(card, pci, model[dev], &ice)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	for (tbl = card_tables; *tbl; tbl++) {
+		for (c = *tbl; c->subvendor; c++) {
+			if (c->subvendor == ice->eeprom.subvendor) {
+				strcpy(card->shortname, c->name);
+				if (c->driver) /* specific driver? */
+					strcpy(card->driver, c->driver);
+				if (c->chip_init) {
+					if ((err = c->chip_init(ice)) < 0) {
+						snd_card_free(card);
+						return err;
+					}
+				}
+				goto __found;
+			}
+		}
+	}
+	c = &no_matched;
+ __found:
+       /*
+        * VT1724 has separate DMAs for the analog and the SPDIF streams while
+        * ICE1712 has only one for both (mixed up).
+        *
+        * Confusingly the analog PCM is named "professional" here because it
+        * was called so in ice1712 driver, and vt1724 driver is derived from
+        * ice1712 driver.
+        */
+
+	if ((err = snd_vt1724_pcm_profi(ice, pcm_dev++)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	
+	if ((err = snd_vt1724_pcm_spdif(ice, pcm_dev++)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	
+	if ((err = snd_vt1724_pcm_indep(ice, pcm_dev++)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	if ((err = snd_vt1724_ac97_mixer(ice)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	if ((err = snd_vt1724_build_controls(ice)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	if (ice->pcm && ice->has_spdif) { /* has SPDIF I/O */
+		if ((err = snd_vt1724_spdif_build_controls(ice)) < 0) {
+			snd_card_free(card);
+			return err;
+		}
+	}
+
+	if (c->build_controls) {
+		if ((err = c->build_controls(ice)) < 0) {
+			snd_card_free(card);
+			return err;
+		}
+	}
+
+	if (! c->no_mpu401) {
+		if (ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_MPU401) {
+			if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
+						       ICEREG1724(ice, MPU_CTRL),
+						       MPU401_INFO_INTEGRATED,
+						       ice->irq, 0,
+						       &ice->rmidi[0])) < 0) {
+				snd_card_free(card);
+				return err;
+			}
+		}
+	}
+
+	sprintf(card->longname, "%s at 0x%lx, irq %i",
+		card->shortname, ice->port, ice->irq);
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	pci_set_drvdata(pci, card);
+	dev++;
+
+	return 0;
+}
+
+static void __devexit snd_vt1724_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+static struct pci_driver driver = {
+	.name = "ICE1724",
+	.id_table = snd_vt1724_ids,
+	.probe = snd_vt1724_probe,
+	.remove = __devexit_p(snd_vt1724_remove),
+};
+
+static int __init alsa_card_ice1724_init(void)
+{
+	return pci_register_driver(&driver);
+}
+
+static void __exit alsa_card_ice1724_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_ice1724_init)
+module_exit(alsa_card_ice1724_exit)
diff -r 5715d75f833f pci/ice1712/ice1724.patch
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/ice1724.patch	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,470 @@
+--- ../../alsa-kernel/pci/ice1712/ice1724.c	2008-02-02 01:44:07.000000000 +0100
++++ ice1724.c	2008-02-13 15:38:02.000000000 +0100
+@@ -1,3 +1,4 @@
++#include "adriver.h"
+ /*
+  *   ALSA driver for VT1724 ICEnsemble ICE1724 / VIA VT1724 (Envy24HT)
+  *                   VIA VT1720 (Envy24PT)
+@@ -49,6 +50,7 @@
+ #include "prodigy192.h"
+ #include "prodigy_hifi.h"
+ #include "juli.h"
++#include "maya44.h"
+ #include "phase.h"
+ #include "wtm.h"
+ #include "se.h"
+@@ -65,6 +67,7 @@
+ 	       PRODIGY192_DEVICE_DESC
+ 	       PRODIGY_HIFI_DEVICE_DESC
+ 	       JULI_DEVICE_DESC
++	       MAYA44_DEVICE_DESC
+ 	       PHASE_DEVICE_DESC
+ 	       WTM_DEVICE_DESC
+ 	       SE_DEVICE_DESC
+@@ -402,15 +405,20 @@
+ 		return 48000;
+ }
+ 
+-static void snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
++static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
+ 				    int force)
+ {
+ 	unsigned long flags;
+ 	unsigned char val, old;
+ 	unsigned int i, mclk_change;
+ 
++	printk(KERN_DEBUG
++	       "ice1712: set_pro_rate, rate=%i, max_rate=%i, force=%i, "
++	       "locked=%i\n",
++	       rate, get_max_rate(ice), force, is_pro_rate_locked(ice));
++
+ 	if (rate > get_max_rate(ice))
+-		return;
++		return -EINVAL;
+ 
+ 	switch (rate) {
+ 	case 8000: val = 6; break;
+@@ -431,7 +439,7 @@
+ 	default:
+ 		snd_BUG();
+ 		val = 0;
+-		break;
++		return -EINVAL;
+ 	}
+ 
+ 	spin_lock_irqsave(&ice->reg_lock, flags);
+@@ -439,11 +447,11 @@
+ 	    (inb(ICEMT1724(ice, DMA_PAUSE)) & DMA_PAUSES)) {
+ 		/* running? we cannot change the rate now... */
+ 		spin_unlock_irqrestore(&ice->reg_lock, flags);
+-		return;
++		return -EBUSY;
+ 	}
+ 	if (!force && is_pro_rate_locked(ice)) {
+ 		spin_unlock_irqrestore(&ice->reg_lock, flags);
+-		return;
++		return (rate == ice->cur_rate) ? 0 : -EBUSY;
+ 	}
+ 
+ 	old = inb(ICEMT1724(ice, RATE));
+@@ -451,7 +459,7 @@
+ 		outb(val, ICEMT1724(ice, RATE));
+ 	else if (rate == ice->cur_rate) {
+ 		spin_unlock_irqrestore(&ice->reg_lock, flags);
+-		return;
++		return 0;
+ 	}
+ 
+ 	ice->cur_rate = rate;
+@@ -483,13 +491,15 @@
+ 	}
+ 	if (ice->spdif.ops.setup_rate)
+ 		ice->spdif.ops.setup_rate(ice, rate);
++
++	return 0;
+ }
+ 
+ static int snd_vt1724_pcm_hw_params(struct snd_pcm_substream *substream,
+ 				    struct snd_pcm_hw_params *hw_params)
+ {
+ 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+-	int i, chs;
++	int i, chs, err;
+ 
+ 	chs = params_channels(hw_params);
+ 	mutex_lock(&ice->open_mutex);
+@@ -524,7 +534,11 @@
+ 		}
+ 	}
+ 	mutex_unlock(&ice->open_mutex);
+-	snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
++
++	err = snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
++	if ( err < 0 )
++		return err;
++
+ 	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+ }
+ 
+@@ -650,20 +664,40 @@
+ #endif
+ }
+ 
+-static const struct vt1724_pcm_reg vt1724_playback_pro_reg = {
++static const struct vt1724_pcm_reg vt1724_pdma0_reg = {
+ 	.addr = VT1724_MT_PLAYBACK_ADDR,
+ 	.size = VT1724_MT_PLAYBACK_SIZE,
+ 	.count = VT1724_MT_PLAYBACK_COUNT,
+ 	.start = VT1724_PDMA0_START,
+ };
+ 
+-static const struct vt1724_pcm_reg vt1724_capture_pro_reg = {
++static const struct vt1724_pcm_reg vt1724_pdma4_reg = {
++	.addr = VT1724_MT_PDMA4_ADDR,
++	.size = VT1724_MT_PDMA4_SIZE,
++	.count = VT1724_MT_PDMA4_COUNT,
++	.start = VT1724_PDMA4_START,
++};
++
++static const struct vt1724_pcm_reg vt1724_rdma0_reg = {
+ 	.addr = VT1724_MT_CAPTURE_ADDR,
+ 	.size = VT1724_MT_CAPTURE_SIZE,
+ 	.count = VT1724_MT_CAPTURE_COUNT,
+ 	.start = VT1724_RDMA0_START,
+ };
+ 
++static const struct vt1724_pcm_reg vt1724_rdma1_reg = {
++	.addr = VT1724_MT_RDMA1_ADDR,
++	.size = VT1724_MT_RDMA1_SIZE,
++	.count = VT1724_MT_RDMA1_COUNT,
++	.start = VT1724_RDMA1_START,
++};
++
++#define vt1724_playback_pro_reg vt1724_pdma0_reg
++#define vt1724_playback_spdif_reg vt1724_pdma4_reg
++#define vt1724_capture_pro_reg vt1724_rdma0_reg
++#define vt1724_capture_spdif_reg vt1724_rdma1_reg
++
++
+ static const struct snd_pcm_hardware snd_vt1724_playback_pro =
+ {
+ 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+@@ -728,9 +762,35 @@
+  * set rate constraints
+  */
+ static int set_rate_constraints(struct snd_ice1712 *ice,
+-				struct snd_pcm_substream *substream)
++				struct snd_pcm_substream *substream,
++				unsigned char is_adc)
+ {
+ 	struct snd_pcm_runtime *runtime = substream->runtime;
++	struct snd_pcm_hw_constraint_list *hw_rates;
++
++#if 0
++/*
++ * allow separate ADC/DAC rates - for ESI Maya44
++ * requires change in ice1712.h (struct ice definition)
++ * see ice1712.h.patch
++ */
++
++	hw_rates = (is_adc && ice->hw_rates_adc) ?
++			ice->hw_rates_adc : ice->hw_rates;
++
++	if (hw_rates) {
++		/* hardware specific */
++		runtime->hw.rate_min = hw_rates->list[0];
++		runtime->hw.rate_max = hw_rates->list[hw_rates->count - 1];
++		runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
++		return snd_pcm_hw_constraint_list(runtime, 0,
++						  SNDRV_PCM_HW_PARAM_RATE,
++						  hw_rates);
++	}
++#else
++/*
++ * original code - common rate set for ADC and DAC
++ */
+ 	if (ice->hw_rates) {
+ 		/* hardware specific */
+ 		runtime->hw.rate_min = ice->hw_rates->list[0];
+@@ -740,6 +800,7 @@
+ 						  SNDRV_PCM_HW_PARAM_RATE,
+ 						  ice->hw_rates);
+ 	}
++#endif
+ 	if (ice->eeprom.data[ICE_EEP2_ACLINK] & VT1724_CFG_PRO_I2S) {
+ 		/* I2S */
+ 		/* VT1720 doesn't support more than 96kHz */
+@@ -782,7 +843,7 @@
+ 	runtime->hw = snd_vt1724_playback_pro;
+ 	snd_pcm_set_sync(substream);
+ 	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+-	set_rate_constraints(ice, substream);
++	set_rate_constraints(ice, substream, 0);
+ 	mutex_lock(&ice->open_mutex);
+ 	/* calculate the currently available channels */
+ 	for (chs = 0; chs < 3; chs++) {
+@@ -808,10 +869,12 @@
+ 
+ 	runtime->private_data = (void *)&vt1724_capture_pro_reg;
+ 	ice->capture_pro_substream = substream;
++
+ 	runtime->hw = snd_vt1724_2ch_stereo;
+ 	snd_pcm_set_sync(substream);
+ 	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+-	set_rate_constraints(ice, substream);
++	set_rate_constraints(ice, substream, 1);
++
+ 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+ 				   VT1724_BUFFER_ALIGN);
+ 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+@@ -837,6 +900,7 @@
+ 	if (PRO_RATE_RESET)
+ 		snd_vt1724_set_pro_rate(ice, PRO_RATE_DEFAULT, 0);
+ 	ice->capture_pro_substream = NULL;
++
+ 	return 0;
+ }
+ 
+@@ -892,20 +956,6 @@
+  * SPDIF PCM
+  */
+ 
+-static const struct vt1724_pcm_reg vt1724_playback_spdif_reg = {
+-	.addr = VT1724_MT_PDMA4_ADDR,
+-	.size = VT1724_MT_PDMA4_SIZE,
+-	.count = VT1724_MT_PDMA4_COUNT,
+-	.start = VT1724_PDMA4_START,
+-};
+-
+-static const struct vt1724_pcm_reg vt1724_capture_spdif_reg = {
+-	.addr = VT1724_MT_RDMA1_ADDR,
+-	.size = VT1724_MT_RDMA1_SIZE,
+-	.count = VT1724_MT_RDMA1_COUNT,
+-	.start = VT1724_RDMA1_START,
+-};
+-
+ /* update spdif control bits; call with reg_lock */
+ static void update_spdif_bits(struct snd_ice1712 *ice, unsigned int val)
+ {
+@@ -961,7 +1011,7 @@
+ 	ice->playback_con_substream = substream;
+ 	if (ice->force_pdma4) {
+ 		runtime->hw = snd_vt1724_2ch_stereo;
+-		set_rate_constraints(ice, substream);
++		set_rate_constraints(ice, substream, 0);
+ 	} else
+ 		runtime->hw = snd_vt1724_spdif;
+ 	snd_pcm_set_sync(substream);
+@@ -993,7 +1043,7 @@
+ 	ice->capture_con_substream = substream;
+ 	if (ice->force_rdma1) {
+ 		runtime->hw = snd_vt1724_2ch_stereo;
+-		set_rate_constraints(ice, substream);
++		set_rate_constraints(ice, substream, 1);
+ 	} else
+ 		runtime->hw = snd_vt1724_spdif;
+ 	snd_pcm_set_sync(substream);
+@@ -1064,7 +1114,7 @@
+ 	if (ice->force_pdma4 || ice->force_rdma1)
+ 		name = "ICE1724 Secondary";
+ 	else
+-		name = "IEC1724 IEC958";
++		name = "ICE1724 IEC958";
+ 	err = snd_pcm_new(ice->card, name, device, play, capt, &pcm);
+ 	if (err < 0)
+ 		return err;
+@@ -1145,7 +1195,7 @@
+ 	runtime->hw = snd_vt1724_2ch_stereo;
+ 	snd_pcm_set_sync(substream);
+ 	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+-	set_rate_constraints(ice, substream);
++	set_rate_constraints(ice, substream, 0);
+ 	return 0;
+ }
+ 
+@@ -1779,6 +1829,29 @@
+ 	return 0;
+ }
+ 
++/*
++ * spcial routing for MAYA44
++ */
++static int snd_vt1724_pro_route_maya44_info(struct snd_kcontrol *kcontrol,
++				     struct snd_ctl_elem_info *uinfo)
++{
++	static char *texts[] = {
++		"PCM Out", /* 0 */
++		"Input 1", "Input 2", "Input 3", "Input 4"
++	};
++
++	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
++	uinfo->count = 1;
++	uinfo->value.enumerated.items = 5;
++	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
++		uinfo->value.enumerated.item =
++			uinfo->value.enumerated.items - 1;
++
++	strcpy(uinfo->value.enumerated.name,
++					texts[uinfo->value.enumerated.item]);
++	return 0;
++}
++
+ static inline int analog_route_shift(int idx)
+ {
+ 	return (idx % 2) * 12 + ((idx / 2) * 3) + 8;
+@@ -1789,6 +1862,13 @@
+ 	return idx * 3;
+ }
+ 
++static inline int maya44_route_shift(int idx)
++{
++	static const unsigned char shift[10] =
++				{ 8, 20, 0, 3, 11, 23, 14, 26, 17, 29 };
++	return shift[idx%10];
++}
++
+ static int get_route_val(struct snd_ice1712 *ice, int shift)
+ {
+ 	unsigned long val;
+@@ -1868,7 +1948,27 @@
+ 			     digital_route_shift(idx));
+ }
+ 
+-static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata = {
++static int snd_vt1724_pro_route_maya44_get(struct snd_kcontrol *kcontrol,
++					   struct snd_ctl_elem_value *ucontrol)
++{
++	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
++	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
++	ucontrol->value.enumerated.item[0] =
++		get_route_val(ice, maya44_route_shift(idx));
++	return 0;
++}
++
++static int snd_vt1724_pro_route_maya44_put(struct snd_kcontrol *kcontrol,
++					   struct snd_ctl_elem_value *ucontrol)
++{
++	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
++	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
++	return put_route_val(ice, ucontrol->value.enumerated.item[0],
++			     maya44_route_shift(idx));
++}
++
++static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata =
++{
+ 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+ 	.name = "H/W Playback Route",
+ 	.info = snd_vt1724_pro_route_info,
+@@ -1876,6 +1976,20 @@
+ 	.put = snd_vt1724_pro_route_analog_put,
+ };
+ 
++static struct snd_kcontrol_new snd_vt1724_mixer_pro_maya44_route __devinitdata =
++{
++	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
++	.name = "H/W Playback Route",
++	.info = snd_vt1724_pro_route_maya44_info,
++	.get = snd_vt1724_pro_route_maya44_get,
++	.put = snd_vt1724_pro_route_maya44_put,
++#if 1
++	.count = 10  /* XXX check whether controls 5-9 have any meaning */
++#else
++	.count = 4
++#endif
++};
++
+ static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
+ 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+ 	.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Route",
+@@ -1935,6 +2049,7 @@
+ 	snd_vt1724_prodigy_hifi_cards,
+ 	snd_vt1724_prodigy192_cards,
+ 	snd_vt1724_juli_cards,
++	snd_vt1724_maya44_cards,
+ 	snd_vt1724_phase_cards,
+ 	snd_vt1724_wtm_cards,
+ 	snd_vt1724_se_cards,
+@@ -2068,9 +2183,24 @@
+ static int __devinit snd_vt1724_chip_init(struct snd_ice1712 *ice)
+ {
+ 	outb(VT1724_RESET , ICEREG1724(ice, CONTROL));
++	inb(ICEREG1724(ice, CONTROL)); /* pci posting flush */
+ 	udelay(200);
+ 	outb(0, ICEREG1724(ice, CONTROL));
++	inb(ICEREG1724(ice, CONTROL)); /* pci posting flush */
+ 	udelay(200);
++
++#if 0
++/* chip config check */
++	printk(KERN_INFO "ICE reset state: SYSCONF = %02x\n",
++					inb(ICEREG1724(ice, SYS_CFG)));
++	printk(KERN_INFO "ICE reset state: ACLINK  = %02x\n",
++					inb(ICEREG1724(ice, AC97_CFG)));
++	printk(KERN_INFO "ICE reset state: I2S     = %02x\n",
++					inb(ICEREG1724(ice, I2S_FEATURES)));
++	printk(KERN_INFO "ICE reset state: SPDIF   = %02x\n",
++					inb(ICEREG1724(ice, SPDIF_CFG)));
++#endif
++
+ 	outb(ice->eeprom.data[ICE_EEP2_SYSCONF], ICEREG1724(ice, SYS_CFG));
+ 	outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97_CFG));
+ 	outb(ice->eeprom.data[ICE_EEP2_I2S], ICEREG1724(ice, I2S_FEATURES));
+@@ -2082,6 +2212,20 @@
+ 	snd_vt1724_set_gpio_dir(ice, ice->eeprom.gpiodir);
+ 	snd_vt1724_set_gpio_data(ice, ice->eeprom.gpiostate);
+ 
++#if 0
++/* XXX GPIO check */
++	snd_vt1724_set_gpio_mask(ice, 0);
++	snd_vt1724_set_gpio_data(ice, 0xffffff);
++	printk(KERN_INFO "Maya44 GPIO state 1: %06x\n",
++					snd_vt1724_get_gpio_data(ice));
++	snd_vt1724_set_gpio_data(ice, 0);
++	printk(KERN_INFO "Maya44 GPIO state 0: %06x\n",
++					snd_vt1724_get_gpio_data(ice));
++#endif
++
++	snd_vt1724_set_gpio_mask(ice, ice->eeprom.gpiomask);
++	snd_vt1724_set_gpio_data(ice, ice->eeprom.gpiostate);
++
+ 	outb(0, ICEREG1724(ice, POWERDOWN));
+ 
+ 	return 0;
+@@ -2094,9 +2238,12 @@
+ 
+ 	snd_assert(ice->pcm != NULL, return -EIO);
+ 
+-	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_mixer_pro_spdif_route, ice));
+-	if (err < 0)
+-		return err;
++	if (ice->eeprom.subvendor != VT1724_SUBDEVICE_MAYA44) {
++		err = snd_ctl_add(ice->card,
++			snd_ctl_new1(&snd_vt1724_mixer_pro_spdif_route, ice));
++		if (err < 0)
++			return err;
++	}
+ 
+ 	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_spdif_switch, ice));
+ 	if (err < 0)
+@@ -2143,7 +2290,12 @@
+ 	if (err < 0)
+ 		return err;
+ 
+-	if (ice->num_total_dacs > 0) {
++	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_MAYA44) {
++		err = snd_ctl_add(ice->card,
++			snd_ctl_new1(&snd_vt1724_mixer_pro_maya44_route, ice));
++		if (err < 0)
++			return err;
++	} else if (ice->num_total_dacs > 0) {
+ 		struct snd_kcontrol_new tmp = snd_vt1724_mixer_pro_analog_route;
+ 		tmp.count = ice->num_total_dacs;
+ 		if (ice->vt1720 && tmp.count > 2)
+@@ -2397,6 +2549,7 @@
+ 	}
+ 	pci_set_drvdata(pci, card);
+ 	dev++;
++
+ 	return 0;
+ }
+ 
diff -r 5715d75f833f pci/ice1712/juli.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/juli.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/juli.h"
diff -r 5715d75f833f pci/ice1712/maya44.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/maya44.c	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,691 @@
+#include "adriver.h"
+/*
+ *   ALSA driver for ICEnsemble VT1724 (Envy24HT)
+ *
+ *   Lowlevel functions for ESI Maya44 cards
+ *
+ *	Copyright (c) 2007 Rainer Zimmermann <mail@lightshed.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+
+#include "ice1712.h"
+#include "envy24ht.h"
+#include "maya44.h"
+#include <wm8776.h>
+
+/*
+ * If defined, allow separate lists of allowable rates for ADC/DAC.
+ * Actually, ADC & DAC rates are linked, so setting invalid
+ * ADC rates (>96 kHz) cannot be prevented in all cases.
+ * NOTE: this requires changes in ice1712.h (see ice1712.h.patch)
+ * and enabling the corresponding code in ice1724.c
+ */
+#undef SEPARATE_ADC_RATES
+
+struct maya44_spec {
+	struct snd_wm8776 *wm[2];
+	unsigned int miodio:1;
+};
+
+/*
+ * chip addresses on I2C bus
+ */
+#define WM8776_0_ADDR		0x34		/* Codec 0 */
+#define WM8776_1_ADDR		0x36		/* Codec 1 */
+
+/*
+ * GPIO pins (known ones for maya44)
+ */
+#define GPIO_PHANTOM_OFF	(1<<2)
+#define GPIO_MIC_RELAY		(1<<4)
+#define GPIO_SPDIF_IN_INV	(1<<5)  /* CHECK! */
+#define GPIO_MUST_BE_0		(1<<7)
+
+
+/*
+ * WM8776 codecs section
+ */
+
+static void maya44_wm_reg_write(void *private_data, int chip,
+			   unsigned char addr, unsigned short data)
+{
+	struct snd_ice1712 *ice = (struct snd_ice1712 *)private_data;
+
+#if 0
+	snd_printd(KERN_DEBUG
+		   "maya44: maya44_wm_reg_write, ice=%p, chip=%i, addr=%i, "
+		   "data=%i\n",
+		   ice, chip, (int)addr, (int)data);
+#endif
+
+	snd_assert(chip == 0 || chip == 1, return);
+
+/*
+ * WM8776 registers are up to 9 bits wide, bit 8 is placed in the LSB
+ * of the address field
+ */
+	snd_vt1724_write_i2c(	ice,
+				chip ? WM8776_1_ADDR : WM8776_0_ADDR,
+				(addr<<1) | ((data>>8) & 1),
+				data&0xff
+				);
+}
+
+/*
+ * change the rate on the WM8776 codecs.
+ * this assumes that the VT17xx's rate is changed by the calling function.
+ * NOTE: even though the WM8776's are running in slave mode and rate
+ * selection is automatic, we need to call snd_wm8776_set_rate() here
+ * to make sure some flags are set correctly.
+ */
+static void set_rate(struct snd_ice1712 *ice, unsigned int rate)
+{
+	struct maya44_spec *maya44_spec = ice->spec;
+	int ratio, i;
+
+	switch (rate) {
+	case 192000:
+		ratio = WM8776_CLOCK_RATIO_128FS;
+		break;
+	case 176400:
+		ratio = WM8776_CLOCK_RATIO_128FS;
+		break;
+	case 96000:
+		ratio = WM8776_CLOCK_RATIO_256FS;
+		break;
+	case 88200:
+		ratio = WM8776_CLOCK_RATIO_384FS;
+		break;
+	case 48000:
+		ratio = WM8776_CLOCK_RATIO_512FS;
+		break;
+	case 44100:
+		ratio = WM8776_CLOCK_RATIO_512FS;
+		break;
+	case 32000:
+		ratio = WM8776_CLOCK_RATIO_768FS;
+		break;
+	case 0:
+		/* no hint - S/PDIF input is master, simply return */
+		return;
+	default:
+		snd_BUG();
+		return;
+	}
+
+	snd_printd(KERN_DEBUG "maya44: set rate %i, ratio=%d\n", rate, ratio);
+
+	for ( i = 0; i < 2; i++)
+		snd_wm8776_set_rate(maya44_spec->wm[i], ratio);
+}
+
+static int maya44_wm_dev_free(struct snd_device *device)
+{
+	snd_printd(KERN_DEBUG
+		   "maya44: maya44_wm_dev_free, dev=%p, device_data=%p\n",
+		   device, device->device_data);
+	kfree(device->device_data);
+	return 0;
+}
+
+static struct wm_vol_control {
+	char *name;
+	int index[2];
+} wm_vol_controls[] =
+{
+	{ .name = "Crossmix Playback Volume",
+	  .index = { WM8776_VOL_HEADPHONE_L, WM8776_VOL_HEADPHONE_R }},
+	{ .name = "PCM Playback Volume",
+	  .index = { WM8776_VOL_DAC_L, WM8776_VOL_DAC_R }},
+	{ .name = "Line Capture Volume",
+	  .index = { WM8776_VOL_ADC_GAIN_L, WM8776_VOL_ADC_GAIN_R }},
+	{} /* terminator */
+};
+
+/* definition of "1 per codec chip" switches */
+
+static struct wm_switch_control {
+	char *name;
+	int index;
+} wm_switch_controls[] =
+{
+	{ .name = "PCM Playback Switch",	.index = WM8776_SW_OUT_DAC },
+/* Aux is not used & set to OFF in wm8776.c by default */
+/*	{ .name = "Aux Playback Switch",	.index = WM8776_SW_OUT_AUX },*/
+	{ .name = "Bypass Playback Switch", 	.index = WM8776_SW_OUT_BYPASS },
+#ifdef _TESTMODE_
+	{ .name = "Line Capture Switch 1",  	.index = WM8776_SW_IN_1 },
+	{ .name = "Line Capture Switch 2",  	.index = WM8776_SW_IN_2 },
+	{ .name = "Line Capture Switch 3",  	.index = WM8776_SW_IN_3	},
+	{ .name = "Line Capture Switch 4",  	.index = WM8776_SW_IN_4	},
+	{ .name = "Line Capture Switch 5",  	.index = WM8776_SW_IN_5	},
+#endif
+	{} /* terminator */
+};
+
+#define WM_MAKE_PRIV(chip, idx) (((chip)<<8)|(idx))
+#define WM_GET_CHIP(priv) ((priv)>>8)
+#define WM_GET_IDX(priv) ((priv)&0xff)
+
+#define TLV_HAS_MUTE(tlv) (((tlv)[3]&0x10000) != 0)
+
+static int wm_vol_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	const struct snd_wm8776_volume_info *vi =
+		snd_wm8776_get_volume_info(WM_GET_IDX(kcontrol->private_value));
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: wm_vol_info, prv=%i\n",
+		   (int)kcontrol->private_value);
+#endif
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2; /* 2 channels per codec */
+	uinfo->value.integer.min = TLV_HAS_MUTE(vi->tlv_scale)?0:1;
+	uinfo->value.integer.max = vi->nlvl;
+	return 0;
+}
+
+static int wm_vol_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct maya44_spec *maya44_spec = ice->spec;
+	struct snd_wm8776 *wm;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: wm_vol_get, ice=%p, prv=%i\n",
+		   ice, (int)kcontrol->private_value);
+#endif
+
+	/* get L+R volumes from one WM8776 codec */
+	wm = maya44_spec->wm[WM_GET_CHIP(kcontrol->private_value)];
+	/* left channel */
+	ucontrol->value.integer.value[0] =
+		snd_wm8776_get_volume(wm,
+				      WM_GET_IDX(kcontrol->private_value));
+	/* right channel */
+	ucontrol->value.integer.value[1] =
+		snd_wm8776_get_volume(wm,
+				      WM_GET_IDX(kcontrol->private_value)+1);
+
+	return 0;
+}
+
+static int wm_vol_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct maya44_spec *maya44_spec = ice->spec;
+	struct snd_wm8776 *wm;
+	int changed = 0;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: wm_vol_put, ice=%p, prv=%i, val=%i,%i\n",
+		   ice, (int)kcontrol->private_value,
+		   (int)ucontrol->value.integer.value[0],
+		   (int)ucontrol->value.integer.value[1]);
+#endif
+
+	/* put L+R volumes for one WM8776 codec */
+	wm = maya44_spec->wm[WM_GET_CHIP(kcontrol->private_value)];
+	/* left channel */
+	changed = snd_wm8776_set_volume(wm,
+					WM_GET_IDX(kcontrol->private_value),
+					ucontrol->value.integer.value[0]);
+	/* right channel */
+	changed |= snd_wm8776_set_volume(wm,
+					 WM_GET_IDX(kcontrol->private_value)+1,
+					 ucontrol->value.integer.value[1]);
+
+	return changed;
+}
+
+#if 0
+static int wm_switch_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 2; /* switches are always one per codec */
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+#endif
+
+static int wm_switch_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct maya44_spec *maya44_spec = ice->spec;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: wm_switch_get, ice=%p, prv=%i\n",
+		   ice, (int)kcontrol->private_value);
+#endif
+
+	/* get switch from one WM8776 codec */
+	ucontrol->value.integer.value[0] =
+		snd_wm8776_get_switch(
+			maya44_spec->wm[WM_GET_CHIP(kcontrol->private_value)],
+			WM_GET_IDX(kcontrol->private_value));
+
+	return 0;
+}
+
+static int wm_switch_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct maya44_spec *maya44_spec = ice->spec;
+	int changed = 0;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: wm_switch_put, ice=%p, prv=%i\n",
+		   ice, (int)kcontrol->private_value);
+#endif
+
+	/* put switch for one WM8776 codec */
+	changed = snd_wm8776_set_switch(
+			maya44_spec->wm[WM_GET_CHIP(kcontrol->private_value)],
+			WM_GET_IDX(kcontrol->private_value),
+			ucontrol->value.integer.value[0]);
+
+	return changed;
+}
+
+#ifdef _TESTMODE_
+
+static int gpio_switch_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	unsigned int data, mask = 1<<kcontrol->private_value;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: gpio_switch_get, ice=%p, prv=%i\n",
+		   ice, (int)kcontrol->private_value);
+#endif
+
+	data = ice->gpio.get_data(ice);
+	ucontrol->value.integer.value[0] = ((data & mask) != 0);
+	return 0;
+}
+
+static int gpio_switch_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	unsigned int data, mask = 1<<kcontrol->private_value;
+	unsigned int bit = ucontrol->value.integer.value[0]?mask:0;
+	int changed = 0;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: gpio_switch_put, ice=%p, prv=%i\n",
+		   ice, (int)kcontrol->private_value);
+#endif
+
+	mutex_lock(&ice->gpio_mutex);
+	data = ice->gpio.get_data(ice);
+	if ((data&mask) != bit) {
+		ice->gpio.set_data(ice, (data & ~mask)|bit);
+		changed = 1;
+	}
+	mutex_unlock(&ice->gpio_mutex);
+	return changed;
+}
+
+#endif /* _TESTMODE_ */
+
+enum { SW_MIC = 0, SW_PHANTOM, SW_SPDIF_IN };
+
+static const char *other_switch_names[] = {
+	[SW_MIC] = "Mic/Line Input Switch",
+	[SW_PHANTOM] = "Mic Phantom+48V Switch",
+/*
+ * the next one should probably be called "IEC958 Capture Switch", but
+ * then alsamixer wouldn't handle it properly.
+ */
+	[SW_SPDIF_IN] = "S/PDIF Capture Switch",
+	NULL /* terminator */
+};
+
+static unsigned char sw_other[] = {
+	[SW_MIC] = 0,
+	[SW_PHANTOM] = 0,
+	[SW_SPDIF_IN] = 0
+};
+
+static int set_gpio_bits(struct snd_ice1712 *ice, unsigned int mask,
+			 unsigned int bits)
+{
+	unsigned int data;
+	unsigned char changed = 0;
+	mutex_lock(&ice->gpio_mutex);
+	data = ice->gpio.get_data(ice);
+	if ((data&mask) != bits) {
+		ice->gpio.set_data(ice, (data & ~mask)|bits);
+		changed = 1;
+	}
+	mutex_unlock(&ice->gpio_mutex);
+	return changed;
+}
+
+static int other_switch_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+#if 0
+	snd_printd(KERN_DEBUG "maya44: other_switch_get, prv=%i\n",
+		   (int)kcontrol->private_value);
+#endif
+
+	ucontrol->value.integer.value[0] =
+				sw_other[(int)kcontrol->private_value];
+	return 0;
+}
+
+static int other_switch_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct maya44_spec *maya44_spec = ice->spec;
+	int j;
+	int set = ucontrol->value.integer.value[0];
+	int idx = kcontrol->private_value;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: other_switch_put, ice=%p, prv=%i\n",
+		   ice, (int)kcontrol->private_value);
+#endif
+
+	if (set == sw_other[idx])
+		return 0; /* not changed */
+
+	switch ( kcontrol->private_value ) {
+	case SW_PHANTOM:
+		set_gpio_bits(ice, GPIO_PHANTOM_OFF,
+					set ? 0 : GPIO_PHANTOM_OFF);
+		break;
+	case SW_MIC:
+		set_gpio_bits(ice, GPIO_MIC_RELAY,
+					set ? GPIO_MIC_RELAY : 0);
+		/* line input = IN2, mic input = IN4 */
+		for (j = WM8776_SW_IN_1; j <= WM8776_SW_IN_5; j++ )
+			snd_wm8776_set_switch(
+				maya44_spec->wm[0],
+				j,
+				(j == (set?WM8776_SW_IN_4:WM8776_SW_IN_2)));
+		break;
+	case SW_SPDIF_IN:
+		set_gpio_bits(ice, GPIO_SPDIF_IN_INV,
+						set ? 0 : GPIO_SPDIF_IN_INV);
+		break;
+	default:
+		snd_BUG();
+		return 0;
+	}
+
+	sw_other[idx] = set;
+	return 1;
+}
+
+
+static int __devinit maya44_add_controls(struct snd_ice1712 *ice)
+{
+	int err, i;
+	struct snd_kcontrol_new newc;
+	struct wm_vol_control *pv;
+	struct wm_switch_control *ps;
+
+#if 0
+	snd_printd(KERN_DEBUG "maya44: maya44_add_controls, ice=%p\n", ice);
+#endif
+
+	/* add volume controls for both WM8776 codecs */
+
+	memset(&newc, 0, sizeof(newc));
+	newc.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	newc.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+					SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	newc.info = wm_vol_info;
+	newc.get = wm_vol_get;
+	newc.put = wm_vol_put;
+	newc.count = 1;
+
+	for ( pv = wm_vol_controls; pv->name != NULL; pv++ ) {
+		newc.name = pv->name;
+		newc.tlv.p =
+			snd_wm8776_get_volume_info(pv->index[0])->tlv_scale;
+
+		for ( newc.index = 0; newc.index < 2; newc.index++) {
+			newc.private_value =
+				WM_MAKE_PRIV(newc.index, pv->index[0]);
+#if 0
+			snd_printd(KERN_DEBUG
+				"maya44: add control '%s' idx %i, pval=%i\n",
+				pv->name, (int)newc.index,
+				(int)newc.private_value);
+#endif
+
+			err = snd_ctl_add(ice->card, snd_ctl_new1(&newc, ice));
+#if 0
+			snd_printd(KERN_DEBUG "maya44: err=%i\n", err);
+#endif
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/* add switch controls for both WM8776 codecs */
+
+	memset(&newc, 0, sizeof(newc));
+	newc.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	newc.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	newc.info = /*wm_switch_info*/ snd_ctl_boolean_mono_info;
+	newc.get = wm_switch_get;
+	newc.put = wm_switch_put;
+	newc.count = 1;
+
+	for ( ps = wm_switch_controls; ps->name != NULL; ps++ ) {
+		newc.name = ps->name;
+		for ( newc.index = 0; newc.index < 2; newc.index++) {
+			newc.private_value =
+					WM_MAKE_PRIV(newc.index, ps->index);
+			err = snd_ctl_add(ice->card, snd_ctl_new1(&newc, ice));
+			if (err < 0)
+				return err;
+		}
+	}
+
+#ifdef _TESTMODE_
+	/* add GPIO controls */
+
+	memset(&newc, 0, sizeof(newc));
+	newc.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	newc.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	newc.info = snd_ctl_boolean_mono_info; /* simple switch */
+	newc.get = gpio_switch_get;
+	newc.put = gpio_switch_put;
+	newc.count = 1;
+
+	{
+		char gpname[40];
+		int i;
+		for ( i = 0; i < 24; i++) {
+			sprintf(gpname, "GPIO bit %02i", i);
+			newc.name = gpname;
+			newc.private_value = i;
+
+			err = snd_ctl_add(ice->card, snd_ctl_new1(&newc, ice));
+			if (err < 0)
+				return err;
+		}
+	}
+#endif
+
+	/* add other controls */
+
+	memset(&newc, 0, sizeof(newc));
+	newc.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	newc.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	newc.info = snd_ctl_boolean_mono_info; /* simple switch */
+	newc.get = other_switch_get;
+	newc.put = other_switch_put;
+	newc.count = 1;
+
+	for (i = 0; (newc.name = (char *)other_switch_names[i]) != NULL; i++) {
+		newc.private_value = i;
+#if 0
+		snd_printd(KERN_DEBUG "maya44: add control '%s', i=%i\n",
+			   newc.name, i);
+#endif
+		err = snd_ctl_add(ice->card, snd_ctl_new1(&newc, ice));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * initialize the chip
+ */
+static int __devinit maya44_init(struct snd_ice1712 *ice)
+{
+	int err, i, j;
+	struct maya44_spec *maya44_spec;
+	static unsigned int rates[] = {
+		32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000
+	};
+#ifdef SEPARATE_ADC_RATES
+	/* record rates: 32..96 kHz */
+	static struct snd_pcm_hw_constraint_list adc_rates = {
+		.count = ARRAY_SIZE(rates)-2,
+		.list = rates,
+		.mask = 0
+	};
+#endif
+	/* playback rates: 32..192 kHz */
+	static struct snd_pcm_hw_constraint_list dac_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list = rates,
+		.mask = 0
+	};
+
+	static struct snd_wm8776_ops _wm_ops = { .write = maya44_wm_reg_write };
+	static struct snd_device_ops _dev_ops = {
+		.dev_free = maya44_wm_dev_free,
+		/* .dev_register=..., */
+		/* .dev_disconnect=... */
+	};
+
+	snd_printd(KERN_DEBUG "maya44: maya44_init start\n");
+
+	maya44_spec = kzalloc(sizeof(*maya44_spec), GFP_KERNEL);
+	if (!maya44_spec)
+		return -ENOMEM;
+	ice->spec = maya44_spec;
+
+	/* initialise codecs */
+	ice->num_total_dacs = 4;
+	ice->num_total_adcs = 4;
+	ice->akm_codecs = 0;
+
+	for ( i = 0; i < 2; i++) {
+		struct snd_wm8776 *wm;
+		wm = maya44_spec->wm[i] =
+			kzalloc(sizeof(struct snd_wm8776), GFP_KERNEL);
+		if (!wm)
+			return -ENOMEM;
+		err = snd_device_new(ice->card, SNDRV_DEV_LOWLEVEL,
+							wm, &_dev_ops);
+		if (err < 0) {
+			kfree(wm);
+			return err;
+		}
+		snd_wm8776_init(wm, ice->card, ice, i, &_wm_ops);
+		snd_printd(KERN_DEBUG "maya44: wm8776_init %i done\n", i);
+
+		/* Maya44 line inputs are seen on IN2 */
+		for ( j = WM8776_SW_IN_1; j <= WM8776_SW_IN_5; j++ )
+			snd_wm8776_set_switch(wm, j, (j == WM8776_SW_IN_2));
+	}
+
+/*
+ * set card specific rates.
+ */
+#ifdef SEPARATE_ADC_RATES
+	ice->hw_rates = &dac_rates;
+	ice->hw_rates_adc = &adc_rates;
+#else
+	ice->hw_rates = &dac_rates;
+#endif
+
+	/* register change rate notifier */
+	ice->gpio.set_pro_rate = set_rate;
+
+	/* RDMA1 (2nd input channel) is used for ADC by default */
+	ice->force_rdma1 = 1;
+
+	snd_printd(KERN_DEBUG "maya44: maya44_init finished\n");
+
+	return 0;
+}
+
+
+/*
+ * Maya44 boards don't provide the EEPROM data except for the vendor IDs.
+ * hence the driver needs to sets up it properly.
+ */
+
+static unsigned char maya44_eeprom[] __devinitdata = {
+	[ICE_EEP2_SYSCONF]     = 0x45,	/* clock xin1=49.152MHz, mpu401, 2 stereo ADCs+DACs */
+	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
+	[ICE_EEP2_I2S]         = 0xf8,	/* vol, 96k, 24bit, 192k */
+	[ICE_EEP2_SPDIF]       = 0xc3,	/* enable spdif out, spdif out supp, spdif-in, ext spdif out */
+	[ICE_EEP2_GPIO_DIR]    = 0xff,
+	[ICE_EEP2_GPIO_DIR1]   = 0xff,
+	[ICE_EEP2_GPIO_DIR2]   = 0xff,
+	[ICE_EEP2_GPIO_MASK]   = 0/*0x9f*/,
+	[ICE_EEP2_GPIO_MASK1]  = 0/*0xff*/,
+	[ICE_EEP2_GPIO_MASK2]  = 0/*0x7f*/,
+	[ICE_EEP2_GPIO_STATE]  = GPIO_PHANTOM_OFF | GPIO_SPDIF_IN_INV,
+	[ICE_EEP2_GPIO_STATE1] = 0x00,
+	[ICE_EEP2_GPIO_STATE2] = 0x00,
+};
+
+/* entry point */
+struct snd_ice1712_card_info snd_vt1724_maya44_cards[] __devinitdata = {
+	{
+		.subvendor = VT1724_SUBDEVICE_MAYA44,
+		.name = "ESI Maya44",
+		.model = "maya44",
+		.chip_init = maya44_init,
+		.build_controls = maya44_add_controls,
+		.eeprom_size = sizeof(maya44_eeprom),
+		.eeprom_data = maya44_eeprom,
+	},
+	{ } /* terminator */
+};
diff -r 5715d75f833f pci/ice1712/maya44.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/maya44.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,10 @@
+#ifndef __SOUND_MAYA44_H
+#define __SOUND_MAYA44_H
+
+#define MAYA44_DEVICE_DESC		"{ESI,Maya44},"
+
+#define VT1724_SUBDEVICE_MAYA44		0x34315441	/* Maya44 */
+
+extern struct snd_ice1712_card_info  snd_vt1724_maya44_cards[];
+
+#endif	/* __SOUND_MAYA44_H */
diff -r 5715d75f833f pci/ice1712/phase.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/phase.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/phase.h"
diff -r 5715d75f833f pci/ice1712/pontis.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/pontis.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/pontis.h"
diff -r 5715d75f833f pci/ice1712/prodigy192.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/prodigy192.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/prodigy192.h"
diff -r 5715d75f833f pci/ice1712/prodigy_hifi.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/prodigy_hifi.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/prodigy_hifi.h"
diff -r 5715d75f833f pci/ice1712/revo.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/revo.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/revo.h"
diff -r 5715d75f833f pci/ice1712/se.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/se.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/se.h"
diff -r 5715d75f833f pci/ice1712/vt1720_mobo.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/vt1720_mobo.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/vt1720_mobo.h"
diff -r 5715d75f833f pci/ice1712/wtm.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/wtm.h	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+#include "../../alsa-kernel/pci/ice1712/wtm.h"
diff -r 5715d75f833f scripts
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/scripts	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+alsa-kernel/scripts
\ No newline at end of file
diff -r 5715d75f833f sound
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/sound	Thu Feb 14 00:22:51 2008 +0100
@@ -0,0 +1,1 @@
+alsa-kernel
\ No newline at end of file

--------------000600080204050005040009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000600080204050005040009--
