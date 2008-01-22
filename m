From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC documentation updates
Date: Tue, 22 Jan 2008 19:00:04 +0000
Message-ID: <1201028404-13853-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 551CB103819
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 20:00:06 +0100 (CET)
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Update the ASoC documentation.  Along with minor formatting and grammar
cleanups it moves the ASoC overview into the present tense to reflect
the fact that it has now been merged.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/sound/alsa/soc/DAI.txt         |    6 +-
 Documentation/sound/alsa/soc/clocking.txt    |   10 ++--
 Documentation/sound/alsa/soc/codec.txt       |   53 +++++++++++++-------------
 Documentation/sound/alsa/soc/dapm.txt        |   51 +++++++++++++------------
 Documentation/sound/alsa/soc/machine.txt     |   12 +++---
 Documentation/sound/alsa/soc/overview.txt    |   42 +++++++++++----------
 Documentation/sound/alsa/soc/platform.txt    |    6 +-
 Documentation/sound/alsa/soc/pops_clicks.txt |   10 ++--
 8 files changed, 97 insertions(+), 93 deletions(-)

diff --git a/Documentation/sound/alsa/soc/DAI.txt b/Documentation/sound/alsa/soc/DAI.txt
index 3feeb9e..0ebd7ea 100644
--- a/Documentation/sound/alsa/soc/DAI.txt
+++ b/Documentation/sound/alsa/soc/DAI.txt
@@ -1,5 +1,5 @@
 ASoC currently supports the three main Digital Audio Interfaces (DAI) found on
-SoC controllers and portable audio CODECS today, namely AC97, I2S and PCM.
+SoC controllers and portable audio CODECs today, namely AC97, I2S and PCM.
 
 
 AC97
@@ -25,7 +25,7 @@ left/right clock (LRC) synchronise the link. I2S is flexible in that either the
 controller or CODEC can drive (master) the BCLK and LRC clock lines. Bit clock
 usually varies depending on the sample rate and the master system clock
 (SYSCLK). LRCLK is the same as the sample rate. A few devices support separate
-ADC and DAC LRCLK's, this allows for simultaneous capture and playback at
+ADC and DAC LRCLKs, this allows for simultaneous capture and playback at
 different sample rates.
 
 I2S has several different operating modes:-
@@ -35,7 +35,7 @@ I2S has several different operating modes:-
 
  o Left Justified - MSB is transmitted on transition of LRC.
 
- o Right Justified - MSB is transmitted sample size BCLK's before LRC
+ o Right Justified - MSB is transmitted sample size BCLKs before LRC
                      transition.
 
 PCM
diff --git a/Documentation/sound/alsa/soc/clocking.txt b/Documentation/sound/alsa/soc/clocking.txt
index 1493088..b130016 100644
--- a/Documentation/sound/alsa/soc/clocking.txt
+++ b/Documentation/sound/alsa/soc/clocking.txt
@@ -13,7 +13,7 @@ or SYSCLK). This audio master clock can be derived from a number of sources
 (e.g. crystal, PLL, CPU clock) and is responsible for producing the correct
 audio playback and capture sample rates.
 
-Some master clocks (e.g. PLL's and CPU based clocks) are configurable in that
+Some master clocks (e.g. PLLs and CPU based clocks) are configurable in that
 their speed can be altered by software (depending on the system use and to save
 power). Other master clocks are fixed at a set frequency (i.e. crystals).
 
@@ -41,11 +41,11 @@ BCLK = LRC * x
 BCLK = LRC * Channels * Word Size
 
 This relationship depends on the codec or SoC CPU in particular. In general
-it's best to configure BCLK to the lowest possible speed (depending on your
-rate, number of channels and wordsize) to save on power.
+it is best to configure BCLK to the lowest possible speed (depending on your
+rate, number of channels and word size) to save on power.
 
-It's also desirable to use the codec (if possible) to drive (or master) the
-audio clocks as it's usually gives more accurate sample rates than the CPU.
+It is also desirable to use the codec (if possible) to drive (or master) the
+audio clocks as it usually gives more accurate sample rates than the CPU.
 
 
 
diff --git a/Documentation/sound/alsa/soc/codec.txt b/Documentation/sound/alsa/soc/codec.txt
index 1e766ad..1e95342 100644
--- a/Documentation/sound/alsa/soc/codec.txt
+++ b/Documentation/sound/alsa/soc/codec.txt
@@ -9,7 +9,7 @@ code should be added to the platform and machine drivers respectively.
 Each codec driver *must* provide the following features:-
 
  1) Codec DAI and PCM configuration
- 2) Codec control IO - using I2C, 3 Wire(SPI) or both API's
+ 2) Codec control IO - using I2C, 3 Wire(SPI) or both APIs
  3) Mixers and audio controls
  4) Codec audio operations
 
@@ -19,7 +19,7 @@ Optionally, codec drivers can also provide:-
  6) DAPM event handler.
  7) DAC Digital mute control.
 
-It's probably best to use this guide in conjunction with the existing codec
+Its probably best to use this guide in conjunction with the existing codec
 driver code in sound/soc/codecs/
 
 ASoC Codec driver breakdown
@@ -27,8 +27,8 @@ ASoC Codec driver breakdown
 
 1 - Codec DAI and PCM configuration
 -----------------------------------
-Each codec driver must have a struct snd_soc_codec_dai to define it's DAI and
-PCM's capabilities and operations. This struct is exported so that it can be
+Each codec driver must have a struct snd_soc_codec_dai to define its DAI and
+PCM capabilities and operations. This struct is exported so that it can be
 registered with the core by your machine driver.
 
 e.g.
@@ -67,18 +67,18 @@ EXPORT_SYMBOL_GPL(wm8731_dai);
 
 2 - Codec control IO
 --------------------
-The codec can usually be controlled via an I2C or SPI style interface (AC97
-combines control with data in the DAI). The codec drivers will have to provide
-functions to read and write the codec registers along with supplying a register
-cache:-
+The codec can usually be controlled via an I2C or SPI style interface
+(AC97 combines control with data in the DAI). The codec drivers provide
+functions to read and write the codec registers along with supplying a
+register cache:-
 
 	/* IO control data and register cache */
-    void *control_data; /* codec control (i2c/3wire) data */
-    void *reg_cache;
+	void *control_data; /* codec control (i2c/3wire) data */
+	void *reg_cache;
 
-Codec read/write should do any data formatting and call the hardware read write
-below to perform the IO. These functions are called by the core and alsa when
-performing DAPM or changing the mixer:-
+Codec read/write should do any data formatting and call the hardware
+read write below to perform the IO. These functions are called by the
+core and ALSA when performing DAPM or changing the mixer:-
 
     unsigned int (*read)(struct snd_soc_codec *, unsigned int);
     int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
@@ -131,7 +131,7 @@ Defines a stereo enumerated control
 
 4 - Codec Audio Operations
 --------------------------
-The codec driver also supports the following alsa operations:-
+The codec driver also supports the following ALSA operations:-
 
 /* SoC audio ops */
 struct snd_soc_ops {
@@ -142,15 +142,15 @@ struct snd_soc_ops {
 	int (*prepare)(struct snd_pcm_substream *);
 };
 
-Please refer to the alsa driver PCM documentation for details.
+Please refer to the ALSA driver PCM documentation for details.
 http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c436.htm
 
 
 5 - DAPM description.
 ---------------------
-The Dynamic Audio Power Management description describes the codec's power
-components, their relationships and registers to the ASoC core. Please read
-dapm.txt for details of building the description.
+The Dynamic Audio Power Management description describes the codec power
+components and their relationships and registers to the ASoC core.
+Please read dapm.txt for details of building the description.
 
 Please also see the examples in other codec drivers.
 
@@ -158,8 +158,8 @@ Please also see the examples in other codec drivers.
 6 - DAPM event handler
 ----------------------
 This function is a callback that handles codec domain PM calls and system
-domain PM calls (e.g. suspend and resume). It's used to put the codec to sleep
-when not in use.
+domain PM calls (e.g. suspend and resume). It is used to put the codec
+to sleep when not in use.
 
 Power states:-
 
@@ -175,13 +175,14 @@ Power states:-
 	SNDRV_CTL_POWER_D3cold: /* Everything Off, without power */
 
 
-7 - Codec DAC digital mute control.
-------------------------------------
-Most codecs have a digital mute before the DAC's that can be used to minimise
-any system noise.  The mute stops any digital data from entering the DAC.
+7 - Codec DAC digital mute control
+----------------------------------
+Most codecs have a digital mute before the DACs that can be used to
+minimise any system noise.  The mute stops any digital data from
+entering the DAC.
 
-A callback can be created that is called by the core for each codec DAI when the
-mute is applied or freed.
+A callback can be created that is called by the core for each codec DAI
+when the mute is applied or freed.
 
 i.e.
 
diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/alsa/soc/dapm.txt
index ab0766f..c784a18 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/alsa/soc/dapm.txt
@@ -4,20 +4,20 @@ Dynamic Audio Power Management for Portable Devices
 1. Description
 ==============
 
-Dynamic Audio Power Management (DAPM) is designed to allow portable Linux devices
-to use the minimum amount of power within the audio subsystem at all times. It
-is independent of other kernel PM and as such, can easily co-exist with the
-other PM systems.
+Dynamic Audio Power Management (DAPM) is designed to allow portable
+Linux devices to use the minimum amount of power within the audio
+subsystem at all times. It is independent of other kernel PM and as
+such, can easily co-exist with the other PM systems.
 
-DAPM is also completely transparent to all user space applications as all power
-switching is done within the ASoC core. No code changes or recompiling are
-required for user space applications. DAPM makes power switching decisions based
-upon any audio stream (capture/playback) activity and audio mixer settings
-within the device.
+DAPM is also completely transparent to all user space applications as
+all power switching is done within the ASoC core. No code changes or
+recompiling are required for user space applications. DAPM makes power
+switching decisions based upon any audio stream (capture/playback)
+activity and audio mixer settings within the device.
 
-DAPM spans the whole machine. It covers power control within the entire audio
-subsystem, this includes internal codec power blocks and machine level power
-systems.
+DAPM spans the whole machine. It covers power control within the entire
+audio subsystem, this includes internal codec power blocks and machine
+level power systems.
 
 There are 4 power domains within DAPM
 
@@ -34,7 +34,7 @@ There are 4 power domains within DAPM
       Automatically set when mixer and mux settings are changed by the user.
       e.g. alsamixer, amixer.
 
-   4. Stream domain - DAC's and ADC's.
+   4. Stream domain - DACs and ADCs.
       Enabled and disabled when stream playback/capture is started and
       stopped respectively. e.g. aplay, arecord.
 
@@ -51,7 +51,7 @@ widgets hereafter.
 Audio DAPM widgets fall into a number of types:-
 
  o Mixer      - Mixes several analog signals into a single analog signal.
- o Mux        - An analog switch that outputs only 1 of it's inputs.
+ o Mux        - An analog switch that outputs only one of many inputs.
  o PGA        - A programmable gain amplifier or attenuation widget.
  o ADC        - Analog to Digital Converter
  o DAC        - Digital to Analog Converter
@@ -78,14 +78,14 @@ parameters for stream name and kcontrols.
 2.1 Stream Domain Widgets
 -------------------------
 
-Stream Widgets relate to the stream power domain and only consist of ADC's
-(analog to digital converters) and DAC's (digital to analog converters).
+Stream Widgets relate to the stream power domain and only consist of ADCs
+(analog to digital converters) and DACs (digital to analog converters).
 
 Stream widgets have the following format:-
 
 SND_SOC_DAPM_DAC(name, stream name, reg, shift, invert),
 
-NOTE: the stream name must match the corresponding stream name in your codecs
+NOTE: the stream name must match the corresponding stream name in your codec
 snd_soc_codec_dai.
 
 e.g. stream widgets for HiFi playback and capture
@@ -97,7 +97,7 @@ SND_SOC_DAPM_ADC("HiFi ADC", "HiFi Capture", REG, 2, 1),
 2.2 Path Domain Widgets
 -----------------------
 
-Path domain widgets have a ability to control or effect the audio signal or
+Path domain widgets have a ability to control or affect the audio signal or
 audio paths within the audio subsystem. They have the following form:-
 
 SND_SOC_DAPM_PGA(name, reg, shift, invert, controls, num_controls)
@@ -149,7 +149,7 @@ SND_SOC_DAPM_MIC("Mic Jack", spitz_mic_bias),
 2.4 Codec Domain
 ----------------
 
-The Codec power domain has no widgets and is handled by the codecs DAPM event
+The codec power domain has no widgets and is handled by the codecs DAPM event
 handler. This handler is called when the codec powerstate is changed wrt to any
 stream event or by kernel PM events.
 
@@ -158,8 +158,8 @@ stream event or by kernel PM events.
 -------------------
 
 Sometimes widgets exist in the codec or machine audio map that don't have any
-corresponding register bit for power control. In this case it's necessary to
-create a virtual widget - a widget with no control bits e.g.
+corresponding soft power control. In this case it is necessary to create
+a virtual widget - a widget with no control bits e.g.
 
 SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
 
@@ -172,13 +172,14 @@ subsystem individually with a call to snd_soc_dapm_new_control().
 3. Codec Widget Interconnections
 ================================
 
-Widgets are connected to each other within the codec and machine by audio
-paths (called interconnections). Each interconnection must be defined in order
-to create a map of all audio paths between widgets.
+Widgets are connected to each other within the codec and machine by audio paths
+(called interconnections). Each interconnection must be defined in order to
+create a map of all audio paths between widgets.
+
 This is easiest with a diagram of the codec (and schematic of the machine audio
 system), as it requires joining widgets together via their audio signal paths.
 
-i.e. from the WM8731 codec's output mixer (wm8731.c)
+e.g., from the WM8731 output mixer (wm8731.c)
 
 The WM8731 output mixer has 3 inputs (sources)
 
diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index 72bd222..f370e7d 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -16,7 +16,7 @@ struct snd_soc_machine {
 	int (*remove)(struct platform_device *pdev);
 
 	/* the pre and post PM functions are used to do any PM work before and
-	 * after the codec and DAI's do any PM work. */
+	 * after the codec and DAIs do any PM work. */
 	int (*suspend_pre)(struct platform_device *pdev, pm_message_t state);
 	int (*suspend_post)(struct platform_device *pdev, pm_message_t state);
 	int (*resume_pre)(struct platform_device *pdev);
@@ -38,7 +38,7 @@ probe/remove are optional. Do any machine specific probe here.
 suspend()/resume()
 ------------------
 The machine driver has pre and post versions of suspend and resume to take care
-of any machine audio tasks that have to be done before or after the codec, DAI's
+of any machine audio tasks that have to be done before or after the codec, DAIs
 and DMA is suspended and resumed. Optional.
 
 
@@ -49,10 +49,10 @@ The machine specific audio operations can be set here. Again this is optional.
 
 Machine DAI Configuration
 -------------------------
-The machine DAI configuration glues all the codec and CPU DAI's together. It can
+The machine DAI configuration glues all the codec and CPU DAIs together. It can
 also be used to set up the DAI system clock and for any machine related DAI
 initialisation e.g. the machine audio map can be connected to the codec audio
-map, unconnnected codec pins can be set as such. Please see corgi.c, spitz.c
+map, unconnected codec pins can be set as such. Please see corgi.c, spitz.c
 for examples.
 
 struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
@@ -67,7 +67,7 @@ static struct snd_soc_dai_link corgi_dai = {
 	.ops = &corgi_ops,
 };
 
-struct snd_soc_machine then sets up the machine with it's DAI's. e.g.
+struct snd_soc_machine then sets up the machine with it's DAIs. e.g.
 
 /* corgi audio machine driver */
 static struct snd_soc_machine snd_soc_machine_corgi = {
@@ -110,4 +110,4 @@ details.
 Machine Controls
 ----------------
 
-Machine specific audio mixer controls can be added in the dai init function.
\ No newline at end of file
+Machine specific audio mixer controls can be added in the DAI init function.
diff --git a/Documentation/sound/alsa/soc/overview.txt b/Documentation/sound/alsa/soc/overview.txt
index c47ce95..1e4c6d3 100644
--- a/Documentation/sound/alsa/soc/overview.txt
+++ b/Documentation/sound/alsa/soc/overview.txt
@@ -1,25 +1,26 @@
 ALSA SoC Layer
 ==============
 
-The overall project goal of the ALSA System on Chip (ASoC) layer is to provide
-better ALSA support for embedded system-on-chip processors (e.g. pxa2xx, au1x00,
-iMX, etc) and portable audio codecs. Currently there is some support in the
-kernel for SoC audio, however it has some limitations:-
+The overall project goal of the ALSA System on Chip (ASoC) layer is to
+provide better ALSA support for embedded system-on-chip processors (e.g.
+pxa2xx, au1x00, iMX, etc) and portable audio codecs.  Prior to the ASoC
+subsystem there was some support in the kernel for SoC audio, however it
+had some limitations:-
 
-  * Currently, codec drivers are often tightly coupled to the underlying SoC
-    CPU. This is not ideal and leads to code duplication i.e. Linux now has 4
-    different wm8731 drivers for 4 different SoC platforms.
+  * Codec drivers were often tightly coupled to the underlying SoC
+    CPU. This is not ideal and leads to code duplication - for example,
+    Linux had different wm8731 drivers for 4 different SoC platforms.
 
-  * There is no standard method to signal user initiated audio events (e.g.
+  * There was no standard method to signal user initiated audio events (e.g.
     Headphone/Mic insertion, Headphone/Mic detection after an insertion
     event). These are quite common events on portable devices and often require
     machine specific code to re-route audio, enable amps, etc., after such an
     event.
 
-  * Current drivers tend to power up the entire codec when playing
-    (or recording) audio. This is fine for a PC, but tends to waste a lot of
-    power on portable devices. There is also no support for saving power via
-    changing codec oversampling rates, bias currents, etc.
+  * Drivers tended to power up the entire codec when playing (or
+    recording) audio. This is fine for a PC, but tends to waste a lot of
+    power on portable devices. There was also no support for saving
+    power via changing codec oversampling rates, bias currents, etc.
 
 
 ASoC Design
@@ -31,12 +32,13 @@ features :-
   * Codec independence. Allows reuse of codec drivers on other platforms
     and machines.
 
-  * Easy I2S/PCM audio interface setup between codec and SoC. Each SoC interface
-    and codec registers it's audio interface capabilities with the core and are
-    subsequently matched and configured when the application hw params are known.
+  * Easy I2S/PCM audio interface setup between codec and SoC. Each SoC
+    interface and codec registers it's audio interface capabilities with the
+    core and are subsequently matched and configured when the application
+    hardware parameters are known.
 
   * Dynamic Audio Power Management (DAPM). DAPM automatically sets the codec to
-    it's minimum power state at all times. This includes powering up/down
+    its minimum power state at all times. This includes powering up/down
     internal power blocks depending on the internal codec audio routing and any
     active streams.
 
@@ -45,16 +47,16 @@ features :-
     signals the codec when to change power states.
 
   * Machine specific controls: Allow machines to add controls to the sound card
-    (e.g. volume control for speaker amp).
+    (e.g. volume control for speaker amplifier).
 
 To achieve all this, ASoC basically splits an embedded audio system into 3
 components :-
 
   * Codec driver: The codec driver is platform independent and contains audio
-    controls, audio interface capabilities, codec dapm definition and codec IO
+    controls, audio interface capabilities, codec DAPM definition and codec IO
     functions.
 
-  * Platform driver: The platform driver contains the audio dma engine and audio
+  * Platform driver: The platform driver contains the audio DMA engine and audio
     interface drivers (e.g. I2S, AC97, PCM) for that platform.
 
   * Machine driver: The machine driver handles any machine specific controls and
@@ -81,4 +83,4 @@ machine.txt: Machine driver internals.
 
 pop_clicks.txt: How to minimise audio artifacts.
 
-clocking.txt: ASoC clocking for best power performance.
\ No newline at end of file
+clocking.txt: ASoC clocking for best power performance.
diff --git a/Documentation/sound/alsa/soc/platform.txt b/Documentation/sound/alsa/soc/platform.txt
index d4678b4..b681d17 100644
--- a/Documentation/sound/alsa/soc/platform.txt
+++ b/Documentation/sound/alsa/soc/platform.txt
@@ -8,7 +8,7 @@ specific code.
 Audio DMA
 =========
 
-The platform DMA driver optionally supports the following alsa operations:-
+The platform DMA driver optionally supports the following ALSA operations:-
 
 /* SoC audio ops */
 struct snd_soc_ops {
@@ -38,7 +38,7 @@ struct snd_soc_platform {
 	struct snd_pcm_ops *pcm_ops;
 };
 
-Please refer to the alsa driver documentation for details of audio DMA.
+Please refer to the ALSA driver documentation for details of audio DMA.
 http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c436.htm
 
 An example DMA driver is soc/pxa/pxa2xx-pcm.c
@@ -52,7 +52,7 @@ Each SoC DAI driver must provide the following features:-
  1) Digital audio interface (DAI) description
  2) Digital audio interface configuration
  3) PCM's description
- 4) Sysclk configuration
+ 4) SYSCLK configuration
  5) Suspend and resume (optional)
 
 Please see codec.txt for a description of items 1 - 4.
diff --git a/Documentation/sound/alsa/soc/pops_clicks.txt b/Documentation/sound/alsa/soc/pops_clicks.txt
index 3371bd9..e1e74da 100644
--- a/Documentation/sound/alsa/soc/pops_clicks.txt
+++ b/Documentation/sound/alsa/soc/pops_clicks.txt
@@ -15,11 +15,11 @@ click every time a component power state is changed.
 Minimising Playback Pops and Clicks
 ===================================
 
-Playback pops in portable audio subsystems cannot be completely eliminated atm,
-however future audio codec hardware will have better pop and click suppression.
-Pops can be reduced within playback by powering the audio components in a
-specific order. This order is different for startup and shutdown and follows
-some basic rules:-
+Playback pops in portable audio subsystems cannot be completely eliminated
+currently, however future audio codec hardware will have better pop and click
+suppression.  Pops can be reduced within playback by powering the audio
+components in a specific order. This order is different for startup and
+shutdown and follows some basic rules:-
 
  Startup Order :- DAC --> Mixers --> Output PGA --> Digital Unmute
 
-- 
1.5.3.8
