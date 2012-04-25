From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Wed, 25 Apr 2012 22:07:49 +0200
Message-ID: <1335384469.14096.203.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 13E6B104A59
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 22:07:54 +0200 (CEST)
Received: by wibhq7 with SMTP id hq7so4483128wib.2
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 13:07:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam, Hans J. and List,

 I have a "wm9712" codec-chip on an ARM mx35 board and everything works
except Microphone.

Strange is that I can't change the Mic-Select-Source:

# amixer sset "Mic Select Source" 'Mic 2'
Simple mixer control 'Mic Select Source',0
  Capabilities: enum
  Items: 'Mic 1' 'Differential' 'Mic 2' 'Stereo'
  Item0: 'Mic 1'

When I tested arecord for line-in, the "Capture Slide" in alsamixer was
wrongly inverted.
in sound/soc/codecs/wm9712.c:
       SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 1),
should get:
       SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 0),
If you want I can send a patch in.

I'm using the current linus git tree (3.4.0-rc4). I tried it with
linux-2.6.33.20 (with sound/soc/imx/imx-ssi.c etc. from 2.6.34) and it
works. On a fairly similar board I was told that it works on Kernel
3.0.4 with this patch applied:

Since patch "ASoC: Sync initial widget state with hardware"
(commitid: b66a70d5e9929f3b0df5a7177bba75652d2f4c3e) the mic capture doesn't
work. The MICBIAS bit from the "Power Management" Register are alway 1 (disabled).
So that the captering works the active status must be set to 1, at the right time.
That this works the stream name must be set.
---
 include/sound/soc-dapm.h |    3 ++-
 sound/soc/soc-dapm.c     |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c46e7d8..308122a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -85,7 +85,8 @@
 	.shift = wshift, .invert = winvert, .kcontrol_news = wcontrols, \
 	.num_kcontrols = wncontrols}
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
-{	.id = snd_soc_dapm_micbias, .name = wname, .reg = wreg, .shift = wshift, \
+{	.id = snd_soc_dapm_micbias, .name = wname, .sname = \
+	"Mic Bias HiFi Capture", .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrol_news = NULL, .num_kcontrols = 0}
 #define SND_SOC_DAPM_SWITCH(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 32ab7fc..250a1d2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -646,7 +646,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 			return snd_soc_dapm_suspend_check(widget);
 
 		/* connected VMID/Bias for lower pops */
-		if (widget->id == snd_soc_dapm_vmid)
+		if (widget->id == snd_soc_dapm_vmid || widget->id == snd_soc_dapm_micbias)
 			return snd_soc_dapm_suspend_check(widget);
 
 		/* connected jack ? */
@@ -1835,6 +1835,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 			break;
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_aif_out:
+		case snd_soc_dapm_micbias:
 			w->power_check = dapm_adc_check_power;
 			break;
 		case snd_soc_dapm_dac:
@@ -1848,7 +1849,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 			break;
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
-		case snd_soc_dapm_micbias:
 		case snd_soc_dapm_spk:
 		case snd_soc_dapm_hp:
 		case snd_soc_dapm_mic:
--


 Thanks,
   -- Christoph


It follows the output of "amixer scontents", "amixer controls" and
"amixer contents":

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 20 [65%] [on]
  Front Right: Playback 20 [65%] [on]
Simple mixer control 'Headphone Playback ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 6 [19%] [off]
  Front Right: Playback 6 [19%] [off]
Simple mixer control 'Speaker Mixer Aux',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker Mixer Line Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker Mixer PCBeep Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker Mixer PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker Mixer Phone Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker Mux',0
  Capabilities: enum
  Items: 'Speaker Mix' 'Headphone Mix'
  Item0: 'Speaker Mix'
Simple mixer control 'Speaker Playback Invert',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker Playback ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Tone Cut-off',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'Bass Control',0
  Capabilities: enum
  Items: 'Linear Control' 'Adaptive Boost'
  Item0: 'Linear Control'
Simple mixer control 'Bass Cut-off',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 9 [60%]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%]
  Front Right: Playback 17 [55%]
Simple mixer control 'Line',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%]
  Front Right: Capture 23 [74%]
Simple mixer control 'Mic 1',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 23 [74%] [0.00dB]
Simple mixer control 'Mic 2',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 18 [58%] [-7.50dB]
Simple mixer control 'Mic Boost',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 1
  Mono: 0 [0%] [0.00dB]
Simple mixer control 'Mic Headphone ',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 3 [43%]
Simple mixer control 'Mic Select Source',0
  Capabilities: enum
  Items: 'Mic 1' 'Differential' 'Mic 2' 'Stereo'
  Item0: 'Mic 1'
Simple mixer control 'Phone',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 14 [93%]
Simple mixer control 'Phone Mixer Aux',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Phone Mixer Line Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Phone Mixer Mic 1 Sidetone',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Phone Mixer Mic 2 Sidetone',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Phone Mixer PCBeep Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Phone Mixer PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Aux Playback Headphone',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'Aux Playback Phone',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'Aux Playback Speaker',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Mono Playback ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Playback Attenuate (-6dB)',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 13 [21%]
  Front Right: Capture 13 [21%]
Simple mixer control 'Capture 20dB Boost',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture ADC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture Phone Mux',0
  Capabilities: enum
  Items: 'Stereo' 'Left' 'Right' 'Mute'
  Item0: 'Mute'
Simple mixer control 'Capture Volume Steps',0
  Capabilities: enum
  Items: '+1.5dB Steps' '+0.75dB Steps'
  Item0: '+0.75dB Steps'
  Item1: '+0.75dB Steps'
Simple mixer control 'Capture ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture to Phone 20dB Boost',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control '3D',0
  Capabilities: pvolume pvolume-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 0 [0%]
Simple mixer control '3D Lower Cut-off',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control '3D Upper Cut-off',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ALC Attack Time',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC Decay Time',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC Function',0
  Capabilities: enum
  Items: 'None' 'Left' 'Right' 'Stereo'
  Item0: 'None'
Simple mixer control 'ALC Headphone',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'ALC Hold Time',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC Max',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'ALC NG',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ALC NG Threshold',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 0 [0%]
Simple mixer control 'ALC NG Type',0
  Capabilities: enum
  Items: 'Constant Gain' 'Mute'
  Item0: 'Mute'
Simple mixer control 'ALC Sidetone Mux',0
  Capabilities: enum
  Items: 'Stereo' 'Left' 'Right' 'None'
  Item0: 'Stereo'
Simple mixer control 'ALC Target',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control 'ALC ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ALC ZC Timeout',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]
Simple mixer control 'Differential Source',0
  Capabilities: enum
  Items: 'Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Left Capture Select',0
  Capabilities: enum
  Items: 'Mic' 'NC' 'NC' 'Speaker Mixer' 'Line' 'Headphone Mixer' 'Phone
Mixer' 'Phone'
  Item0: 'NC'
Simple mixer control 'Left HP Mixer Aux',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Left HP Mixer Line Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Left HP Mixer Mic Sidetone',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Left HP Mixer PCBeep Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Left HP Mixer PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Left HP Mixer Phone Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Out3',0
  Capabilities: volume volume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 31
  Mono: 0 [0%] Playback [off]
Simple mixer control 'Out3 Mux',0
  Capabilities: enum
  Items: 'Left' 'VREF' 'Left + Right' 'Mono'
  Item0: 'Mono'
Simple mixer control 'Out3 ZC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCBeep Bypass Headphone',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'PCBeep Bypass Phone',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'PCBeep Bypass Speaker',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%]
Simple mixer control 'Right Capture Select',0
  Capabilities: enum
  Items: 'Mic' 'NC' 'NC' 'Speaker Mixer' 'Line' 'Headphone Mixer' 'Phone
Mixer' 'Phone'
  Item0: 'NC'
Simple mixer control 'Right HP Mixer Aux',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right HP Mixer Line Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right HP Mixer Mic Sidetone',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right HP Mixer PCBeep Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Right HP Mixer PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Right HP Mixer Phone Bypass',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
numid=8,iface=MIXER,name='Headphone Playback ZC Switch'
numid=4,iface=MIXER,name='Headphone Playback Switch'
numid=3,iface=MIXER,name='Headphone Playback Volume'
numid=5,iface=MIXER,name='PCM Playback Volume'
numid=35,iface=MIXER,name='Line Capture Volume'
numid=51,iface=MIXER,name='Mic 1 Volume'
numid=52,iface=MIXER,name='Mic 2 Volume'
numid=53,iface=MIXER,name='Mic Boost Volume'
numid=23,iface=MIXER,name='Mic Headphone  Volume'
numid=78,iface=MIXER,name='Mic Select Source'
numid=60,iface=MIXER,name='Phone Mixer Aux Playback Switch'
numid=61,iface=MIXER,name='Phone Mixer Line Bypass Switch'
numid=63,iface=MIXER,name='Phone Mixer Mic 1 Sidetone Switch'
numid=64,iface=MIXER,name='Phone Mixer Mic 2 Sidetone Switch'
numid=59,iface=MIXER,name='Phone Mixer PCBeep Bypass Switch'
numid=62,iface=MIXER,name='Phone Mixer PCM Playback Switch'
numid=34,iface=MIXER,name='Phone Volume'
numid=31,iface=MIXER,name='Aux Playback Headphone Volume'
numid=33,iface=MIXER,name='Aux Playback Phone Volume'
numid=32,iface=MIXER,name='Aux Playback Speaker Volume'
numid=9,iface=MIXER,name='Mono Playback ZC Switch'
numid=11,iface=MIXER,name='Mono Playback Switch'
numid=10,iface=MIXER,name='Mono Playback Volume'
numid=36,iface=MIXER,name='Capture 20dB Boost Switch'
numid=47,iface=MIXER,name='Capture ADC Switch'
numid=81,iface=MIXER,name='Capture Phone Mux'
numid=50,iface=MIXER,name='Capture ZC Switch'
numid=37,iface=MIXER,name='Capture to Phone 20dB Boost Switch'
numid=49,iface=MIXER,name='Capture Volume'
numid=48,iface=MIXER,name='Capture Volume Steps'
numid=44,iface=MIXER,name='Playback Attenuate (-6dB) Switch'
numid=39,iface=MIXER,name='3D Lower Cut-off Switch'
numid=40,iface=MIXER,name='3D Playback Volume'
numid=38,iface=MIXER,name='3D Upper Cut-off Switch'
numid=15,iface=MIXER,name='ALC Attack Time'
numid=14,iface=MIXER,name='ALC Decay Time'
numid=16,iface=MIXER,name='ALC Function'
numid=24,iface=MIXER,name='ALC Headphone Volume'
numid=13,iface=MIXER,name='ALC Hold Time'
numid=17,iface=MIXER,name='ALC Max Volume'
numid=20,iface=MIXER,name='ALC NG Switch'
numid=22,iface=MIXER,name='ALC NG Threshold'
numid=21,iface=MIXER,name='ALC NG Type'
numid=84,iface=MIXER,name='ALC Sidetone Mux'
numid=12,iface=MIXER,name='ALC Target Volume'
numid=19,iface=MIXER,name='ALC ZC Switch'
numid=18,iface=MIXER,name='ALC ZC Timeout'
numid=41,iface=MIXER,name='Bass Control'
numid=42,iface=MIXER,name='Bass Cut-off Switch'
numid=45,iface=MIXER,name='Bass Volume'
numid=77,iface=MIXER,name='Differential Source'
numid=80,iface=MIXER,name='Left Capture Select'
numid=72,iface=MIXER,name='Left HP Mixer Aux Playback Switch'
numid=74,iface=MIXER,name='Left HP Mixer Line Bypass Switch'
numid=76,iface=MIXER,name='Left HP Mixer Mic Sidetone Switch'
numid=71,iface=MIXER,name='Left HP Mixer PCBeep Bypass Switch'
numid=75,iface=MIXER,name='Left HP Mixer PCM Playback Switch'
numid=73,iface=MIXER,name='Left HP Mixer Phone Bypass Switch'
numid=83,iface=MIXER,name='Out3 Mux'
numid=25,iface=MIXER,name='Out3 Switch'
numid=27,iface=MIXER,name='Out3 Volume'
numid=26,iface=MIXER,name='Out3 ZC Switch'
numid=28,iface=MIXER,name='PCBeep Bypass Headphone Volume'
numid=30,iface=MIXER,name='PCBeep Bypass Phone Volume'
numid=29,iface=MIXER,name='PCBeep Bypass Speaker Volume'
numid=79,iface=MIXER,name='Right Capture Select'
numid=66,iface=MIXER,name='Right HP Mixer Aux Playback Switch'
numid=68,iface=MIXER,name='Right HP Mixer Line Bypass Switch'
numid=70,iface=MIXER,name='Right HP Mixer Mic Sidetone Switch'
numid=65,iface=MIXER,name='Right HP Mixer PCBeep Bypass Switch'
numid=69,iface=MIXER,name='Right HP Mixer PCM Playback Switch'
numid=67,iface=MIXER,name='Right HP Mixer Phone Bypass Switch'
numid=55,iface=MIXER,name='Speaker Mixer Aux Playback Switch'
numid=57,iface=MIXER,name='Speaker Mixer Line Bypass Switch'
numid=54,iface=MIXER,name='Speaker Mixer PCBeep Bypass Switch'
numid=58,iface=MIXER,name='Speaker Mixer PCM Playback Switch'
numid=56,iface=MIXER,name='Speaker Mixer Phone Bypass Switch'
numid=82,iface=MIXER,name='Speaker Mux'
numid=7,iface=MIXER,name='Speaker Playback Invert Switch'
numid=2,iface=MIXER,name='Speaker Playback Switch'
numid=1,iface=MIXER,name='Speaker Playback Volume'
numid=6,iface=MIXER,name='Speaker Playback ZC Switch'
numid=43,iface=MIXER,name='Tone Cut-off Switch'
numid=46,iface=MIXER,name='Treble Volume'
numid=8,iface=MIXER,name='Headphone Playback ZC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=4,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=3,iface=MIXER,name='Headphone Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=31,step=0
  : values=20,20
numid=5,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=31,step=0
  : values=17,17
numid=35,iface=MIXER,name='Line Capture Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=31,step=0
  : values=23,23
numid=51,iface=MIXER,name='Mic 1 Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=31,step=0
  : values=23
  | dBscale-min=-34.50dB,step=1.50dB,mute=0
numid=52,iface=MIXER,name='Mic 2 Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=31,step=0
  : values=18
  | dBscale-min=-34.50dB,step=1.50dB,mute=0
numid=53,iface=MIXER,name='Mic Boost Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=1,step=0
  : values=0
  | dBscale-min=0.00dB,step=20.00dB,mute=0
numid=23,iface=MIXER,name='Mic Headphone  Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=3
numid=78,iface=MIXER,name='Mic Select Source'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Mic 1'
  ; Item #1 'Differential'
  ; Item #2 'Mic 2'
  ; Item #3 'Stereo'
  : values=0
numid=60,iface=MIXER,name='Phone Mixer Aux Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=61,iface=MIXER,name='Phone Mixer Line Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=63,iface=MIXER,name='Phone Mixer Mic 1 Sidetone Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=64,iface=MIXER,name='Phone Mixer Mic 2 Sidetone Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=59,iface=MIXER,name='Phone Mixer PCBeep Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=62,iface=MIXER,name='Phone Mixer PCM Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=34,iface=MIXER,name='Phone Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=14
numid=31,iface=MIXER,name='Aux Playback Headphone Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=33,iface=MIXER,name='Aux Playback Phone Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=32,iface=MIXER,name='Aux Playback Speaker Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=9,iface=MIXER,name='Mono Playback ZC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=11,iface=MIXER,name='Mono Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=10,iface=MIXER,name='Mono Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=31,step=0
  : values=0
numid=36,iface=MIXER,name='Capture 20dB Boost Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=47,iface=MIXER,name='Capture ADC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=81,iface=MIXER,name='Capture Phone Mux'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Stereo'
  ; Item #1 'Left'
  ; Item #2 'Right'
  ; Item #3 'Mute'
  : values=3
numid=50,iface=MIXER,name='Capture ZC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=37,iface=MIXER,name='Capture to Phone 20dB Boost Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=49,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=63,step=0
  : values=13,13
numid=48,iface=MIXER,name='Capture Volume Steps'
  ; type=ENUMERATED,access=rw------,values=2,items=2
  ; Item #0 '+1.5dB Steps'
  ; Item #1 '+0.75dB Steps'
  : values=1,1
numid=44,iface=MIXER,name='Playback Attenuate (-6dB) Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=39,iface=MIXER,name='3D Lower Cut-off Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=40,iface=MIXER,name='3D Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=38,iface=MIXER,name='3D Upper Cut-off Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=15,iface=MIXER,name='ALC Attack Time'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=14,iface=MIXER,name='ALC Decay Time'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=16,iface=MIXER,name='ALC Function'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'None'
  ; Item #1 'Left'
  ; Item #2 'Right'
  ; Item #3 'Stereo'
  : values=0
numid=24,iface=MIXER,name='ALC Headphone Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=13,iface=MIXER,name='ALC Hold Time'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=17,iface=MIXER,name='ALC Max Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=20,iface=MIXER,name='ALC NG Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=22,iface=MIXER,name='ALC NG Threshold'
  ; type=INTEGER,access=rw------,values=1,min=0,max=31,step=0
  : values=0
numid=21,iface=MIXER,name='ALC NG Type'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Constant Gain'
  ; Item #1 'Mute'
  : values=1
numid=84,iface=MIXER,name='ALC Sidetone Mux'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Stereo'
  ; Item #1 'Left'
  ; Item #2 'Right'
  ; Item #3 'None'
  : values=0
numid=12,iface=MIXER,name='ALC Target Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=19,iface=MIXER,name='ALC ZC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=18,iface=MIXER,name='ALC ZC Timeout'
  ; type=INTEGER,access=rw------,values=1,min=0,max=3,step=0
  : values=0
numid=41,iface=MIXER,name='Bass Control'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Linear Control'
  ; Item #1 'Adaptive Boost'
  : values=0
numid=42,iface=MIXER,name='Bass Cut-off Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=45,iface=MIXER,name='Bass Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=77,iface=MIXER,name='Differential Source'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Mic'
  ; Item #1 'Line'
  : values=0
numid=80,iface=MIXER,name='Left Capture Select'
  ; type=ENUMERATED,access=rw------,values=1,items=8
  ; Item #0 'Mic'
  ; Item #1 'NC'
  ; Item #2 'NC'
  ; Item #3 'Speaker Mixer'
  ; Item #4 'Line'
  ; Item #5 'Headphone Mixer'
  ; Item #6 'Phone Mixer'
  ; Item #7 'Phone'
  : values=1
numid=72,iface=MIXER,name='Left HP Mixer Aux Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=74,iface=MIXER,name='Left HP Mixer Line Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=76,iface=MIXER,name='Left HP Mixer Mic Sidetone Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=71,iface=MIXER,name='Left HP Mixer PCBeep Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=75,iface=MIXER,name='Left HP Mixer PCM Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=73,iface=MIXER,name='Left HP Mixer Phone Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=83,iface=MIXER,name='Out3 Mux'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Left'
  ; Item #1 'VREF'
  ; Item #2 'Left + Right'
  ; Item #3 'Mono'
  : values=3
numid=25,iface=MIXER,name='Out3 Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=27,iface=MIXER,name='Out3 Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=31,step=0
  : values=0
numid=26,iface=MIXER,name='Out3 ZC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=28,iface=MIXER,name='PCBeep Bypass Headphone Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=30,iface=MIXER,name='PCBeep Bypass Phone Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=29,iface=MIXER,name='PCBeep Bypass Speaker Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=79,iface=MIXER,name='Right Capture Select'
  ; type=ENUMERATED,access=rw------,values=1,items=8
  ; Item #0 'Mic'
  ; Item #1 'NC'
  ; Item #2 'NC'
  ; Item #3 'Speaker Mixer'
  ; Item #4 'Line'
  ; Item #5 'Headphone Mixer'
  ; Item #6 'Phone Mixer'
  ; Item #7 'Phone'
  : values=1
numid=66,iface=MIXER,name='Right HP Mixer Aux Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=68,iface=MIXER,name='Right HP Mixer Line Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=70,iface=MIXER,name='Right HP Mixer Mic Sidetone Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=65,iface=MIXER,name='Right HP Mixer PCBeep Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=69,iface=MIXER,name='Right HP Mixer PCM Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=67,iface=MIXER,name='Right HP Mixer Phone Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=55,iface=MIXER,name='Speaker Mixer Aux Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=57,iface=MIXER,name='Speaker Mixer Line Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=54,iface=MIXER,name='Speaker Mixer PCBeep Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=58,iface=MIXER,name='Speaker Mixer PCM Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=56,iface=MIXER,name='Speaker Mixer Phone Bypass Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=82,iface=MIXER,name='Speaker Mux'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Speaker Mix'
  ; Item #1 'Headphone Mix'
  : values=0
numid=7,iface=MIXER,name='Speaker Playback Invert Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=1,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=31,step=0
  : values=6,6
numid=6,iface=MIXER,name='Speaker Playback ZC Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=43,iface=MIXER,name='Tone Cut-off Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=46,iface=MIXER,name='Treble Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=9
