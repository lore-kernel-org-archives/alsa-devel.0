From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: core and dapm headers
Date: Fri, 22 Sep 2006 17:56:19 +0100
Message-ID: <1158944179.18071.89.camel@localhost.localdomain>
References: <1158326319.22950.67.camel@localhost.localdomain>
	<s5hmz8whvwo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3VhwjyzjGiAbAdxq6VjO"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz8whvwo.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-3VhwjyzjGiAbAdxq6VjO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-09-19 at 14:40 +0200, Takashi Iwai wrote:
> At Fri, 15 Sep 2006 14:18:39 +0100,
> Liam Girdwood wrote:
> > 
> > +#define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, wevent, wflags) \
> > +{.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
> > + .invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, .event = wevent, \
> > + .event_flags = wflags}
> 
> Could you try to fold lines to fit within 80 chars?
> I know we have long lines in ALSA codes, but we should start fixing it
> from the new codes :)
> 
> 

Np, changes made.

Forgot to mention this patch also adds an AC97 warm reset to
snd_ac97_bus_ops. Although, this is only used in ASoC atm.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam

--=-3VhwjyzjGiAbAdxq6VjO
Content-Disposition: attachment; filename=asoc-include.patch
Content-Type: text/x-patch; name=asoc-include.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/include/soc-dapm.h
===================================================================
--- /dev/null
+++ alsa-kernel/include/soc-dapm.h
@@ -0,0 +1,286 @@
+/*
+ * linux/sound/soc-dapm.h -- ALSA SoC Dynamic Audio Power Management
+ *
+ * Author:		Liam Girdwood
+ * Created:		Aug 11th 2005
+ * Copyright:	Wolfson Microelectronics. PLC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_SOC_DAPM_H
+#define __LINUX_SND_SOC_DAPM_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <sound/control.h>
+#include <sound/soc.h>
+
+/* widget has no PM register bit */
+#define SND_SOC_NOPM	-1
+
+/*
+ * SoC dynamic audio power managment
+ *
+ * We can have upto 4 power domains
+ * 	1. Codec domain - VREF, VMID
+ *     Usually controlled at codec probe/remove, although can be set
+ *     at stream time if power is not needed for sidetone, etc.
+ *  2. Platform/Machine domain - physically connected inputs and outputs
+ *     Is platform/machine and user action specific, is set in the machine
+ *     driver and by userspace e.g when HP are inserted
+ *  3. Path domain - Internal codec path mixers
+ *     Are automatically set when mixer and mux settings are
+ *     changed by the user.
+ *  4. Stream domain - DAC's and ADC's.
+ *     Enabled when stream playback/capture is started.
+ */
+
+/* codec domain */
+#define SND_SOC_DAPM_VMID(wname) \
+{	.id = snd_soc_dapm_vmid, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0}
+
+/* platform domain */
+#define SND_SOC_DAPM_INPUT(wname) \
+{	.id = snd_soc_dapm_input, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0}
+#define SND_SOC_DAPM_OUTPUT(wname) \
+{	.id = snd_soc_dapm_output, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0}
+#define SND_SOC_DAPM_MIC(wname, wevent) \
+{	.id = snd_soc_dapm_mic, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0, .event = wevent, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
+#define SND_SOC_DAPM_HP(wname, wevent) \
+{	.id = snd_soc_dapm_hp, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0, .event = wevent, \
+	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
+#define SND_SOC_DAPM_SPK(wname, wevent) \
+{	.id = snd_soc_dapm_spk, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0, .event = wevent, \
+	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
+#define SND_SOC_DAPM_LINE(wname, wevent) \
+{	.id = snd_soc_dapm_line, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0, .event = wevent, \
+	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
+
+/* path domain */
+#define SND_SOC_DAPM_PGA(wname, wreg, wshift, winvert,\
+	 wcontrols, wncontrols) \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+#define SND_SOC_DAPM_MIXER(wname, wreg, wshift, winvert, \
+	 wcontrols, wncontrols)\
+{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
+#define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
+{	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = NULL, .num_kcontrols = 0}
+#define SND_SOC_DAPM_SWITCH(wname, wreg, wshift, winvert, wcontrols) \
+{	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+#define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
+{	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+
+/* path domain with event - event handler must return 0 for success */
+#define SND_SOC_DAPM_PGA_E(wname, wreg, wshift, winvert, wcontrols, \
+	wncontrols, wevent, wflags) \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_MIXER_E(wname, wreg, wshift, winvert, wcontrols, \
+	wncontrols, wevent, wflags) \
+{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_MICBIAS_E(wname, wreg, wshift, winvert, wevent, wflags) \
+{	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = NULL, .num_kcontrols = 0, \
+	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
+	wevent, wflags) \
+{	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1 \
+	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
+	wevent, wflags) \
+{	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
+	.event = wevent, .event_flags = wflags}
+
+/* events that are pre and post DAPM */
+#define SND_SOC_DAPM_PRE(wname, wevent) \
+{	.id = snd_soc_dapm_pre, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0, .event = wevent, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD}
+#define SND_SOC_DAPM_POST(wname, wevent) \
+{	.id = snd_soc_dapm_post, .name = wname, .kcontrols = NULL, \
+	.num_kcontrols = 0, .event = wevent, \
+	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD}
+
+/* stream domain */
+#define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
+{	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
+	.shift = wshift, .invert = winvert}
+#define SND_SOC_DAPM_ADC(wname, stname, wreg, wshift, winvert) \
+{	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
+	.shift = wshift, .invert = winvert}
+
+/* dapm kcontrol types */
+#define SOC_DAPM_SINGLE(xname, reg, shift, mask, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }
+#define SOC_DAPM_DOUBLE(xname, reg, shift_left, shift_right, mask, invert, \
+	power) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_volsw, \
+ 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+ 	.private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) |\
+ 		 ((mask) << 16) | ((invert) << 24) }
+#define SOC_DAPM_ENUM(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_enum_double, \
+ 	.get = snd_soc_dapm_get_enum_double, \
+ 	.put = snd_soc_dapm_put_enum_double, \
+  	.private_value = (unsigned long)&xenum }
+
+/* dapm stream operations */
+#define SND_SOC_DAPM_STREAM_NOP			0x0
+#define SND_SOC_DAPM_STREAM_START		0x1
+#define SND_SOC_DAPM_STREAM_STOP		0x2
+#define SND_SOC_DAPM_STREAM_SUSPEND		0x4
+#define SND_SOC_DAPM_STREAM_RESUME		0x8
+#define SND_SOC_DAPM_STREAM_PAUSE_PUSH	0x10
+#define SND_SOC_DAPM_STREAM_PAUSE_RELEASE	0x20
+
+/* dapm event types */
+#define SND_SOC_DAPM_PRE_PMU	0x1 	/* before widget power up */
+#define SND_SOC_DAPM_POST_PMU	0x2		/* after widget power up */
+#define SND_SOC_DAPM_PRE_PMD	0x4 	/* before widget power down */
+#define SND_SOC_DAPM_POST_PMD	0x8		/* after widget power down */
+#define SND_SOC_DAPM_PRE_REG	0x10	/* before audio path setup */
+#define SND_SOC_DAPM_POST_REG	0x20	/* after audio path setup */
+
+/* convenience event type detection */
+#define SND_SOC_DAPM_EVENT_ON(e)	\
+	(e & (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU))
+#define SND_SOC_DAPM_EVENT_OFF(e)	\
+	(e & (SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD))
+
+struct snd_soc_dapm_widget;
+enum snd_soc_dapm_type;
+struct snd_soc_dapm_path;
+struct snd_soc_dapm_pin;
+
+/* dapm controls */
+int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget);
+
+/* dapm path setup */
+int snd_soc_dapm_connect_input(struct snd_soc_codec *codec,
+	const char *sink_name, const char *control_name, const char *src_name);
+int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
+void snd_soc_dapm_free(struct snd_soc_device *socdev);
+
+/* dapm events */
+int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
+	int event);
+
+/* dapm sys fs - used by the core */
+int snd_soc_dapm_sys_add(struct device *dev);
+
+/* dapm audio endpoint control */
+int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
+	char *pin, int status);
+int snd_soc_dapm_sync_endpoints(struct snd_soc_codec *codec);
+
+/* dapm widget types */
+enum snd_soc_dapm_type {
+	snd_soc_dapm_input = 0,		/* input pin */
+	snd_soc_dapm_output,		/* output pin */
+	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
+	snd_soc_dapm_mixer,			/* mixes several analog signals together */
+	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
+	snd_soc_dapm_adc,			/* analog to digital converter */
+	snd_soc_dapm_dac,			/* digital to analog converter */
+	snd_soc_dapm_micbias,		/* microphone bias (power) */
+	snd_soc_dapm_mic,			/* microphone */
+	snd_soc_dapm_hp,			/* headphones */
+	snd_soc_dapm_spk,			/* speaker */
+	snd_soc_dapm_line,			/* line input/output */
+	snd_soc_dapm_switch,		/* analog switch */
+	snd_soc_dapm_vmid,			/* codec bias/vmid - to minimise pops */
+	snd_soc_dapm_pre,			/* machine specific pre widget - exec first */
+	snd_soc_dapm_post,			/* machine specific post widget - exec last */
+};
+
+/* dapm audio path between two widgets */
+struct snd_soc_dapm_path {
+	char *name;
+	char *long_name;
+
+	/* source (input) and sink (output) widgets */
+	struct snd_soc_dapm_widget *source;
+	struct snd_soc_dapm_widget *sink;
+	struct snd_kcontrol *kcontrol;
+
+	/* status */
+	u32 connect:1;	/* source and sink widgets are connected */
+	u32 walked:1;	/* path has been walked */
+
+	struct list_head list_source;
+	struct list_head list_sink;
+	struct list_head list;
+};
+
+/* dapm widget */
+struct snd_soc_dapm_widget {
+	enum snd_soc_dapm_type id;
+	char *name;		/* widget name */
+	char *sname;	/* stream name */
+	struct snd_soc_codec *codec;
+	struct list_head list;
+
+	/* dapm control */
+	short reg;						/* negative reg = no direct dapm */
+	unsigned char shift;			/* bits to shift */
+	unsigned int saved_value;		/* widget saved value */
+	unsigned int value;				/* widget current value */
+	unsigned char power:1;			/* block power status */
+	unsigned char invert:1;			/* invert the power bit */
+	unsigned char active:1;			/* active stream on DAC, ADC's */
+	unsigned char connected:1;		/* connected codec pin */
+	unsigned char new:1;			/* cnew complete */
+	unsigned char ext:1;			/* has external widgets */
+	unsigned char muted:1;			/* muted for pop reduction */
+	unsigned char suspend:1;		/* was active before suspend */
+	unsigned char pmdown:1;			/* waiting for timeout */
+
+	/* external events */
+	unsigned short event_flags;		/* flags to specify event types */
+	int (*event)(struct snd_soc_dapm_widget*, int);
+
+	/* kcontrols that relate to this widget */
+	int num_kcontrols;
+	const struct snd_kcontrol_new *kcontrols;
+
+	/* widget input and outputs */
+	struct list_head sources;
+	struct list_head sinks;
+};
+
+#endif
Index: alsa-kernel/include/soc.h
===================================================================
--- /dev/null
+++ alsa-kernel/include/soc.h
@@ -0,0 +1,480 @@
+/*
+ * linux/sound/soc.h -- ALSA SoC Layer
+ *
+ * Author:		Liam Girdwood
+ * Created:		Aug 11th 2005
+ * Copyright:	Wolfson Microelectronics. PLC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_SOC_H
+#define __LINUX_SND_SOC_H
+
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/control.h>
+#include <sound/ac97_codec.h>
+
+#define SND_SOC_VERSION "0.11.8"
+
+/*
+ * Convenience kcontrol builders
+ */
+#define SOC_SINGLE_VALUE(reg,shift,mask,invert) ((reg) | ((shift) << 8) |\
+	((shift) << 12) | ((mask) << 16) | ((invert) << 24))
+#define SOC_SINGLE_VALUE_EXT(reg,mask,invert) ((reg) | ((mask) << 16) |\
+	((invert) << 31))
+#define SOC_SINGLE(xname, reg, shift, mask, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
+	.put = snd_soc_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, mask, invert) }
+#define SOC_DOUBLE(xname, reg, shift_left, shift_right, mask, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
+	.put = snd_soc_put_volsw, \
+	.private_value = (reg) | ((shift_left) << 8) | \
+		((shift_right) << 12) | ((mask) << 16) | ((invert) << 24) }
+#define SOC_DOUBLE_R(xname, reg_left, reg_right, shift, mask, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_volsw_2r, \
+	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
+	.private_value = (reg_left) | ((shift) << 8)  | \
+		((mask) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+#define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
+{	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
+	.mask = xmask, .texts = xtexts }
+#define SOC_ENUM_SINGLE(xreg, xshift, xmask, xtexts) \
+	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xtexts)
+#define SOC_ENUM_SINGLE_EXT(xmask, xtexts) \
+{	.mask = xmask, .texts = xtexts }
+#define SOC_ENUM(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
+	.info = snd_soc_info_enum_double, \
+	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
+	.private_value = (unsigned long)&xenum }
+#define SOC_SINGLE_EXT(xname, xreg, xmask, xinvert,\
+	 xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw_ext, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value =  SOC_SINGLE_VALUE_EXT(xreg, xmask, xinvert) }
+#define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_bool_ext, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = xdata }
+#define SOC_ENUM_EXT(xname, xenum, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_enum_ext, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&xenum }
+
+/*
+ * Digital Audio Interface (DAI) types
+ */
+#define SND_SOC_DAI_AC97	0x1
+#define SND_SOC_DAI_I2S		0x2
+#define SND_SOC_DAI_PCM		0x4
+
+/*
+ * DAI hardware audio formats
+ */
+#define SND_SOC_DAIFMT_I2S		(1 << 0)	/* I2S mode */
+#define SND_SOC_DAIFMT_RIGHT_J	(1 << 1)	/* Right justified mode */
+#define SND_SOC_DAIFMT_LEFT_J	(1 << 2)	/* Left Justified mode */
+#define SND_SOC_DAIFMT_DSP_A	(1 << 3)	/* L data msb after FRM or LRC */
+#define SND_SOC_DAIFMT_DSP_B	(1 << 4)	/* L data msb during FRM or LRC */
+#define SND_SOC_DAIFMT_AC97		(1 << 5)	/* AC97 */
+
+/*
+ * DAI hardware signal inversions
+ */
+#define SND_SOC_DAIFMT_NB_NF		(1 << 8)	/* normal bit clock + frame */
+#define SND_SOC_DAIFMT_NB_IF		(1 << 9)	/* normal bclk + inv frm */
+#define SND_SOC_DAIFMT_IB_NF		(1 << 10)	/* invert bclk + nor frm */
+#define SND_SOC_DAIFMT_IB_IF		(1 << 11)	/* invert bclk + frm */
+
+/*
+ * DAI hardware clock masters
+ * This is wrt the codec, the inverse is true for the interface
+ * i.e. if the codec is clk and frm master then the interface is
+ * clk and frame slave.
+ */
+#define SND_SOC_DAIFMT_CBM_CFM	(1 << 12) /* codec clk & frm master */
+#define SND_SOC_DAIFMT_CBS_CFM	(1 << 13) /* codec clk slave & frm master */
+#define SND_SOC_DAIFMT_CBM_CFS	(1 << 14) /* codec clk master & frame slave */
+#define SND_SOC_DAIFMT_CBS_CFS	(1 << 15) /* codec clk & frm slave */
+
+#define SND_SOC_DAIFMT_FORMAT_MASK		0x00ff
+#define SND_SOC_DAIFMT_INV_MASK			0x0f00
+#define SND_SOC_DAIFMT_CLOCK_MASK		0xf000
+
+/*
+ * DAI hardware audio direction
+ */
+#define SND_SOC_DAIDIR_PLAYBACK		0x1
+#define SND_SOC_DAIDIR_CAPTURE		0x2
+
+/*
+ * DAI hardware Time Division Multiplexing (TDM) Slots
+ * Left and Right data word positions
+ * This is measured in words (sample size) and not bits.
+ */
+#define SND_SOC_DAITDM_LRDW(l,r)	((l << 8) | r)
+
+/*
+ * DAI hardware clock ratios
+ * bit clock can either be a generated by dividing mclk or
+ * by multiplying sample rate, hence there are 2 definitions below
+ * depending on codec type.
+ */
+/* ratio of sample rate to mclk/sysclk */
+#define SND_SOC_FS_ALL			0xffff	/* all mclk supported */
+
+/* bit clock dividers */
+#define SND_SOC_FSBD(x)			(1 << (x - 1))	/* ratio mclk:bclk */
+#define SND_SOC_FSBD_REAL(x)	(ffs(x))
+#define SND_SOC_FSBD_ALL		0xffff /* all bit clock dividers supported */
+
+/* bit clock ratio to sample rate */
+#define SND_SOC_FSB(x)			(1 << ((x - 16) / 16))
+#define SND_SOC_FSB_REAL(x)		(((ffs(x) - 1) * 16) + 16)
+/* all bclk ratios supported */
+#define SND_SOC_FSB_ALL			SND_SOC_FSBD_ALL
+
+/*
+ * DAI hardware flags
+ */
+/* use bfs mclk divider mode, else sample rate ratio */
+#define SND_SOC_DAI_BFS_DIV	0x1
+
+/*
+ * AC97 codec ID's bitmask
+ */
+#define SND_SOC_DAI_AC97_ID0	(1 << 0)
+#define SND_SOC_DAI_AC97_ID1	(1 << 1)
+#define SND_SOC_DAI_AC97_ID2	(1 << 2)
+#define SND_SOC_DAI_AC97_ID3	(1 << 3)
+
+struct snd_soc_device;
+struct snd_soc_pcm_stream;
+struct snd_soc_ops;
+struct snd_soc_dai_mode;
+struct snd_soc_pcm_runtime;
+struct snd_soc_codec_dai;
+struct snd_soc_cpu_dai;
+struct snd_soc_codec;
+struct snd_soc_machine_config;
+struct soc_enum;
+struct snd_soc_ac97_ops;
+struct snd_soc_clock_info;
+
+typedef int (*hw_write_t)(void *,const char* ,int);
+typedef int (*hw_read_t)(void *,char* ,int);
+
+extern struct snd_ac97_bus_ops soc_ac97_ops;
+
+/* pcm <-> DAI connect */
+void snd_soc_free_pcms(struct snd_soc_device *socdev);
+int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid);
+int snd_soc_register_card(struct snd_soc_device *socdev);
+
+/* set runtime hw params */
+int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
+	const struct snd_pcm_hardware *hw);
+int snd_soc_get_rate(int rate);
+
+/* codec IO */
+#define snd_soc_read(codec, reg) codec->read(codec, reg)
+#define snd_soc_write(codec, reg, value) codec->write(codec, reg, value)
+
+/* codec register bit access */
+int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
+				unsigned short mask, unsigned short value);
+int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
+				unsigned short mask, unsigned short value);
+
+int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
+	struct snd_ac97_bus_ops *ops, int num);
+void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
+
+/*
+ *Controls
+ */
+struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
+	void *data, char *long_name);
+int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_info_volsw_ext(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_info_bool_ext(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+
+/* SoC PCM stream information */
+struct snd_soc_pcm_stream {
+	char *stream_name;
+	unsigned int rate_min;		/* min rate */
+	unsigned int rate_max;		/* max rate */
+	unsigned int channels_min;	/* min channels */
+	unsigned int channels_max;	/* max channels */
+	unsigned int active:1;		/* stream is in use */
+};
+
+/* SoC audio ops */
+struct snd_soc_ops {
+	int (*startup)(struct snd_pcm_substream *);
+	void (*shutdown)(struct snd_pcm_substream *);
+	int (*hw_params)(struct snd_pcm_substream *, struct snd_pcm_hw_params *);
+	int (*hw_free)(struct snd_pcm_substream *);
+	int (*prepare)(struct snd_pcm_substream *);
+	int (*trigger)(struct snd_pcm_substream *, int);
+};
+
+/* SoC DAI hardware mode */
+struct snd_soc_dai_mode {
+	u16 fmt;		/* SND_SOC_DAIFMT_* */
+	u16 tdm;		/* SND_SOC_HWTDM_* */
+	u64 pcmfmt; 	/* SNDRV_PCM_FMTBIT_* */
+	u16 pcmrate;	/* SND_SOC_HWRATE_* */
+	u16 pcmdir:2;	/* SND_SOC_HWDIR_* */
+	u16 flags:8;	/* hw flags */
+	u16 fs;			/* mclk to rate divider */
+	u32 bfs;		/* mclk to bclk dividers */
+	unsigned long priv;		/* private mode data */
+};
+
+/* DAI capabilities */
+struct snd_soc_dai_cap {
+	int num_modes;				/* number of DAI modes */
+	struct snd_soc_dai_mode *mode;	/* array of supported DAI modes */
+};
+
+/* SoC Codec DAI */
+struct snd_soc_codec_dai {
+	char *name;
+	int id;
+
+	/* DAI capabilities */
+	struct snd_soc_pcm_stream playback;
+	struct snd_soc_pcm_stream capture;
+	struct snd_soc_dai_cap caps;
+
+	/* DAI runtime info */
+	struct snd_soc_dai_mode dai_runtime;
+	struct snd_soc_ops ops;
+	unsigned int (*config_sysclk)(struct snd_soc_codec_dai*,
+		struct snd_soc_clock_info *info, unsigned int clk);
+	int (*digital_mute)(struct snd_soc_codec *,
+		struct snd_soc_codec_dai*, int);
+	unsigned int mclk;		/* the audio master clock */
+	unsigned int pll_in;	/* the PLL input clock */
+	unsigned int pll_out;	/* the PLL output clock */
+	unsigned int clk_div;	/* internal clock divider << 1 (for fractions) */
+	unsigned int active;
+	unsigned char pop_wait:1;
+
+	/* DAI private data */
+	void *private_data;
+};
+
+/* SoC CPU DAI */
+struct snd_soc_cpu_dai {
+
+	/* DAI description */
+	char *name;
+	unsigned int id;
+	unsigned char type;
+
+	/* DAI callbacks */
+	int (*probe)(struct platform_device *pdev);
+	void (*remove)(struct platform_device *pdev);
+	int (*suspend)(struct platform_device *pdev,
+		struct snd_soc_cpu_dai *cpu_dai);
+	int (*resume)(struct platform_device *pdev,
+		struct snd_soc_cpu_dai *cpu_dai);
+	unsigned int (*config_sysclk)(struct snd_soc_cpu_dai *cpu_dai,
+		struct snd_soc_clock_info *info, unsigned int clk);
+
+	/* DAI capabilities */
+	struct snd_soc_pcm_stream capture;
+	struct snd_soc_pcm_stream playback;
+	struct snd_soc_dai_cap caps;
+
+	/* DAI runtime info */
+	struct snd_soc_dai_mode dai_runtime;
+	struct snd_soc_ops ops;
+	struct snd_pcm_runtime *runtime;
+	unsigned char active:1;
+	unsigned int mclk;
+	void *dma_data;
+
+	/* DAI private data */
+	void *private_data;
+};
+
+/* SoC Audio Codec */
+struct snd_soc_codec {
+	char *name;
+	struct module *owner;
+	struct mutex mutex;
+
+	/* callbacks */
+	int (*dapm_event)(struct snd_soc_codec *codec, int event);
+
+	/* runtime */
+	struct snd_card *card;
+	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
+	unsigned int active;
+	unsigned int pcm_devs;
+	void *private_data;
+
+	/* codec IO */
+	void *control_data; /* codec control (i2c/3wire) data */
+	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
+	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	hw_write_t hw_write;
+	hw_read_t hw_read;
+	void *reg_cache;
+	short reg_cache_size;
+	short reg_cache_step;
+
+	/* dapm */
+	struct list_head dapm_widgets;
+	struct list_head dapm_paths;
+	unsigned int dapm_state;
+	unsigned int suspend_dapm_state;
+
+	/* codec DAI's */
+	struct snd_soc_codec_dai *dai;
+	unsigned int num_dai;
+};
+
+/* codec device */
+struct snd_soc_codec_device {
+	int (*probe)(struct platform_device *pdev);
+	int (*remove)(struct platform_device *pdev);
+	int (*suspend)(struct platform_device *pdev, pm_message_t state);
+	int (*resume)(struct platform_device *pdev);
+};
+
+/* SoC platform interface */
+struct snd_soc_platform {
+	char *name;
+
+	int (*probe)(struct platform_device *pdev);
+	int (*remove)(struct platform_device *pdev);
+	int (*suspend)(struct platform_device *pdev,
+		struct snd_soc_cpu_dai *cpu_dai);
+	int (*resume)(struct platform_device *pdev,
+		struct snd_soc_cpu_dai *cpu_dai);
+
+	/* pcm creation and destruction */
+	int (*pcm_new)(struct snd_card *, struct snd_soc_codec_dai *,
+		struct snd_pcm *);
+	void (*pcm_free)(struct snd_pcm *);
+
+	/* platform stream ops */
+	struct snd_pcm_ops *pcm_ops;
+};
+
+/* SoC machine DAI configuration, glues a codec and cpu DAI together */
+struct snd_soc_dai_link  {
+	char *name;			/* Codec name */
+	char *stream_name;		/* Stream name */
+
+	/* DAI */
+	struct snd_soc_codec_dai *codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai;
+	u32 flags;			/* DAI config preference flags */
+
+	/* codec/machine specific init - e.g. add machine controls */
+	int (*init)(struct snd_soc_codec *codec);
+
+	/* audio sysclock configuration */
+	unsigned int (*config_sysclk)(struct snd_soc_pcm_runtime *rtd,
+		struct snd_soc_clock_info *info);
+};
+
+/* SoC machine */
+struct snd_soc_machine {
+	char *name;
+
+	int (*probe)(struct platform_device *pdev);
+	int (*remove)(struct platform_device *pdev);
+
+	/* the pre and post PM functions are used to do any PM work before and
+	 * after the codec and DAI's do any PM work. */
+	int (*suspend_pre)(struct platform_device *pdev, pm_message_t state);
+	int (*suspend_post)(struct platform_device *pdev, pm_message_t state);
+	int (*resume_pre)(struct platform_device *pdev);
+	int (*resume_post)(struct platform_device *pdev);
+
+	/* machine stream operations */
+	struct snd_soc_ops *ops;
+
+	/* CPU <--> Codec DAI links  */
+	struct snd_soc_dai_link *dai_link;
+	int num_links;
+};
+
+/* SoC Device - the audio subsystem */
+struct snd_soc_device {
+	struct device *dev;
+	struct snd_soc_machine *machine;
+	struct snd_soc_platform *platform;
+	struct snd_soc_codec *codec;
+	struct snd_soc_codec_device *codec_dev;
+	void *codec_data;
+};
+
+/* runtime channel data */
+struct snd_soc_pcm_runtime {
+	struct snd_soc_codec_dai *codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai;
+	struct snd_soc_device *socdev;
+};
+
+/* enumerated kcontrol */
+struct soc_enum {
+	unsigned short reg;
+	unsigned short reg2;
+	unsigned char shift_l;
+	unsigned char shift_r;
+	unsigned int mask;
+	const char **texts;
+	void *dapm;
+};
+
+/* clocking configuration data */
+struct snd_soc_clock_info {
+	unsigned int rate;
+	unsigned int fs;
+	unsigned int bclk_master;
+};
+
+#endif
Index: alsa-kernel/include/ac97_codec.h
===================================================================
--- alsa-kernel.orig/include/ac97_codec.h
+++ alsa-kernel/include/ac97_codec.h
@@ -425,6 +425,7 @@ struct snd_ac97_build_ops {
 
 struct snd_ac97_bus_ops {
 	void (*reset) (struct snd_ac97 *ac97);
+	void (*warm_reset)(struct snd_ac97 *ac97);
 	void (*write) (struct snd_ac97 *ac97, unsigned short reg, unsigned short val);
 	unsigned short (*read) (struct snd_ac97 *ac97, unsigned short reg);
 	void (*wait) (struct snd_ac97 *ac97);

--=-3VhwjyzjGiAbAdxq6VjO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-3VhwjyzjGiAbAdxq6VjO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-3VhwjyzjGiAbAdxq6VjO--
