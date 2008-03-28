From: Rainer Zimmermann <mail@lightshed.de>
Subject: Re: Patch - ESI Maya44 driver
Date: Fri, 28 Mar 2008 22:07:53 +0100
Message-ID: <47ED5E29.4040400@lightshed.de>
References: <47E39BB5.70301@lightshed.de> <s5heja3158m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060802000707010403070401"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server9.dnshoster.de (server9.dnshoster.de [213.202.245.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 9292D103856
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 22:07:26 +0100 (CET)
In-Reply-To: <s5heja3158m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060802000707010403070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable


Hi Takashi,

sorry about this. here's the fixed patch, identical to the last except fo=
r the=20
coding style fixes.

-Rainer


Takashi Iwai wrote:
> At Fri, 21 Mar 2008 12:27:49 +0100,
> Rainer Zimmermann wrote:
>> Hi Takashi,
>>
>> here's the maya44 patch.
>>
>> This is a patch against the current alsa-kernel tree.
>=20
> Thanks.  This looks better than the previous version.
>=20
>> I did add 2 definitions to ice1712.h (snd_ice1724_get_route_val and=20
>> snd_ice1724_put_route_val), which allowed me to move some of the maya4=
4 specific=20
>> code to maya44.c .
>=20
> We could do it in a bit cleaer way, but I think it's OK as is.
>=20
>> There are still a few maya44 special cases in ice1724.c, because maya4=
4 uses the=20
>> "con" channel and routing switches differently. This is not really cle=
an style I=20
>> think, but I would suggest sorting this out later, as it would again r=
equire=20
>> larger changes to ice1724.c and testing with other hardware.
>=20
> Agreed.  This kind of clean up can be done later.
>=20
>> Hope everything is ok with you, for now.
>>
>> This patch does *not* limit the sampling rate to 96kHz for capture, as=
 discussed=20
>> before.
>=20
> The patch looks apparently not compliant to the kernel coding style.
> Could you fix at least the issues reported by checkpatch.pl (the
> latest one)?
>=20
>=20
> thanks,
>=20
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20


--=20
Lightshed IT Services
L=F6fflerstr. 27, 22765 Hamburg, Germany * mail@lightshed.de * www.lights=
hed.de

--------------060802000707010403070401
Content-Type: text/x-patch;
 name="maya44_05.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maya44_05.diff"

diff -r 0d5f43585ca7 Documentation/README.maya44
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/Documentation/README.maya44	Fri Mar 28 21:47:56 2008 +0100
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
diff -r 0d5f43585ca7 i2c/other/Makefile
--- a/i2c/other/Makefile	Sat Mar 22 10:26:05 2008 +0100
+++ b/i2c/other/Makefile	Fri Mar 28 21:47:56 2008 +0100
@@ -8,9 +8,10 @@ snd-ak4xxx-adda-objs := ak4xxx-adda.o
 snd-ak4xxx-adda-objs := ak4xxx-adda.o
 snd-pt2258-objs := pt2258.o
 snd-tea575x-tuner-objs := tea575x-tuner.o
+snd-wm8776-objs := wm8776.o
 
 # Module Dependency
 obj-$(CONFIG_SND_PDAUDIOCF) += snd-ak4117.o
 obj-$(CONFIG_SND_ICE1712) += snd-ak4xxx-adda.o
-obj-$(CONFIG_SND_ICE1724) += snd-ak4114.o snd-ak4xxx-adda.o snd-pt2258.o
+obj-$(CONFIG_SND_ICE1724) += snd-ak4114.o snd-ak4xxx-adda.o snd-pt2258.o snd-wm8776.o
 obj-$(CONFIG_SND_FM801_TEA575X) += snd-tea575x-tuner.o
diff -r 0d5f43585ca7 i2c/other/wm8776.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/i2c/other/wm8776.c	Fri Mar 28 21:47:56 2008 +0100
@@ -0,0 +1,410 @@
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
+#include <sound/wm8776.h>
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
+	if (wm->volumes[index] == value)
+		return 0;
+
+	wm->volumes[index] = value;
+
+	/*
+	 * HEADPHONE (index<2): UPDATE and zero cross enable (0x180),
+	 * ADC GAIN: zero cross enable (0x100),
+	 * DAC ATTEN: UPDATE (0x100)
+	 */
+	flags = (index < 2) ? 0x180 : 0x100;
+	snd_wm8776_reg_write(wm, vi->reg_idx,
+		((value == 0) ? vi->reg_mute : vi->reg_low+value-1) | flags);
+
+	/* handle ADC mute */
+	if (index == WM8776_VOL_ADC_GAIN_L)
+		snd_wm8776_reg_mask(wm, WM8776_REG_ADC_MUX, ~0x80,
+						(value == 0) ? 0x80 : 0);
+
+	if (index == WM8776_VOL_ADC_GAIN_R)
+		snd_wm8776_reg_mask(wm, WM8776_REG_ADC_MUX, ~0x40,
+						(value == 0) ? 0x40 : 0);
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
+	if (sw == wm->switches)
+		return 0;
+	wm->switches = sw;
+	if (vi->reg_inv)
+		value = !value;
+	snd_wm8776_reg_mask(wm, vi->reg_idx, ~vi->reg_mask,
+						value?vi->reg_mask:0);
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
diff -r 0d5f43585ca7 include/wm8776.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/wm8776.h	Fri Mar 28 21:47:56 2008 +0100
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
diff -r 0d5f43585ca7 pci/ice1712/Makefile
--- a/pci/ice1712/Makefile	Sat Mar 22 10:26:05 2008 +0100
+++ b/pci/ice1712/Makefile	Fri Mar 28 21:47:56 2008 +0100
@@ -5,7 +5,7 @@
 
 snd-ice17xx-ak4xxx-objs := ak4xxx.o
 snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o
-snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o vt1720_mobo.o pontis.o prodigy192.o prodigy_hifi.o juli.o phase.o wtm.o se.o
+snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o vt1720_mobo.o pontis.o prodigy192.o prodigy_hifi.o juli.o phase.o wtm.o se.o maya44.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o snd-ice17xx-ak4xxx.o
diff -r 0d5f43585ca7 pci/ice1712/ice1712.h
--- a/pci/ice1712/ice1712.h	Sat Mar 22 10:26:05 2008 +0100
+++ b/pci/ice1712/ice1712.h	Fri Mar 28 21:47:56 2008 +0100
@@ -452,10 +452,17 @@ static inline int snd_ice1712_gpio_read_
 	return  (snd_ice1712_gpio_read(ice) & mask);
 }
 
+/* route access functions */
+int snd_ice1724_get_route_val(struct snd_ice1712 *ice, int shift);
+int snd_ice1724_put_route_val(struct snd_ice1712 *ice, unsigned int val,
+								int shift);
+
 int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice);
 
-int snd_ice1712_akm4xxx_init(struct snd_akm4xxx *ak, const struct snd_akm4xxx *template,
-			     const struct snd_ak4xxx_private *priv, struct snd_ice1712 *ice);
+int snd_ice1712_akm4xxx_init(struct snd_akm4xxx *ak,
+			     const struct snd_akm4xxx *template,
+			     const struct snd_ak4xxx_private *priv,
+			     struct snd_ice1712 *ice);
 void snd_ice1712_akm4xxx_free(struct snd_ice1712 *ice);
 int snd_ice1712_akm4xxx_build_controls(struct snd_ice1712 *ice);
 
diff -r 0d5f43585ca7 pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c	Sat Mar 22 10:26:05 2008 +0100
+++ b/pci/ice1712/ice1724.c	Fri Mar 28 21:47:56 2008 +0100
@@ -49,6 +49,7 @@
 #include "prodigy192.h"
 #include "prodigy_hifi.h"
 #include "juli.h"
+#include "maya44.h"
 #include "phase.h"
 #include "wtm.h"
 #include "se.h"
@@ -65,6 +66,7 @@ MODULE_SUPPORTED_DEVICE("{"
 	       PRODIGY192_DEVICE_DESC
 	       PRODIGY_HIFI_DEVICE_DESC
 	       JULI_DEVICE_DESC
+	       MAYA44_DEVICE_DESC
 	       PHASE_DEVICE_DESC
 	       WTM_DEVICE_DESC
 	       SE_DEVICE_DESC
@@ -439,7 +441,7 @@ static unsigned char stdclock_set_mclk(s
 	return 0;
 }
 
-static void snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
+static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
 				    int force)
 {
 	unsigned long flags;
@@ -447,17 +449,18 @@ static void snd_vt1724_set_pro_rate(stru
 	unsigned int i, old_rate;
 
 	if (rate > ice->hw_rates->list[ice->hw_rates->count - 1])
-		return;
+		return -EINVAL;
+
 	spin_lock_irqsave(&ice->reg_lock, flags);
 	if ((inb(ICEMT1724(ice, DMA_CONTROL)) & DMA_STARTS) ||
 	    (inb(ICEMT1724(ice, DMA_PAUSE)) & DMA_PAUSES)) {
 		/* running? we cannot change the rate now... */
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
-		return;
+		return -EBUSY;
 	}
 	if (!force && is_pro_rate_locked(ice)) {
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
-		return;
+		return (rate == ice->cur_rate) ? 0 : -EBUSY;
 	}
 
 	old_rate = ice->get_rate(ice);
@@ -465,7 +468,7 @@ static void snd_vt1724_set_pro_rate(stru
 		ice->set_rate(ice, rate);
 	else if (rate == ice->cur_rate) {
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
-		return;
+		return 0;
 	}
 
 	ice->cur_rate = rate;
@@ -487,13 +490,15 @@ static void snd_vt1724_set_pro_rate(stru
 	}
 	if (ice->spdif.ops.setup_rate)
 		ice->spdif.ops.setup_rate(ice, rate);
+
+	return 0;
 }
 
 static int snd_vt1724_pcm_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
-	int i, chs;
+	int i, chs, err;
 
 	chs = params_channels(hw_params);
 	mutex_lock(&ice->open_mutex);
@@ -528,7 +533,11 @@ static int snd_vt1724_pcm_hw_params(stru
 		}
 	}
 	mutex_unlock(&ice->open_mutex);
-	snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
+
+	err = snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
+	if (err < 0)
+		return err;
+
 	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 }
 
@@ -654,19 +663,39 @@ static snd_pcm_uframes_t snd_vt1724_pcm_
 #endif
 }
 
-static const struct vt1724_pcm_reg vt1724_playback_pro_reg = {
+static const struct vt1724_pcm_reg vt1724_pdma0_reg = {
 	.addr = VT1724_MT_PLAYBACK_ADDR,
 	.size = VT1724_MT_PLAYBACK_SIZE,
 	.count = VT1724_MT_PLAYBACK_COUNT,
 	.start = VT1724_PDMA0_START,
 };
 
-static const struct vt1724_pcm_reg vt1724_capture_pro_reg = {
+static const struct vt1724_pcm_reg vt1724_pdma4_reg = {
+	.addr = VT1724_MT_PDMA4_ADDR,
+	.size = VT1724_MT_PDMA4_SIZE,
+	.count = VT1724_MT_PDMA4_COUNT,
+	.start = VT1724_PDMA4_START,
+};
+
+static const struct vt1724_pcm_reg vt1724_rdma0_reg = {
 	.addr = VT1724_MT_CAPTURE_ADDR,
 	.size = VT1724_MT_CAPTURE_SIZE,
 	.count = VT1724_MT_CAPTURE_COUNT,
 	.start = VT1724_RDMA0_START,
 };
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
 
 static const struct snd_pcm_hardware snd_vt1724_playback_pro =
 {
@@ -801,10 +830,12 @@ static int snd_vt1724_capture_pro_open(s
 
 	runtime->private_data = (void *)&vt1724_capture_pro_reg;
 	ice->capture_pro_substream = substream;
+
 	runtime->hw = snd_vt1724_2ch_stereo;
 	snd_pcm_set_sync(substream);
 	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
 	set_rate_constraints(ice, substream);
+
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
@@ -830,6 +861,7 @@ static int snd_vt1724_capture_pro_close(
 	if (PRO_RATE_RESET)
 		snd_vt1724_set_pro_rate(ice, ice->pro_rate_default, 0);
 	ice->capture_pro_substream = NULL;
+
 	return 0;
 }
 
@@ -884,20 +916,6 @@ static int __devinit snd_vt1724_pcm_prof
 /*
  * SPDIF PCM
  */
-
-static const struct vt1724_pcm_reg vt1724_playback_spdif_reg = {
-	.addr = VT1724_MT_PDMA4_ADDR,
-	.size = VT1724_MT_PDMA4_SIZE,
-	.count = VT1724_MT_PDMA4_COUNT,
-	.start = VT1724_PDMA4_START,
-};
-
-static const struct vt1724_pcm_reg vt1724_capture_spdif_reg = {
-	.addr = VT1724_MT_RDMA1_ADDR,
-	.size = VT1724_MT_RDMA1_SIZE,
-	.count = VT1724_MT_RDMA1_COUNT,
-	.start = VT1724_RDMA1_START,
-};
 
 /* update spdif control bits; call with reg_lock */
 static void update_spdif_bits(struct snd_ice1712 *ice, unsigned int val)
@@ -1065,7 +1083,7 @@ static int __devinit snd_vt1724_pcm_spdi
 	if (ice->force_pdma4 || ice->force_rdma1)
 		name = "ICE1724 Secondary";
 	else
-		name = "IEC1724 IEC958";
+		name = "ICE1724 IEC958";
 	err = snd_pcm_new(ice->card, name, device, play, capt, &pcm);
 	if (err < 0)
 		return err;
@@ -1769,7 +1787,7 @@ static inline int digital_route_shift(in
 	return idx * 3;
 }
 
-static int get_route_val(struct snd_ice1712 *ice, int shift)
+int snd_ice1724_get_route_val(struct snd_ice1712 *ice, int shift)
 {
 	unsigned long val;
 	unsigned char eitem;
@@ -1788,7 +1806,8 @@ static int get_route_val(struct snd_ice1
 	return eitem;
 }
 
-static int put_route_val(struct snd_ice1712 *ice, unsigned int val, int shift)
+int snd_ice1724_put_route_val(struct snd_ice1712 *ice, unsigned int val,
+								int shift)
 {
 	unsigned int old_val, nval;
 	int change;
@@ -1816,7 +1835,7 @@ static int snd_vt1724_pro_route_analog_g
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	ucontrol->value.enumerated.item[0] =
-		get_route_val(ice, analog_route_shift(idx));
+		snd_ice1724_get_route_val(ice, analog_route_shift(idx));
 	return 0;
 }
 
@@ -1825,8 +1844,9 @@ static int snd_vt1724_pro_route_analog_p
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
-	return put_route_val(ice, ucontrol->value.enumerated.item[0],
-			     analog_route_shift(idx));
+	return snd_ice1724_put_route_val(ice,
+					 ucontrol->value.enumerated.item[0],
+					 analog_route_shift(idx));
 }
 
 static int snd_vt1724_pro_route_spdif_get(struct snd_kcontrol *kcontrol,
@@ -1835,7 +1855,7 @@ static int snd_vt1724_pro_route_spdif_ge
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	ucontrol->value.enumerated.item[0] =
-		get_route_val(ice, digital_route_shift(idx));
+		snd_ice1724_get_route_val(ice, digital_route_shift(idx));
 	return 0;
 }
 
@@ -1844,11 +1864,13 @@ static int snd_vt1724_pro_route_spdif_pu
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
-	return put_route_val(ice, ucontrol->value.enumerated.item[0],
-			     digital_route_shift(idx));
-}
-
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata = {
+	return snd_ice1724_put_route_val(ice,
+					 ucontrol->value.enumerated.item[0],
+					 digital_route_shift(idx));
+}
+
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata =
+{
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Playback Route",
 	.info = snd_vt1724_pro_route_info,
@@ -1915,6 +1937,7 @@ static struct snd_ice1712_card_info *car
 	snd_vt1724_prodigy_hifi_cards,
 	snd_vt1724_prodigy192_cards,
 	snd_vt1724_juli_cards,
+	snd_vt1724_maya44_cards,
 	snd_vt1724_phase_cards,
 	snd_vt1724_wtm_cards,
 	snd_vt1724_se_cards,
@@ -2048,9 +2071,12 @@ static int __devinit snd_vt1724_chip_ini
 static int __devinit snd_vt1724_chip_init(struct snd_ice1712 *ice)
 {
 	outb(VT1724_RESET , ICEREG1724(ice, CONTROL));
+	inb(ICEREG1724(ice, CONTROL)); /* pci posting flush */
 	udelay(200);
 	outb(0, ICEREG1724(ice, CONTROL));
+	inb(ICEREG1724(ice, CONTROL)); /* pci posting flush */
 	udelay(200);
+
 	outb(ice->eeprom.data[ICE_EEP2_SYSCONF], ICEREG1724(ice, SYS_CFG));
 	outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97_CFG));
 	outb(ice->eeprom.data[ICE_EEP2_I2S], ICEREG1724(ice, I2S_FEATURES));
@@ -2074,9 +2100,12 @@ static int __devinit snd_vt1724_spdif_bu
 
 	snd_assert(ice->pcm != NULL, return -EIO);
 
-	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_mixer_pro_spdif_route, ice));
-	if (err < 0)
-		return err;
+	if (ice->eeprom.subvendor != VT1724_SUBDEVICE_MAYA44) {
+		err = snd_ctl_add(ice->card,
+			snd_ctl_new1(&snd_vt1724_mixer_pro_spdif_route, ice));
+		if (err < 0)
+			return err;
+	}
 
 	err = snd_ctl_add(ice->card, snd_ctl_new1(&snd_vt1724_spdif_switch, ice));
 	if (err < 0)
@@ -2123,7 +2152,12 @@ static int __devinit snd_vt1724_build_co
 	if (err < 0)
 		return err;
 
-	if (ice->num_total_dacs > 0) {
+	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_MAYA44) {
+		err = snd_ctl_add(ice->card,
+			snd_ctl_new1(&snd_vt1724_mixer_pro_maya44_route, ice));
+		if (err < 0)
+			return err;
+	} else if (ice->num_total_dacs > 0) {
 		struct snd_kcontrol_new tmp = snd_vt1724_mixer_pro_analog_route;
 		tmp.count = ice->num_total_dacs;
 		if (ice->vt1720 && tmp.count > 2)
@@ -2390,6 +2424,7 @@ static int __devinit snd_vt1724_probe(st
 	}
 	pci_set_drvdata(pci, card);
 	dev++;
+
 	return 0;
 }
 
diff -r 0d5f43585ca7 pci/ice1712/maya44.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/maya44.c	Fri Mar 28 21:47:56 2008 +0100
@@ -0,0 +1,761 @@
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
+#include <sound/wm8776.h>
+
+#include "ice1712.h"
+#include "envy24ht.h"
+#include "maya44.h"
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
+	snd_vt1724_write_i2c(ice,
+			     chip ? WM8776_1_ADDR : WM8776_0_ADDR,
+			     (addr<<1) | ((data>>8) & 1),
+			     data&0xff
+			     );
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
+	for (i = 0; i < 2; i++)
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
+	  .index = { WM8776_VOL_HEADPHONE_L, WM8776_VOL_HEADPHONE_R } },
+	{ .name = "PCM Playback Volume",
+	  .index = { WM8776_VOL_DAC_L, WM8776_VOL_DAC_R } },
+	{ .name = "Line Capture Volume",
+	  .index = { WM8776_VOL_ADC_GAIN_L, WM8776_VOL_ADC_GAIN_R } },
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
+	switch (kcontrol->private_value) {
+	case SW_PHANTOM:
+		set_gpio_bits(ice, GPIO_PHANTOM_OFF,
+					set ? 0 : GPIO_PHANTOM_OFF);
+		break;
+	case SW_MIC:
+		set_gpio_bits(ice, GPIO_MIC_RELAY,
+					set ? GPIO_MIC_RELAY : 0);
+		/* line input = IN2, mic input = IN4 */
+		for (j = WM8776_SW_IN_1; j <= WM8776_SW_IN_5; j++)
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
+/*
+ * Maya44 routing switch settings have different meanings than the standard
+ * ice1724 switches as defined in snd_vt1724_pro_route_info (ice1724.c).
+ */
+int snd_vt1724_pro_route_maya44_info(struct snd_kcontrol *kcontrol,
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
+int maya44_route_shift(int idx)
+{
+	static const unsigned char shift[10] =
+				{ 8, 20, 0, 3, 11, 23, 14, 26, 17, 29 };
+	return shift[idx%10];
+}
+
+static int snd_vt1724_pro_route_maya44_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	ucontrol->value.enumerated.item[0] =
+		snd_ice1724_get_route_val(ice, maya44_route_shift(idx));
+	return 0;
+}
+
+static int snd_vt1724_pro_route_maya44_put(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	return snd_ice1724_put_route_val(ice,
+					 ucontrol->value.enumerated.item[0],
+					 maya44_route_shift(idx));
+}
+
+
+struct snd_kcontrol_new snd_vt1724_mixer_pro_maya44_route __devinitdata =
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
+	for (pv = wm_vol_controls; pv->name != NULL; pv++) {
+		newc.name = pv->name;
+		newc.tlv.p =
+			snd_wm8776_get_volume_info(pv->index[0])->tlv_scale;
+
+		for (newc.index = 0; newc.index < 2; newc.index++) {
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
+	for (ps = wm_switch_controls; ps->name != NULL; ps++) {
+		newc.name = ps->name;
+		for (newc.index = 0; newc.index < 2; newc.index++) {
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
+		for (i = 0; i < 24; i++) {
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
+	for (i = 0; i < 2; i++) {
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
+		for (j = WM8776_SW_IN_1; j <= WM8776_SW_IN_5; j++)
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
+	[ICE_EEP2_SYSCONF]     = 0x45,
+		/* clock xin1=49.152MHz, mpu401, 2 stereo ADCs+DACs */
+	[ICE_EEP2_ACLINK]      = 0x80,
+		/* I2S */
+	[ICE_EEP2_I2S]         = 0xf8,
+		/* vol, 96k, 24bit, 192k */
+	[ICE_EEP2_SPDIF]       = 0xc3,
+		/* enable spdif out, spdif out supp, spdif-in, ext spdif out */
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
diff -r 0d5f43585ca7 pci/ice1712/maya44.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/ice1712/maya44.h	Fri Mar 28 21:47:56 2008 +0100
@@ -0,0 +1,16 @@
+#ifndef __SOUND_MAYA44_H
+#define __SOUND_MAYA44_H
+
+#define MAYA44_DEVICE_DESC		"{ESI,Maya44},"
+
+#define VT1724_SUBDEVICE_MAYA44		0x34315441	/* Maya44 */
+
+extern struct snd_ice1712_card_info  snd_vt1724_maya44_cards[];
+
+int snd_vt1724_pro_route_maya44_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo);
+int maya44_route_shift(int idx);
+
+extern struct snd_kcontrol_new snd_vt1724_mixer_pro_maya44_route;
+
+#endif	/* __SOUND_MAYA44_H */

--------------060802000707010403070401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060802000707010403070401--
