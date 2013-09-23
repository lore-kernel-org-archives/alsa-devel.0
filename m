From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 3/5] ASoC: Docs: update DAPM
Date: Mon, 23 Sep 2013 12:14:00 +0100
Message-ID: <1379934842-4489-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379934842-4489-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E49F26088F
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 13:14:22 +0200 (CEST)
In-Reply-To: <1379934842-4489-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the DAPM documentation and bring it up to date with the current
code base. This includes API changes and new widgets.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Documentation/sound/alsa/soc/dapm.txt | 71 ++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/alsa/soc/dapm.txt
index 05bf5a0..7dfd88c 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/alsa/soc/dapm.txt
@@ -21,7 +21,7 @@ level power systems.
 
 There are 4 power domains within DAPM
 
-   1. Codec domain - VREF, VMID (core codec and audio power)
+   1. Codec bias domain - VREF, VMID (core codec and audio power)
       Usually controlled at codec probe/remove and suspend/resume, although
       can be set at stream time if power is not needed for sidetone, etc.
 
@@ -63,14 +63,22 @@ Audio DAPM widgets fall into a number of types:-
  o Line       - Line Input/Output (and optional Jack)
  o Speaker    - Speaker
  o Supply     - Power or clock supply widget used by other widgets.
+ o Regulator  - External regulator that supplies power to audio components.
+ o Clock      -	External clock that supplies clock to audio componnents.
+ o AIF IN     - Audio Interface Input (with TDM slot mask).
+ o AIF OUT    - Audio Interface Output (with TDM slot mask).
+ o Siggen     - Signal Generator.
+ o DAI IN     - Digital Audio Interface Input.
+ o DAI OUT    - Digital Audio Interface Output.
+ o DAI Link   - DAI Link between two DAI structures */
  o Pre        - Special PRE widget (exec before all others)
  o Post       - Special POST widget (exec after all others)
 
 (Widgets are defined in include/sound/soc-dapm.h)
 
-Widgets are usually added in the codec driver and the machine driver. There are
-convenience macros defined in soc-dapm.h that can be used to quickly build a
-list of widgets of the codecs and machines DAPM widgets.
+Widgets can be added to the sound card by any of the component driver types.
+There are convenience macros defined in soc-dapm.h that can be used to quickly
+build a list of widgets of the codecs and machines DAPM widgets.
 
 Most widgets have a name, register, shift and invert. Some widgets have extra
 parameters for stream name and kcontrols.
@@ -80,11 +88,13 @@ parameters for stream name and kcontrols.
 -------------------------
 
 Stream Widgets relate to the stream power domain and only consist of ADCs
-(analog to digital converters) and DACs (digital to analog converters).
+(analog to digital converters), DACs (digital to analog converters),
+AIF IN and AIF OUT.
 
 Stream widgets have the following format:-
 
 SND_SOC_DAPM_DAC(name, stream name, reg, shift, invert),
+SND_SOC_DAPM_AIF_IN(name, stream, slot, reg, shift, invert)
 
 NOTE: the stream name must match the corresponding stream name in your codec
 snd_soc_codec_dai.
@@ -94,6 +104,11 @@ e.g. stream widgets for HiFi playback and capture
 SND_SOC_DAPM_DAC("HiFi DAC", "HiFi Playback", REG, 3, 1),
 SND_SOC_DAPM_ADC("HiFi ADC", "HiFi Capture", REG, 2, 1),
 
+e.g. stream widgets for AIF
+
+SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+
 
 2.2 Path Domain Widgets
 -----------------------
@@ -121,12 +136,14 @@ If you dont want the mixer elements prefixed with the name of the mixer widget,
 you can use SND_SOC_DAPM_MIXER_NAMED_CTL instead. the parameters are the same
 as for SND_SOC_DAPM_MIXER.
 
-2.3 Platform/Machine domain Widgets
------------------------------------
+
+2.3 Machine domain Widgets
+--------------------------
 
 Machine widgets are different from codec widgets in that they don't have a
 codec register bit associated with them. A machine widget is assigned to each
-machine audio component (non codec) that can be independently powered. e.g.
+machine audio component (non codec or DSP) that can be independently
+powered. e.g.
 
  o Speaker Amp
  o Microphone Bias
@@ -146,12 +163,12 @@ static int spitz_mic_bias(struct snd_soc_dapm_widget* w, int event)
 SND_SOC_DAPM_MIC("Mic Jack", spitz_mic_bias),
 
 
-2.4 Codec Domain
-----------------
+2.4 Codec (BIAS) Domain
+-----------------------
 
-The codec power domain has no widgets and is handled by the codecs DAPM event
-handler. This handler is called when the codec powerstate is changed wrt to any
-stream event or by kernel PM events.
+The codec bias power domain has no widgets and is handled by the codecs DAPM
+event handler. This handler is called when the codec powerstate is changed wrt
+to any stream event or by kernel PM events.
 
 
 2.5 Virtual Widgets
@@ -169,15 +186,16 @@ After all the widgets have been defined, they can then be added to the DAPM
 subsystem individually with a call to snd_soc_dapm_new_control().
 
 
-3. Codec Widget Interconnections
-================================
+3. Codec/DSP Widget Interconnections
+====================================
 
-Widgets are connected to each other within the codec and machine by audio paths
-(called interconnections). Each interconnection must be defined in order to
-create a map of all audio paths between widgets.
+Widgets are connected to each other within the codec, platform and machine by
+audio paths (called interconnections). Each interconnection must be defined in
+order to create a map of all audio paths between widgets.
 
-This is easiest with a diagram of the codec (and schematic of the machine audio
-system), as it requires joining widgets together via their audio signal paths.
+This is easiest with a diagram of the codec or DSP (and schematic of the machine
+audio system), as it requires joining widgets together via their audio signal
+paths.
 
 e.g., from the WM8731 output mixer (wm8731.c)
 
@@ -247,16 +265,9 @@ machine and includes the codec. e.g.
  o Mic Jack
  o Codec Pins
 
-When a codec pin is NC it can be marked as not used with a call to
-
-snd_soc_dapm_set_endpoint(codec, "Widget Name", 0);
-
-The last argument is 0 for inactive and 1 for active. This way the pin and its
-input widget will never be powered up and consume power.
-
-This also applies to machine widgets. e.g. if a headphone is connected to a
-jack then the jack can be marked active. If the headphone is removed, then
-the headphone jack can be marked inactive.
+Endpoints are added to the DAPM graph so that their usage can be determined in
+order to save power. e.g. NC codecs pins will be switched OFF, unconnected
+jacks can also be switched OFF.
 
 
 5 DAPM Widget Events
-- 
1.8.1.2
