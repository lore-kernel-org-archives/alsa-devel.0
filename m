From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/10] ASoC: doc: ReSTize dapm.txt
Date: Thu, 10 Nov 2016 22:47:16 +0100
Message-ID: <20161110214722.14698-5-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DF82673D2
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:26 +0100 (CET)
In-Reply-To: <20161110214722.14698-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

A simple conversion from a plain text file.
The section numbers and the item numbers are dropped to align with the
ReST format.  Some lists are converted to description lists to be
clearer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../sound/{alsa/soc/dapm.txt => soc/dapm.rst}      | 249 ++++++++++++---------
 Documentation/sound/soc/index.rst                  |   1 +
 2 files changed, 144 insertions(+), 106 deletions(-)
 rename Documentation/sound/{alsa/soc/dapm.txt => soc/dapm.rst} (62%)

diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/soc/dapm.rst
similarity index 62%
rename from Documentation/sound/alsa/soc/dapm.txt
rename to Documentation/sound/soc/dapm.rst
index c45bd79f291e..a27f42befa4d 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/soc/dapm.rst
@@ -1,8 +1,9 @@
+===================================================
 Dynamic Audio Power Management for Portable Devices
 ===================================================
 
-1. Description
-==============
+Description
+===========
 
 Dynamic Audio Power Management (DAPM) is designed to allow portable
 Linux devices to use the minimum amount of power within the audio
@@ -21,20 +22,28 @@ level power systems.
 
 There are 4 power domains within DAPM
 
-   1. Codec bias domain - VREF, VMID (core codec and audio power)
+Codec bias domain
+      VREF, VMID (core codec and audio power)
+
       Usually controlled at codec probe/remove and suspend/resume, although
       can be set at stream time if power is not needed for sidetone, etc.
 
-   2. Platform/Machine domain - physically connected inputs and outputs
+Platform/Machine domain
+      physically connected inputs and outputs
+
       Is platform/machine and user action specific, is configured by the
       machine driver and responds to asynchronous events e.g when HP
       are inserted
 
-   3. Path domain - audio subsystem signal paths
+Path domain
+      audio subsystem signal paths
+
       Automatically set when mixer and mux settings are changed by the user.
       e.g. alsamixer, amixer.
 
-   4. Stream domain - DACs and ADCs.
+Stream domain
+      DACs and ADCs.
+
       Enabled and disabled when stream playback/capture is started and
       stopped respectively. e.g. aplay, arecord.
 
@@ -45,34 +54,57 @@ internal codec components). All audio components that effect power are called
 widgets hereafter.
 
 
-2. DAPM Widgets
-===============
+DAPM Widgets
+============
 
 Audio DAPM widgets fall into a number of types:-
 
- o Mixer      - Mixes several analog signals into a single analog signal.
- o Mux        - An analog switch that outputs only one of many inputs.
- o PGA        - A programmable gain amplifier or attenuation widget.
- o ADC        - Analog to Digital Converter
- o DAC        - Digital to Analog Converter
- o Switch     - An analog switch
- o Input      - A codec input pin
- o Output     - A codec output pin
- o Headphone  - Headphone (and optional Jack)
- o Mic        - Mic (and optional Jack)
- o Line       - Line Input/Output (and optional Jack)
- o Speaker    - Speaker
- o Supply     - Power or clock supply widget used by other widgets.
- o Regulator  - External regulator that supplies power to audio components.
- o Clock      -	External clock that supplies clock to audio components.
- o AIF IN     - Audio Interface Input (with TDM slot mask).
- o AIF OUT    - Audio Interface Output (with TDM slot mask).
- o Siggen     - Signal Generator.
- o DAI IN     - Digital Audio Interface Input.
- o DAI OUT    - Digital Audio Interface Output.
- o DAI Link   - DAI Link between two DAI structures */
- o Pre        - Special PRE widget (exec before all others)
- o Post       - Special POST widget (exec after all others)
+Mixer
+	Mixes several analog signals into a single analog signal.
+Mux
+	An analog switch that outputs only one of many inputs.
+PGA
+	A programmable gain amplifier or attenuation widget.
+ADC
+	Analog to Digital Converter
+DAC
+	Digital to Analog Converter
+Switch
+	An analog switch
+Input
+	A codec input pin
+Output
+	A codec output pin
+Headphone
+	Headphone (and optional Jack)
+Mic
+	Mic (and optional Jack)
+Line
+	Line Input/Output (and optional Jack)
+Speaker
+	Speaker
+Supply
+	Power or clock supply widget used by other widgets.
+Regulator
+	External regulator that supplies power to audio components.
+Clock
+	External clock that supplies clock to audio components.
+AIF IN
+	Audio Interface Input (with TDM slot mask).
+AIF OUT
+	Audio Interface Output (with TDM slot mask).
+Siggen
+	Signal Generator.
+DAI IN
+	Digital Audio Interface Input.
+DAI OUT
+	Digital Audio Interface Output.
+DAI Link
+	DAI Link between two DAI structures
+Pre
+	Special PRE widget (exec before all others)
+Post
+	Special POST widget (exec after all others)
 
 (Widgets are defined in include/sound/soc-dapm.h)
 
@@ -84,52 +116,57 @@ Most widgets have a name, register, shift and invert. Some widgets have extra
 parameters for stream name and kcontrols.
 
 
-2.1 Stream Domain Widgets
--------------------------
+Stream Domain Widgets
+---------------------
 
 Stream Widgets relate to the stream power domain and only consist of ADCs
 (analog to digital converters), DACs (digital to analog converters),
 AIF IN and AIF OUT.
 
 Stream widgets have the following format:-
+::
 
-SND_SOC_DAPM_DAC(name, stream name, reg, shift, invert),
-SND_SOC_DAPM_AIF_IN(name, stream, slot, reg, shift, invert)
+  SND_SOC_DAPM_DAC(name, stream name, reg, shift, invert),
+  SND_SOC_DAPM_AIF_IN(name, stream, slot, reg, shift, invert)
 
 NOTE: the stream name must match the corresponding stream name in your codec
 snd_soc_codec_dai.
 
 e.g. stream widgets for HiFi playback and capture
+::
 
-SND_SOC_DAPM_DAC("HiFi DAC", "HiFi Playback", REG, 3, 1),
-SND_SOC_DAPM_ADC("HiFi ADC", "HiFi Capture", REG, 2, 1),
+  SND_SOC_DAPM_DAC("HiFi DAC", "HiFi Playback", REG, 3, 1),
+  SND_SOC_DAPM_ADC("HiFi ADC", "HiFi Capture", REG, 2, 1),
 
 e.g. stream widgets for AIF
+::
 
-SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
-SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+  SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+  SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
 
 
-2.2 Path Domain Widgets
------------------------
+Path Domain Widgets
+-------------------
 
 Path domain widgets have a ability to control or affect the audio signal or
 audio paths within the audio subsystem. They have the following form:-
+::
 
-SND_SOC_DAPM_PGA(name, reg, shift, invert, controls, num_controls)
+  SND_SOC_DAPM_PGA(name, reg, shift, invert, controls, num_controls)
 
 Any widget kcontrols can be set using the controls and num_controls members.
 
 e.g. Mixer widget (the kcontrols are declared first)
+::
 
-/* Output Mixer */
-static const snd_kcontrol_new_t wm8731_output_mixer_controls[] = {
-SOC_DAPM_SINGLE("Line Bypass Switch", WM8731_APANA, 3, 1, 0),
-SOC_DAPM_SINGLE("Mic Sidetone Switch", WM8731_APANA, 5, 1, 0),
-SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, 4, 1, 0),
-};
+  /* Output Mixer */
+  static const snd_kcontrol_new_t wm8731_output_mixer_controls[] = {
+  SOC_DAPM_SINGLE("Line Bypass Switch", WM8731_APANA, 3, 1, 0),
+  SOC_DAPM_SINGLE("Mic Sidetone Switch", WM8731_APANA, 5, 1, 0),
+  SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, 4, 1, 0),
+  };
 
-SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1, wm8731_output_mixer_controls,
+  SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1, wm8731_output_mixer_controls,
 	ARRAY_SIZE(wm8731_output_mixer_controls)),
 
 If you don't want the mixer elements prefixed with the name of the mixer widget,
@@ -137,48 +174,49 @@ you can use SND_SOC_DAPM_MIXER_NAMED_CTL instead. the parameters are the same
 as for SND_SOC_DAPM_MIXER.
 
 
-2.3 Machine domain Widgets
---------------------------
+Machine domain Widgets
+----------------------
 
 Machine widgets are different from codec widgets in that they don't have a
 codec register bit associated with them. A machine widget is assigned to each
 machine audio component (non codec or DSP) that can be independently
 powered. e.g.
 
- o Speaker Amp
- o Microphone Bias
- o Jack connectors
+* Speaker Amp
+* Microphone Bias
+* Jack connectors
 
 A machine widget can have an optional call back.
 
 e.g. Jack connector widget for an external Mic that enables Mic Bias
-when the Mic is inserted:-
+when the Mic is inserted:-::
 
-static int spitz_mic_bias(struct snd_soc_dapm_widget* w, int event)
-{
+  static int spitz_mic_bias(struct snd_soc_dapm_widget* w, int event)
+  {
 	gpio_set_value(SPITZ_GPIO_MIC_BIAS, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
-}
+  }
 
-SND_SOC_DAPM_MIC("Mic Jack", spitz_mic_bias),
+  SND_SOC_DAPM_MIC("Mic Jack", spitz_mic_bias),
 
 
-2.4 Codec (BIAS) Domain
------------------------
+Codec (BIAS) Domain
+-------------------
 
 The codec bias power domain has no widgets and is handled by the codecs DAPM
 event handler. This handler is called when the codec powerstate is changed wrt
 to any stream event or by kernel PM events.
 
 
-2.5 Virtual Widgets
--------------------
+Virtual Widgets
+---------------
 
 Sometimes widgets exist in the codec or machine audio map that don't have any
 corresponding soft power control. In this case it is necessary to create
 a virtual widget - a widget with no control bits e.g.
+::
 
-SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
+  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
 
 This can be used to merge to signal paths together in software.
 
@@ -186,8 +224,8 @@ After all the widgets have been defined, they can then be added to the DAPM
 subsystem individually with a call to snd_soc_dapm_new_control().
 
 
-3. Codec/DSP Widget Interconnections
-====================================
+Codec/DSP Widget Interconnections
+=================================
 
 Widgets are connected to each other within the codec, platform and machine by
 audio paths (called interconnections). Each interconnection must be defined in
@@ -201,13 +239,14 @@ e.g., from the WM8731 output mixer (wm8731.c)
 
 The WM8731 output mixer has 3 inputs (sources)
 
- 1. Line Bypass Input
- 2. DAC (HiFi playback)
- 3. Mic Sidetone Input
+1. Line Bypass Input
+2. DAC (HiFi playback)
+3. Mic Sidetone Input
 
 Each input in this example has a kcontrol associated with it (defined in example
 above) and is connected to the output mixer via its kcontrol name. We can now
 connect the destination widget (wrt audio signal) with its source widgets.
+::
 
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
@@ -216,22 +255,17 @@ connect the destination widget (wrt audio signal) with its source widgets.
 
 So we have :-
 
-	Destination Widget  <=== Path Name <=== Source Widget
-
-Or:-
-
-	Sink, Path, Source
-
-Or :-
-
-	"Output Mixer" is connected to the "DAC" via the "HiFi Playback Switch".
+* Destination Widget  <=== Path Name <=== Source Widget, or
+* Sink, Path, Source, or
+* ``Output Mixer`` is connected to the ``DAC`` via the ``HiFi Playback Switch``.
 
 When there is no path name connecting widgets (e.g. a direct connection) we
 pass NULL for the path name.
 
 Interconnections are created with a call to:-
+::
 
-snd_soc_dapm_connect_input(codec, sink, path, source);
+  snd_soc_dapm_connect_input(codec, sink, path, source);
 
 Finally, snd_soc_dapm_new_widgets(codec) must be called after all widgets and
 interconnections have been registered with the core. This causes the core to
@@ -239,12 +273,13 @@ scan the codec and machine so that the internal DAPM state matches the
 physical state of the machine.
 
 
-3.1 Machine Widget Interconnections
------------------------------------
+Machine Widget Interconnections
+-------------------------------
 Machine widget interconnections are created in the same way as codec ones and
 directly connect the codec pins to machine level widgets.
 
 e.g. connects the speaker out codec pins to the internal speaker.
+::
 
 	/* ext speaker connected to codec pins LOUT2, ROUT2  */
 	{"Ext Spk", NULL , "ROUT2"},
@@ -254,52 +289,54 @@ This allows the DAPM to power on and off pins that are connected (and in use)
 and pins that are NC respectively.
 
 
-4 Endpoint Widgets
-===================
+Endpoint Widgets
+================
 An endpoint is a start or end point (widget) of an audio signal within the
 machine and includes the codec. e.g.
 
- o Headphone Jack
- o Internal Speaker
- o Internal Mic
- o Mic Jack
- o Codec Pins
+* Headphone Jack
+* Internal Speaker
+* Internal Mic
+* Mic Jack
+* Codec Pins
 
 Endpoints are added to the DAPM graph so that their usage can be determined in
 order to save power. e.g. NC codecs pins will be switched OFF, unconnected
 jacks can also be switched OFF.
 
 
-5 DAPM Widget Events
-====================
+DAPM Widget Events
+==================
 
 Some widgets can register their interest with the DAPM core in PM events.
 e.g. A Speaker with an amplifier registers a widget so the amplifier can be
 powered only when the spk is in use.
+::
 
-/* turn speaker amplifier on/off depending on use */
-static int corgi_amp_event(struct snd_soc_dapm_widget *w, int event)
-{
+  /* turn speaker amplifier on/off depending on use */
+  static int corgi_amp_event(struct snd_soc_dapm_widget *w, int event)
+  {
 	gpio_set_value(CORGI_GPIO_APM_ON, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
-}
+  }
 
-/* corgi machine dapm widgets */
-static const struct snd_soc_dapm_widget wm8731_dapm_widgets =
+  /* corgi machine dapm widgets */
+  static const struct snd_soc_dapm_widget wm8731_dapm_widgets =
 	SND_SOC_DAPM_SPK("Ext Spk", corgi_amp_event);
 
 Please see soc-dapm.h for all other widgets that support events.
 
 
-5.1 Event types
----------------
+Event types
+-----------
 
 The following event types are supported by event widgets.
-
-/* dapm event types */
-#define SND_SOC_DAPM_PRE_PMU	0x1 	/* before widget power up */
-#define SND_SOC_DAPM_POST_PMU	0x2		/* after widget power up */
-#define SND_SOC_DAPM_PRE_PMD	0x4 	/* before widget power down */
-#define SND_SOC_DAPM_POST_PMD	0x8		/* after widget power down */
-#define SND_SOC_DAPM_PRE_REG	0x10	/* before audio path setup */
-#define SND_SOC_DAPM_POST_REG	0x20	/* after audio path setup */
+::
+
+  /* dapm event types */
+  #define SND_SOC_DAPM_PRE_PMU	0x1 	/* before widget power up */
+  #define SND_SOC_DAPM_POST_PMU	0x2		/* after widget power up */
+  #define SND_SOC_DAPM_PRE_PMD	0x4 	/* before widget power down */
+  #define SND_SOC_DAPM_POST_PMD	0x8		/* after widget power down */
+  #define SND_SOC_DAPM_PRE_REG	0x10	/* before audio path setup */
+  #define SND_SOC_DAPM_POST_REG	0x20	/* after audio path setup */
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index aea7ae7e5aad..0c0c38e582b4 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -10,3 +10,4 @@ The documentation is spilt into the following sections:-
    overview
    codec
    dai
+   dapm
-- 
2.10.2
