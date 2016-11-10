From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ASoC: doc: ReSTize DPCM.txt
Date: Thu, 10 Nov 2016 22:47:22 +0100
Message-ID: <20161110214722.14698-11-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 14F8E2673D9
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:28 +0100 (CET)
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
The file name was renamed to lower letters to align with others.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../sound/{alsa/soc/DPCM.txt => soc/dpcm.rst}      | 280 +++++++++++----------
 Documentation/sound/soc/index.rst                  |   1 +
 2 files changed, 147 insertions(+), 134 deletions(-)
 rename Documentation/sound/{alsa/soc/DPCM.txt => soc/dpcm.rst} (57%)

diff --git a/Documentation/sound/alsa/soc/DPCM.txt b/Documentation/sound/soc/dpcm.rst
similarity index 57%
rename from Documentation/sound/alsa/soc/DPCM.txt
rename to Documentation/sound/soc/dpcm.rst
index 0110180b7ac6..395e5a516282 100644
--- a/Documentation/sound/alsa/soc/DPCM.txt
+++ b/Documentation/sound/soc/dpcm.rst
@@ -1,8 +1,9 @@
+===========
 Dynamic PCM
 ===========
 
-1. Description
-==============
+Description
+===========
 
 Dynamic PCM allows an ALSA PCM device to digitally route its PCM audio to
 various digital endpoints during the PCM stream runtime. e.g. PCM0 can route
@@ -23,22 +24,23 @@ Phone Audio System with SoC based DSP
 
 Consider the following phone audio subsystem. This will be used in this
 document for all examples :-
-
-| Front End PCMs    |  SoC DSP  | Back End DAIs | Audio devices |
-
-                    *************
-PCM0 <------------> *           * <----DAI0-----> Codec Headset
-                    *           *
-PCM1 <------------> *           * <----DAI1-----> Codec Speakers
-                    *   DSP     *
-PCM2 <------------> *           * <----DAI2-----> MODEM
-                    *           *
-PCM3 <------------> *           * <----DAI3-----> BT
-                    *           *
-                    *           * <----DAI4-----> DMIC
-                    *           *
-                    *           * <----DAI5-----> FM
-                    *************
+::
+
+  | Front End PCMs    |  SoC DSP  | Back End DAIs | Audio devices |
+  
+                      *************
+  PCM0 <------------> *           * <----DAI0-----> Codec Headset
+                      *           *
+  PCM1 <------------> *           * <----DAI1-----> Codec Speakers
+                      *   DSP     *
+  PCM2 <------------> *           * <----DAI2-----> MODEM
+                      *           *
+  PCM3 <------------> *           * <----DAI3-----> BT
+                      *           *
+                      *           * <----DAI4-----> DMIC
+                      *           *
+                      *           * <----DAI5-----> FM
+                      *************
 
 This diagram shows a simple smart phone audio subsystem. It supports Bluetooth,
 FM digital radio, Speakers, Headset Jack, digital microphones and cellular
@@ -55,50 +57,52 @@ Audio is being played to the Headset. After a while the user removes the headset
 and audio continues playing on the speakers.
 
 Playback on PCM0 to Headset would look like :-
-
-                    *************
-PCM0 <============> *           * <====DAI0=====> Codec Headset
-                    *           *
-PCM1 <------------> *           * <----DAI1-----> Codec Speakers
-                    *   DSP     *
-PCM2 <------------> *           * <----DAI2-----> MODEM
-                    *           *
-PCM3 <------------> *           * <----DAI3-----> BT
-                    *           *
-                    *           * <----DAI4-----> DMIC
-                    *           *
-                    *           * <----DAI5-----> FM
-                    *************
+::
+
+                      *************
+  PCM0 <============> *           * <====DAI0=====> Codec Headset
+                      *           *
+  PCM1 <------------> *           * <----DAI1-----> Codec Speakers
+                      *   DSP     *
+  PCM2 <------------> *           * <----DAI2-----> MODEM
+                      *           *
+  PCM3 <------------> *           * <----DAI3-----> BT
+                      *           *
+                      *           * <----DAI4-----> DMIC
+                      *           *
+                      *           * <----DAI5-----> FM
+                      *************
 
 The headset is removed from the jack by user so the speakers must now be used :-
-
-                    *************
-PCM0 <============> *           * <----DAI0-----> Codec Headset
-                    *           *
-PCM1 <------------> *           * <====DAI1=====> Codec Speakers
-                    *   DSP     *
-PCM2 <------------> *           * <----DAI2-----> MODEM
-                    *           *
-PCM3 <------------> *           * <----DAI3-----> BT
-                    *           *
-                    *           * <----DAI4-----> DMIC
-                    *           *
-                    *           * <----DAI5-----> FM
-                    *************
+::
+
+                      *************
+  PCM0 <============> *           * <----DAI0-----> Codec Headset
+                      *           *
+  PCM1 <------------> *           * <====DAI1=====> Codec Speakers
+                      *   DSP     *
+  PCM2 <------------> *           * <----DAI2-----> MODEM
+                      *           *
+  PCM3 <------------> *           * <----DAI3-----> BT
+                      *           *
+                      *           * <----DAI4-----> DMIC
+                      *           *
+                      *           * <----DAI5-----> FM
+                      *************
 
 The audio driver processes this as follows :-
 
- 1) Machine driver receives Jack removal event.
+1. Machine driver receives Jack removal event.
 
- 2) Machine driver OR audio HAL disables the Headset path.
+2. Machine driver OR audio HAL disables the Headset path.
 
- 3) DPCM runs the PCM trigger(stop), hw_free(), shutdown() operations on DAI0
-    for headset since the path is now disabled.
+3. DPCM runs the PCM trigger(stop), hw_free(), shutdown() operations on DAI0
+   for headset since the path is now disabled.
 
- 4) Machine driver or audio HAL enables the speaker path.
+4. Machine driver or audio HAL enables the speaker path.
 
- 5) DPCM runs the PCM ops for startup(), hw_params(), prepapre() and
-    trigger(start) for DAI1 Speakers since the path is enabled.
+5. DPCM runs the PCM ops for startup(), hw_params(), prepapre() and
+   trigger(start) for DAI1 Speakers since the path is enabled.
 
 In this example, the machine driver or userspace audio HAL can alter the routing
 and then DPCM will take care of managing the DAI PCM operations to either bring
@@ -112,36 +116,38 @@ DPCM machine driver
 The DPCM enabled ASoC machine driver is similar to normal machine drivers
 except that we also have to :-
 
- 1) Define the FE and BE DAI links.
+1. Define the FE and BE DAI links.
 
- 2) Define any FE/BE PCM operations.
+2. Define any FE/BE PCM operations.
 
- 3) Define widget graph connections.
+3. Define widget graph connections.
 
 
-1 FE and BE DAI links
----------------------
+FE and BE DAI links
+-------------------
+::
 
-| Front End PCMs    |  SoC DSP  | Back End DAIs | Audio devices |
-
-                    *************
-PCM0 <------------> *           * <----DAI0-----> Codec Headset
-                    *           *
-PCM1 <------------> *           * <----DAI1-----> Codec Speakers
-                    *   DSP     *
-PCM2 <------------> *           * <----DAI2-----> MODEM
-                    *           *
-PCM3 <------------> *           * <----DAI3-----> BT
-                    *           *
-                    *           * <----DAI4-----> DMIC
-                    *           *
-                    *           * <----DAI5-----> FM
-                    *************
+  | Front End PCMs    |  SoC DSP  | Back End DAIs | Audio devices |
+  
+                      *************
+  PCM0 <------------> *           * <----DAI0-----> Codec Headset
+                      *           *
+  PCM1 <------------> *           * <----DAI1-----> Codec Speakers
+                      *   DSP     *
+  PCM2 <------------> *           * <----DAI2-----> MODEM
+                      *           *
+  PCM3 <------------> *           * <----DAI3-----> BT
+                      *           *
+                      *           * <----DAI4-----> DMIC
+                      *           *
+                      *           * <----DAI5-----> FM
+                      *************
 
 For the example above we have to define 4 FE DAI links and 6 BE DAI links. The
 FE DAI links are defined as follows :-
+::
 
-static struct snd_soc_dai_link machine_dais[] = {
+  static struct snd_soc_dai_link machine_dais[] = {
 	{
 		.name = "PCM0 System",
 		.stream_name = "System Playback",
@@ -154,11 +160,11 @@ static struct snd_soc_dai_link machine_dais[] = {
 		.dpcm_playback = 1,
 	},
 	.....< other FE and BE DAI links here >
-};
+  };
 
 This FE DAI link is pretty similar to a regular DAI link except that we also
-set the DAI link to a DPCM FE with the "dynamic = 1". The supported FE stream
-directions should also be set with the "dpcm_playback" and "dpcm_capture"
+set the DAI link to a DPCM FE with the ``dynamic = 1``. The supported FE stream
+directions should also be set with the ``dpcm_playback`` and ``dpcm_capture``
 flags. There is also an option to specify the ordering of the trigger call for
 each FE. This allows the ASoC core to trigger the DSP before or after the other
 components (as some DSPs have strong requirements for the ordering DAI/DSP
@@ -168,8 +174,9 @@ The FE DAI above sets the codec and code DAIs to dummy devices since the BE is
 dynamic and will change depending on runtime config.
 
 The BE DAIs are configured as follows :-
+::
 
-static struct snd_soc_dai_link machine_dais[] = {
+  static struct snd_soc_dai_link machine_dais[] = {
 	.....< FE DAI links here >
 	{
 		.name = "Codec Headset",
@@ -186,29 +193,30 @@ static struct snd_soc_dai_link machine_dais[] = {
 		.dpcm_capture = 1,
 	},
 	.....< other BE DAI links here >
-};
+  };
 
 This BE DAI link connects DAI0 to the codec (in this case RT5460 AIF1). It sets
-the "no_pcm" flag to mark it has a BE and sets flags for supported stream
-directions using "dpcm_playback" and "dpcm_capture" above.
+the ``no_pcm`` flag to mark it has a BE and sets flags for supported stream
+directions using ``dpcm_playback`` and ``dpcm_capture`` above.
 
 The BE has also flags set for ignoring suspend and PM down time. This allows
 the BE to work in a hostless mode where the host CPU is not transferring data
 like a BT phone call :-
-
-                    *************
-PCM0 <------------> *           * <----DAI0-----> Codec Headset
-                    *           *
-PCM1 <------------> *           * <----DAI1-----> Codec Speakers
-                    *   DSP     *
-PCM2 <------------> *           * <====DAI2=====> MODEM
-                    *           *
-PCM3 <------------> *           * <====DAI3=====> BT
-                    *           *
-                    *           * <----DAI4-----> DMIC
-                    *           *
-                    *           * <----DAI5-----> FM
-                    *************
+::
+
+                      *************
+  PCM0 <------------> *           * <----DAI0-----> Codec Headset
+                      *           *
+  PCM1 <------------> *           * <----DAI1-----> Codec Speakers
+                      *   DSP     *
+  PCM2 <------------> *           * <====DAI2=====> MODEM
+                      *           *
+  PCM3 <------------> *           * <====DAI3=====> BT
+                      *           *
+                      *           * <----DAI4-----> DMIC
+                      *           *
+                      *           * <----DAI5-----> FM
+                      *************
 
 This allows the host CPU to sleep whilst the DSP, MODEM DAI and the BT DAI are
 still in operation.
@@ -220,10 +228,10 @@ Likewise a BE DAI can also set a dummy cpu DAI if the CPU DAI is managed by the
 DSP firmware.
 
 
-2 FE/BE PCM operations
-----------------------
+FE/BE PCM operations
+--------------------
 
-The BE above also exports some PCM operations and a "fixup" callback. The fixup
+The BE above also exports some PCM operations and a ``fixup`` callback. The fixup
 callback is used by the machine driver to (re)configure the DAI based upon the
 FE hw params. i.e. the DSP may perform SRC or ASRC from the FE to BE.
 
@@ -231,10 +239,11 @@ e.g. DSP converts all FE hw params to run at fixed rate of 48k, 16bit, stereo fo
 DAI0. This means all FE hw_params have to be fixed in the machine driver for
 DAI0 so that the DAI is running at desired configuration regardless of the FE
 configuration.
+::
 
-static int dai0_fixup(struct snd_soc_pcm_runtime *rtd,
+  static int dai0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
-{
+  {
 	struct snd_interval *rate = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
@@ -249,21 +258,22 @@ static int dai0_fixup(struct snd_soc_pcm_runtime *rtd,
 				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
 				    SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
-}
+  }
 
 The other PCM operation are the same as for regular DAI links. Use as necessary.
 
 
-3 Widget graph connections
---------------------------
+Widget graph connections
+------------------------
 
 The BE DAI links will normally be connected to the graph at initialisation time
 by the ASoC DAPM core. However, if the BE codec or BE DAI is a dummy then this
 has to be set explicitly in the driver :-
+::
 
-/* BE for codec Headset -  DAI0 is dummy and managed by DSP FW */
-{"DAI0 CODEC IN", NULL, "AIF1 Capture"},
-{"AIF1 Playback", NULL, "DAI0 CODEC OUT"},
+  /* BE for codec Headset -  DAI0 is dummy and managed by DSP FW */
+  {"DAI0 CODEC IN", NULL, "AIF1 Capture"},
+  {"AIF1 Playback", NULL, "DAI0 CODEC OUT"},
 
 
 Writing a DPCM DSP driver
@@ -273,24 +283,25 @@ The DPCM DSP driver looks much like a standard platform class ASoC driver
 combined with elements from a codec class driver. A DSP platform driver must
 implement :-
 
- 1) Front End PCM DAIs - i.e. struct snd_soc_dai_driver.
+1. Front End PCM DAIs - i.e. struct snd_soc_dai_driver.
 
- 2) DAPM graph showing DSP audio routing from FE DAIs to BEs.
+2. DAPM graph showing DSP audio routing from FE DAIs to BEs.
 
- 3) DAPM widgets from DSP graph.
+3. DAPM widgets from DSP graph.
 
- 4) Mixers for gains, routing, etc.
+4. Mixers for gains, routing, etc.
 
- 5) DMA configuration.
+5. DMA configuration.
 
- 6) BE AIF widgets.
+6. BE AIF widgets.
 
 Items 6 is important for routing the audio outside of the DSP. AIF need to be
 defined for each BE and each stream direction. e.g for BE DAI0 above we would
 have :-
+::
 
-SND_SOC_DAPM_AIF_IN("DAI0 RX", NULL, 0, SND_SOC_NOPM, 0, 0),
-SND_SOC_DAPM_AIF_OUT("DAI0 TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+  SND_SOC_DAPM_AIF_IN("DAI0 RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+  SND_SOC_DAPM_AIF_OUT("DAI0 TX", NULL, 0, SND_SOC_NOPM, 0, 0),
 
 The BE AIF are used to connect the DSP graph to the graphs for the other
 component drivers (e.g. codec graph).
@@ -301,33 +312,33 @@ Hostless PCM streams
 
 A hostless PCM stream is a stream that is not routed through the host CPU. An
 example of this would be a phone call from handset to modem.
-
-
-                    *************
-PCM0 <------------> *           * <----DAI0-----> Codec Headset
-                    *           *
-PCM1 <------------> *           * <====DAI1=====> Codec Speakers/Mic
-                    *   DSP     *
-PCM2 <------------> *           * <====DAI2=====> MODEM
-                    *           *
-PCM3 <------------> *           * <----DAI3-----> BT
-                    *           *
-                    *           * <----DAI4-----> DMIC
-                    *           *
-                    *           * <----DAI5-----> FM
-                    *************
+::
+
+                      *************
+  PCM0 <------------> *           * <----DAI0-----> Codec Headset
+                      *           *
+  PCM1 <------------> *           * <====DAI1=====> Codec Speakers/Mic
+                      *   DSP     *
+  PCM2 <------------> *           * <====DAI2=====> MODEM
+                      *           *
+  PCM3 <------------> *           * <----DAI3-----> BT
+                      *           *
+                      *           * <----DAI4-----> DMIC
+                      *           *
+                      *           * <----DAI5-----> FM
+                      *************
 
 In this case the PCM data is routed via the DSP. The host CPU in this use case
 is only used for control and can sleep during the runtime of the stream.
 
 The host can control the hostless link either by :-
 
- 1) Configuring the link as a CODEC <-> CODEC style link. In this case the link
+ 1. Configuring the link as a CODEC <-> CODEC style link. In this case the link
     is enabled or disabled by the state of the DAPM graph. This usually means
     there is a mixer control that can be used to connect or disconnect the path
     between both DAIs.
 
- 2) Hostless FE. This FE has a virtual connection to the BE DAI links on the DAPM
+ 2. Hostless FE. This FE has a virtual connection to the BE DAI links on the DAPM
     graph. Control is then carried out by the FE as regular PCM operations.
     This method gives more control over the DAI links, but requires much more
     userspace code to control the link. Its recommended to use CODEC<->CODEC
@@ -339,16 +350,17 @@ CODEC <-> CODEC link
 
 This DAI link is enabled when DAPM detects a valid path within the DAPM graph.
 The machine driver sets some additional parameters to the DAI link i.e.
+::
 
-static const struct snd_soc_pcm_stream dai_params = {
+  static const struct snd_soc_pcm_stream dai_params = {
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
 	.rate_min = 8000,
 	.rate_max = 8000,
 	.channels_min = 2,
 	.channels_max = 2,
-};
+  };
 
-static struct snd_soc_dai_link dais[] = {
+  static struct snd_soc_dai_link dais[] = {
 	< ... more DAI links above ... >
 	{
 		.name = "MODEM",
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index 85ec51764e83..e142a0f25c5b 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -16,3 +16,4 @@ The documentation is spilt into the following sections:-
    pops-clicks
    clocking
    jack
+   dpcm
-- 
2.10.2
