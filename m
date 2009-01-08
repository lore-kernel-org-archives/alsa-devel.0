From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 1/2] Add initial support of Mitac mioa701
	device SoC.
Date: Thu,  8 Jan 2009 19:42:25 +0100
Message-ID: <1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id E05AB24158
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 19:42:34 +0100 (CET)
In-Reply-To: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

This machine driver enables sound functions on Mitac mio
a701 smartphone. Build upon ASoC v1, it handles :
 - rear speaker
 - front speaker
 - microphone
 - GSM

A global "Mio Mode" switch is provided to cope with audio
path setup. It ensures balance on audio chip line, which if
not respected can produce a lot of heat and even fry the
battery behind the wm9713 and the speaker amplificator.

It doesn't cope with :
 - headset jack (will be integrade after jack support has
   hit ASoC v2)
 - master volume control (depending on current Mio Mode,
   will be submitted in a second patch)

This driver is backported from ASoc v2.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/pxa/Kconfig          |    9 +
 sound/soc/pxa/Makefile         |    2 +
 sound/soc/pxa/mioa701_wm9713.c |  571 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 582 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/mioa701_wm9713.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f82e106..b385404 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -97,3 +97,12 @@ config SND_SOC_ZYLONITE
 	help
 	  Say Y if you want to add support for SoC audio on the
 	  Marvell Zylonite reference platform.
+
+config SND_PXA2XX_SOC_MIOA701
+        tristate "SoC Audio support for MIO A701"
+        depends on SND_PXA2XX_SOC && MACH_MIOA701
+        select SND_PXA2XX_SOC_AC97
+        select SND_SOC_WM9713
+        help
+          Say Y if you want to add support for SoC audio on the
+          MIO A701.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 08a9f27..9a6d27c 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -18,6 +18,7 @@ snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
 snd-soc-palm27x-objs := palm27x.o
 snd-soc-zylonite-objs := zylonite.o
+snd-soc-mioa701-objs := mioa701_wm9713.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -26,4 +27,5 @@ obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
 obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
 obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
+obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
new file mode 100644
index 0000000..dbf6799
--- /dev/null
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -0,0 +1,571 @@
+/*
+ * Handles the Mitac mioa701 SoC system
+ *
+ * Copyright (C) 2008 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+#include <mach/audio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/ac97_codec.h>
+
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+#include "../codecs/wm9713.h"
+
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+
+#define AC97_GPIO_PULL		0x58
+
+/* define the scenarios */
+#define MIO_AUDIO_OFF			0
+#define MIO_GSM_AUDIO_HANDSET		1
+#define MIO_GSM_AUDIO_HEADSET		2
+#define MIO_GSM_AUDIO_HANDSFREE		3
+#define MIO_GSM_AUDIO_BLUETOOTH		4
+#define MIO_STEREO_TO_SPEAKER		5
+#define MIO_STEREO_TO_HEADPHONES	6
+#define MIO_CAPTURE_HANDSET		7
+#define MIO_CAPTURE_HEADSET		8
+#define MIO_CAPTURE_BLUETOOTH		9
+
+static int mio_scenario = MIO_AUDIO_OFF;
+
+static int phone_stream_start(struct snd_soc_codec *codec);
+static int phone_stream_stop(struct snd_soc_codec *codec);
+
+struct mio_mixes_t {
+	char *mixname;
+	int  val;
+};
+
+static const struct mio_mixes_t mixes_reset_all[] = {
+	/* left HP mixer */
+	{"Left HP Mixer PC Beep Playback Switch", 0},
+	{"Left HP Mixer Voice Playback Switch",	  0},
+	{"Left HP Mixer Aux Playback Switch",	  0},
+	{"Left HP Mixer Bypass Playback Switch",  0},
+	{"Left HP Mixer PCM Playback Switch",	  0},
+	{"Left HP Mixer MonoIn Playback Switch",  0},
+	{"Left HP Mixer Capture Headphone Mux",	  0},
+
+	/* right HP mixer */
+	{"Right HP Mixer PC Beep Playback Switch", 0},
+	{"Right HP Mixer Voice Playback Switch",   0},
+	{"Right HP Mixer Aux Playback Switch",	   0},
+	{"Right HP Mixer Bypass Playback Switch",  0},
+	{"Right HP Mixer PCM Playback Switch",	   0},
+	{"Right HP Mixer MonoIn Playback Switch",  0},
+	{"Right HP Mixer Capture Headphone Mux",   0},
+
+	/* speaker mixer */
+	{"Speaker Mixer PC Beep Playback Switch", 0},
+	{"Speaker Mixer Voice Playback Switch",	  0},
+	{"Speaker Mixer Aux Playback Switch",	  0},
+	{"Speaker Mixer Bypass Playback Switch",  0},
+	{"Speaker Mixer PCM Playback Switch",	  0},
+	{"Speaker Mixer MonoIn Playback Switch",  0},
+	{"Speaker Mixer Mic 1 Sidetone Switch",	  0},
+
+	/* mono mixer */
+	{"Mono Mixer PC Beep Playback Switch", 0},
+	{"Mono Mixer Voice Playback Switch",   0},
+	{"Mono Mixer Aux Playback Switch",     0},
+	{"Mono Mixer Bypass Playback Switch",  0},
+	{"Mono Mixer PCM Playback Switch",     0},
+	{"Mono Mixer Capture Mono Mux",	       0},
+	{"Mono Mixer MonoIn Playback Switch",  0},
+	{"Mono Mixer Mic 1 Sidetone Switch",   0},
+	{"Mono Playback Switch",	       0},
+
+	/* headphone muxers */
+	{"Left Headphone Out Mux", 0},
+	{"Right Headphone Out Mux", 0},
+
+	/* speaker muxer */
+	{"Left Speaker Out Mux", 0},
+	{"Right Speaker Out Mux", 0},
+
+	/* Out3 muxer */
+	{ "Out 3 Mux", 0},
+
+	{ NULL, 0 }
+};
+
+static const struct mio_mixes_t mixes_gsm_call_headset[] = {
+	/*
+	 * GSM Out to Headset HPL Path
+	 *   => PCBeep -> Headphone Mixer, Headphone Mixer -> HPL
+	 */
+	{ "Left HP Mixer PC Beep Playback Switch", 1 },
+	{ "Left Headphone Out Mux", 2 },
+	/*
+	 * GSM Out to Headset HPR Path
+	 *   => MonoIn -> Headphone Mixer, Headphone Mixer -> HPR
+	 */
+	{ "Right HP Mixer MonoIn Playback Switch" , 1 },
+	{ "Right Headphone Out Mux", 2 },
+	/*
+	 * LineL to GSM In
+	 * LineL -> MonoMixer, MonoMixer -> Mono, Unmute Mono Mixer
+	 */
+	{ "Mono Mixer Bypass Playback Switch",	1},
+	{ "Mono Out Mux", 2 },
+	{ "Mono Playback Switch", 1},
+	{ NULL, 0 }
+};
+
+static const struct mio_mixes_t mixes_gsm_call_handset[] = {
+	/*
+	 * GSM Out to Front Speaker HPL Path
+	 *   => PCBeep -> Headphone Mixer, Headphone Mixer -> HPL
+	 */
+	{ "Left HP Mixer PC Beep Playback Switch", 1 },
+	{ "Left Headphone Out Mux", 2 },
+	/*
+	 * GSM Out to Front Speaker Out3 Path
+	 *   => MonoIn -> Speaker Mixer, Speaker Mixer -> Inv1, Inv1 -> Out3
+	 */
+	{ "Speaker Mixer MonoIn Playback Switch" , 1 },
+	{ "DAC Inv Mux 1", 2 },
+	{ "Out 3 Mux", 2 },
+	/*
+	 * MIC1 to GSM In
+	 *   => MIC1 -> MICA, MICA -> Mono Mixer, Mono Mixer -> MONO,
+	 *      UnMute Mono Mixer
+	 */
+	{ "Mic A Source", 0 },
+	{ "Mono Mixer Mic 1 Sidetone Switch", 1 },
+	{ "Mono Out Mux", 2 },
+	{ "Mono Playback Switch", 1},
+	{ NULL, 0 }
+};
+
+static const struct mio_mixes_t mixes_gsm_call_handsfree[] = {
+	/*
+	 * GSM Out to Rear Speaker SPKL Path
+	 *   => PCBeep -> Speaker Mixer, Speaker Mixer -> Inv1, Inv1 -> SPKL
+	 */
+	{ "Speaker Mixer PC Beep Playback Switch", 1 },
+	{ "DAC Inv Mux 1", 2 },
+	{ "Left Speaker Out Mux", 4 },
+	/*
+	 * GSM Out to Rear Speaker SPKR Path
+	 *   => MonoIn -> Speaker Mixer, Speaker Mixer -> SPKR
+	 */
+	{ "Speaker Mixer MonoIn Playback Switch" , 1 },
+	{ "Right Speaker Out Mux", 3 },
+	/*
+	 * MIC1 to GSM In
+	 *   => MIC1 -> MICA, MICA -> Mono Mixer, Mono Mixer -> MONO,
+	 *      Unmute Mono Mixer
+	 */
+	{ "Mic A Source", 0 },
+	{ "Mono Mixer Mic 1 Sidetone Switch", 1 },
+	{ "Mono Out Mux", 2 },
+	{ "Mono Playback Switch", 1},
+	{ NULL, 0 }
+};
+
+static const struct mio_mixes_t mixes_stereo_to_rearspeaker[] = {
+	/*
+	 * PCM to Rear Speakers
+	 *   => PCM -> Speaker Mixer, Speaker Mixer -> Inv1, Inv1 -> SPKL,
+	 *      Speaker Mixer -> SPKR
+	 */
+	{ "Speaker Mixer PCM Playback Switch", 1},
+	{ "DAC Inv Mux 1", 2 },
+	{ "Left Speaker Out Mux", 4 },
+	{ "Right Speaker Out Mux", 3 },
+	{ NULL, 0 }
+};
+
+struct snd_kcontrol *mioa701_kctrl_byname(struct snd_soc_codec *codec, char *n)
+{
+	struct snd_ctl_elem_id rid;
+
+	memset(&rid, 0, sizeof(rid));
+	rid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strncpy(rid.name, n, sizeof(rid.name));
+	return snd_ctl_find_id(codec->card, &rid);
+}
+
+void setup_muxers(struct snd_soc_codec *codec, const struct mio_mixes_t mixes[])
+{
+	int pos = 0;
+	struct snd_kcontrol *kctl;
+	struct snd_ctl_elem_value ucontrol;
+	char mname[44];
+
+	while (mixes[pos].mixname) {
+		memset(mname, 0, 44);
+		strncpy(mname, mixes[pos].mixname, 43);
+		kctl = mioa701_kctrl_byname(codec, mname);
+		memset(&ucontrol, 0, sizeof(ucontrol));
+		if (kctl) {
+			kctl->get(kctl, &ucontrol);
+			ucontrol.value.enumerated.item[0] = mixes[pos].val;
+			kctl->put(kctl, &ucontrol);
+		}
+		pos++;
+	}
+}
+
+#define NB_ENDP ARRAY_SIZE(endpn)
+static int set_scenario_endpoints(struct snd_soc_codec *codec, int scenario)
+{
+	static char *endpn[] = { "Front Speaker", "Rear Speaker",
+				 "GSM Line Out", "GSM Line In",
+				 "Headset Mic", "Front Mic", "Headset" };
+	static const int typ_endps[][NB_ENDP] = {
+		{ 0, 0, 0, 0, 0, 0, 0 }, /* MIO_AUDIO_OFF		*/
+		{ 1, 0, 1, 1, 0, 1, 0 }, /* MIO_GSM_AUDIO_HANDSET	*/
+		{ 0, 0, 1, 1, 1, 0, 1 }, /* MIO_GSM_AUDIO_HEADSET	*/
+		{ 0, 1, 1, 1, 0, 1, 0 }, /* MIO_GSM_AUDIO_HANDSFREE*/
+		{ 0, 0, 1, 1, 0, 0, 0 }, /* MIO_GSM_AUDIO_BLUETOOTH*/
+		{ 0, 1, 0, 0, 0, 0, 0 }, /* MIO_STEREO_TO_SPEAKER	*/
+		{ 0, 0, 0, 0, 0, 0, 1 }, /* MIO_STEREO_TO_HEADPHONES	*/
+		{ 0, 0, 0, 0, 0, 1, 0 }, /* MIO_CAPTURE_HANDSET		*/
+		{ 0, 0, 0, 0, 1, 0, 0 }, /* MIO_CAPTURE_HEADSET		*/
+		{ 0, 0, 0, 0, 0, 0, 0 }, /* MIO_CAPTURE_BLUETOOTH	*/
+	};
+	const int *endps = typ_endps[scenario];
+	int i;
+
+	for (i = 0; i < NB_ENDP; i++)
+		if (endps[i])
+			snd_soc_dapm_enable_pin(codec, endpn[i]);
+		else
+			snd_soc_dapm_disable_pin(codec, endpn[i]);
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static int get_scenario(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = mio_scenario;
+	return 0;
+}
+
+static int isPhoneMode(int scenario)
+{
+	int onPhone = 0;
+
+	switch (scenario) {
+	case MIO_GSM_AUDIO_HANDSET:
+	case MIO_GSM_AUDIO_HEADSET:
+	case MIO_GSM_AUDIO_BLUETOOTH:
+	case MIO_GSM_AUDIO_HANDSFREE:
+		onPhone = 1;
+	}
+
+	return onPhone;
+}
+
+static void switch_mio_mode(struct snd_soc_codec *codec, int new_scenario)
+{
+	int wasPhone = 0, willPhone = 0;
+
+	wasPhone  = isPhoneMode(mio_scenario);
+	willPhone = isPhoneMode(new_scenario);
+
+	mio_scenario = new_scenario;
+	set_scenario_endpoints(codec, mio_scenario);
+
+	if (!wasPhone && willPhone)
+		phone_stream_start(codec);
+	if (wasPhone && !willPhone)
+		phone_stream_stop(codec);
+
+	setup_muxers(codec, mixes_reset_all);
+	switch (mio_scenario) {
+	case MIO_STEREO_TO_SPEAKER:
+		setup_muxers(codec, mixes_stereo_to_rearspeaker);
+		break;
+	case MIO_GSM_AUDIO_HANDSET:
+		setup_muxers(codec, mixes_gsm_call_handset);
+		break;
+	case MIO_GSM_AUDIO_HANDSFREE:
+		setup_muxers(codec, mixes_gsm_call_handsfree);
+		break;
+	case MIO_GSM_AUDIO_HEADSET:
+		setup_muxers(codec, mixes_gsm_call_headset);
+		break;
+	default:
+		break;
+	}
+}
+
+static int set_scenario(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	if (mio_scenario == ucontrol->value.integer.value[0])
+		return 0;
+
+	switch_mio_mode(codec, ucontrol->value.integer.value[0]);
+	return 1;
+}
+
+static int phone_stream_start(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_stream_event(codec, "AC97 HiFi",
+				  SND_SOC_DAPM_STREAM_START);
+	return 0;
+}
+
+static int phone_stream_stop(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_stream_event(codec, "AC97 HiFi",
+				  SND_SOC_DAPM_STREAM_STOP);
+	return 0;
+}
+
+/* Use GPIO8 for rear speaker amplificator */
+static int rear_amp_power(struct snd_soc_codec *codec, int power)
+{
+	unsigned short reg;
+
+	if (power) {
+		reg = snd_soc_read(codec, AC97_GPIO_CFG);
+		snd_soc_write(codec, AC97_GPIO_CFG, reg | 0x0100);
+		reg = snd_soc_read(codec, AC97_GPIO_PULL);
+		snd_soc_write(codec, AC97_GPIO_PULL, reg | (1<<15));
+	} else {
+		reg = snd_soc_read(codec, AC97_GPIO_CFG);
+		snd_soc_write(codec, AC97_GPIO_CFG, reg & ~0x0100);
+		reg = snd_soc_read(codec, AC97_GPIO_PULL);
+		snd_soc_write(codec, AC97_GPIO_PULL, reg & ~(1<<15));
+	}
+
+	return 0;
+}
+
+static int rear_amp_event(struct snd_soc_dapm_widget *widget,
+			  struct snd_kcontrol *kctl, int event)
+{
+	struct snd_soc_codec *codec = widget->codec;
+	int rc;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		rc = rear_amp_power(codec, 1);
+	else
+		rc = rear_amp_power(codec, 0);
+
+	return rc;
+}
+
+static const char *mio_scenarios[] = {
+	"Off",
+	"GSM Handset",
+	"GSM Headset",
+	"GSM Handsfree",
+	"GSM Bluetooth",
+	"PCM Speaker",
+	"Headphones",
+	"Capture Handset",
+	"Capture Headset",
+	"Capture Bluetooth"
+};
+static const struct soc_enum mio_scenario_enum[] = {
+	SOC_ENUM_SINGLE_EXT(10, mio_scenarios),
+};
+
+static const struct snd_kcontrol_new mioa701_ctrls[] = {
+	SOC_ENUM_EXT("Mio Mode", mio_scenario_enum[0],
+		     get_scenario, set_scenario),
+};
+
+/* mioa701 machine dapm widgets */
+static const struct snd_soc_dapm_widget mioa701_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Front Speaker", NULL),
+	SND_SOC_DAPM_SPK("Rear Speaker", rear_amp_event),
+	SND_SOC_DAPM_MIC("Headset", NULL),
+	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
+	SND_SOC_DAPM_LINE("GSM Line In", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Front Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Call Mic */
+	{"Mic Bias", NULL, "Front Mic"},
+	{"MIC1", NULL, "Mic Bias"},
+
+	/* Headset Mic */
+	{"LINEL", NULL, "Headset Mic"},
+	{"LINER", NULL, "Headset Mic"},
+
+	/* GSM Module */
+	{"MONOIN", NULL, "GSM Line Out"},
+	{"PCBEEP", NULL, "GSM Line Out"},
+	{"GSM Line In", NULL, "MONO"},
+
+	/* headphone connected to HPL, HPR */
+	{"Headset", NULL, "HPL"},
+	{"Headset", NULL, "HPR"},
+
+	/* front speaker connected to HPL, OUT3 */
+	{"Front Speaker", NULL, "HPL"},
+	{"Front Speaker", NULL, "OUT3"},
+
+	/* rear speaker connected to SPKL, SPKR */
+	{"Rear Speaker", NULL, "SPKL"},
+	{"Rear Speaker", NULL, "SPKR"},
+};
+
+static int mioa701_wm9713_init(struct snd_soc_codec *codec)
+{
+	int i, ret;
+	unsigned short reg;
+
+	/* Add test specific controls */
+	for (i = 0; i < ARRAY_SIZE(mioa701_ctrls); i++) {
+		ret = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&mioa701_ctrls[i], codec, NULL));
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Add mioa701 specific widgets */
+	snd_soc_dapm_new_controls(codec, ARRAY_AND_SIZE(mioa701_dapm_widgets));
+
+	/* Set up mioa701 specific audio path audio_mapnects */
+	snd_soc_dapm_add_routes(codec, ARRAY_AND_SIZE(audio_map));
+
+	/* initialize mioa701 codec pins */
+	set_scenario_endpoints(codec, mio_scenario);
+
+	/* Prepare GPIO8 for rear speaker amplificator */
+	reg = codec->read(codec, AC97_GPIO_CFG);
+	codec->write(codec, AC97_GPIO_CFG, reg | 0x0100);
+
+	/* Prepare MIC input */
+	reg = codec->read(codec, AC97_3D_CONTROL);
+	codec->write(codec, AC97_3D_CONTROL, reg | 0xc000);
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+#define mioa701_wm9713_suspend NULL
+#define mioa701_wm9713_resume  NULL
+
+static struct snd_soc_ops mioa701_ops;
+
+static struct snd_soc_dai_link mioa701_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+		.init = mioa701_wm9713_init,
+		.ops = &mioa701_ops,
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9713_dai[WM9713_DAI_AC97_AUX],
+		.ops = &mioa701_ops,
+	},
+};
+
+static struct snd_soc_card mioa701 = {
+	.name = "MioA701",
+	.platform = &pxa2xx_soc_platform,
+	.dai_link = mioa701_dai,
+	.num_links = ARRAY_SIZE(mioa701_dai),
+};
+
+static struct snd_soc_device mioa701_snd_devdata = {
+	.card = &mioa701,
+	.codec_dev = &soc_codec_dev_wm9713,
+};
+
+static struct platform_device *mioa701_snd_device;
+
+static int mioa701_wm9713_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	if (!machine_is_mioa701())
+		return -ENODEV;
+
+	mioa701_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!mioa701_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(mioa701_snd_device, &mioa701_snd_devdata);
+	mioa701_snd_devdata.dev = &mioa701_snd_device->dev;
+
+	ret = platform_device_add(mioa701_snd_device);
+	if (!ret)
+		return 0;
+
+	platform_device_put(mioa701_snd_device);
+	return ret;
+}
+
+static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(mioa701_snd_device);
+	return 0;
+}
+
+static struct platform_driver mioa701_wm9713_driver = {
+	.probe		= mioa701_wm9713_probe,
+	.remove		= __devexit_p(mioa701_wm9713_remove),
+	.suspend	= mioa701_wm9713_suspend,
+	.resume		= mioa701_wm9713_resume,
+	.driver		= {
+		.name		= "mioa701-wm9713",
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init mioa701_asoc_init(void)
+{
+	return platform_driver_register(&mioa701_wm9713_driver);
+}
+
+static void __exit mioa701_asoc_exit(void)
+{
+	platform_driver_unregister(&mioa701_wm9713_driver);
+}
+
+module_init(mioa701_asoc_init);
+module_exit(mioa701_asoc_exit);
+
+/* Module information */
+MODULE_AUTHOR("Robert Jarzmik (rjarzmik@free.fr)");
+MODULE_DESCRIPTION("ALSA SoC WM9713 MIO A701");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
