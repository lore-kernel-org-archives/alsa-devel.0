From: gnuser <gnuser@yeah.net>
Subject: Help about LineIn capture on WM8904
Date: Tue, 25 Oct 2011 15:56:22 +0800 (CST)
Message-ID: <380ff786.1a7c.1333a148237.Coremail.gnuser@yeah.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m157-178.yeah.net (m157-178.yeah.net [123.58.178.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2397F10383C
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Oct 2011 09:56:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi Mark and all,

I'm working on an ASoC machine driver to include the support for WM8904.
The ARM SoC is AT91SAM9G45 from Atmel. In Atmel's original reference board,
Atmel uses WM8731 which works quite well. For my case, I replaced it with
WM8904. Both Atmel's ref board and mine use I2S to talk with audio codec.
So far, the audio playback is OK. But audio capture can not work
well.

The *hardware connection* in my case is,

external 32768Hz crystal --> MCLK (Use FLL to get proper sysclk)
Line In Jack --> IN2L
Line In Jack --> IN2R
MiC  -->  IN1L
HeadPhone --> HPOUTL
HeadPhone --> HPOUTR

NC Pins: LINEOUTL, LINEOUTR, LINEOUTFB, IN1R

Codec is in master mode, ARM Soc is in slave mode.

My questions are,
1) Since WM8731 works fine (both playback and capture) on Atmel's ref board,
and playback is also OK for my case, can we get the conclusion that the PCM
driver and DAI driver are OK? Does the clock configuration for my case also look
OK? 

2) In my machine driver, I added the following DAPM components,
static const struct snd_soc_dapm_widget mini_dapm_widgets[] = {
	SND_SOC_DAPM_HP("Headphone Jack", NULL),
	SND_SOC_DAPM_MIC("Mic Jack", NULL),
	SND_SOC_DAPM_LINE("LineIn Jack", NULL),
};

static const struct snd_soc_dapm_route intercon[] = {
	/* headphone jack connected to HPOUT */
	{"Headphone Jack", NULL, "HPOUTL"},
	{"Headphone Jack", NULL, "HPOUTR"},

	{"MICBIAS", NULL, "Mic Jack"},
	{"IN1L", NULL, "MICBIAS"},
	{"IN2R", NULL, "LineIn Jack"},
	{"IN2L", NULL, "LineIn Jack"},
};
- and - then,
{
	snd_soc_dapm_nc_pin(dapm, "IN1R");
	snd_soc_dapm_nc_pin(dapm, "IN3L");
	snd_soc_dapm_nc_pin(dapm, "IN3R");
	
	snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
	snd_soc_dapm_nc_pin(dapm, "LINEOUTR");

	snd_soc_dapm_new_controls(dapm, mini_dapm_widgets,
				  ARRAY_SIZE(mini_dapm_widgets));
	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));

	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
	snd_soc_dapm_enable_pin(dapm, "LineIn Jack");

	snd_soc_dapm_sync(dapm);
}

Does the above code look fine?


3) I used "arecord -d 8 -f S16_LE -c2 -r8000 8000.wav" to capture audio. But the
captured data are something looks like
84 FF 73 FF  83 FF 70 FF
85 FF 72 FF  84 FF 71 FF
83 FF 72 FF  84 FF 72 FF
87 FF 71 FF  83 FF 71 FF
(RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 8000 Hz)
The captured file can not be played well (no sound actually)

Both arecord, PCM driver, DAI driver and snd core driver are quiet without any warning
or error. I tried to use alsamixer to configure the audo path. But I'm new to ALSA
and not sure about the configuration. I just paste the amixer here, could you please
point me where I've made mistakes? A piece of amixer scripts will greatly help me. :)

Thanks in advance.

Simple mixer control 'Headphone',0
  Capabilities: volume pswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 63
  Front Left: 46 [73%] [-11.00dB] Playback [on]
  Front Right: 45 [71%] [-12.00dB] Playback [on]
Simple mixer control 'Headphone ZC',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Line Output',0
  Capabilities: volume pswitch penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 63
  Front Left: 57 [90%] [0.00dB] Playback [on]
  Front Right: 57 [90%] [0.00dB] Playback [on]
Simple mixer control 'Line Output ZC',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 5 [16%] [on]
  Front Right: Capture 5 [16%] [on]
Simple mixer control 'ADC 128x OSR',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'AIFOUTL Mux',0
  Capabilities: enum
  Items: 'Left' 'Right'
  Item0: 'Left'
Simple mixer control 'AIFOUTR Mux',0
  Capabilities: enum
  Items: 'Left' 'Right'
  Item0: 'Right'
Simple mixer control 'DAC Deemphasis',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'DAC OSRx2',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'DACL Mux',0
  Capabilities: enum
  Items: 'Left' 'Right'
  Item0: 'Left'
Simple mixer control 'DACR Mux',0
  Capabilities: enum
  Items: 'Left' 'Right'
  Item0: 'Right'
Simple mixer control 'DRC',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'DRC Path',0
  Capabilities: enum
  Items: 'ADC' 'DAC'
  Item0: 'ADC'
Simple mixer control 'Digital',0
  Capabilities: pvolume cvolume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 119
  Front Left: Playback 96 [100%] [0.00dB] Capture 96 [81%] [0.00dB]
  Front Right: Playback 96 [100%] [0.00dB] Capture 96 [81%] [0.00dB]
Simple mixer control 'Digital Playback Boost',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] [0.00dB]
Simple mixer control 'Digital Sidetone',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 15
  Front Left: 0 [0%] [-36.00dB]
  Front Right: 0 [0%] [-36.00dB]
Simple mixer control 'EQ',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'EQ1',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 24
  Mono: 12 [50%] [0.00dB]
Simple mixer control 'EQ2',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 24
  Mono: 12 [50%] [0.00dB]
Simple mixer control 'EQ3',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 24
  Mono: 12 [50%] [0.00dB]
Simple mixer control 'EQ4',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 24
  Mono: 12 [50%] [0.00dB]
Simple mixer control 'EQ5',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 24
  Mono: 12 [50%] [0.00dB]
Simple mixer control 'HPL Mux',0
  Capabilities: enum
  Items: 'DAC' 'Bypass'
  Item0: 'DAC'
Simple mixer control 'HPR Mux',0
  Capabilities: enum
  Items: 'DAC' 'Bypass'
  Item0: 'DAC'
Simple mixer control 'High Pass Filter',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'High Pass Filter Mode',0
  Capabilities: enum
  Items: 'Hi-fi' 'Voice 1' 'Voice 2' 'Voice 3'
  Item0: 'Hi-fi'
Simple mixer control 'LINEL Mux',0
  Capabilities: enum
  Items: 'DAC' 'Bypass'
  Item0: 'DAC'
Simple mixer control 'LINER Mux',0
  Capabilities: enum
  Items: 'DAC' 'Bypass'
  Item0: 'DAC'
Simple mixer control 'Left Capture Inverting Mux',0
  Capabilities: enum
  Items: 'IN1L' 'IN2L' 'IN3L'
  Item0: 'IN1L'
Simple mixer control 'Left Capture Mux',0
  Capabilities: enum
  Items: 'IN1L' 'IN2L' 'IN3L'
  Item0: 'IN2L'
Simple mixer control 'Left Caputure Mode',0
  Capabilities: enum
  Items: 'Single-Ended' 'Differential Line' 'Differential Mic'
  Item0: 'Single-Ended'
Simple mixer control 'Left Sidetone',0
  Capabilities: enum
  Items: 'None' 'Left' 'Right'
  Item0: 'None'
Simple mixer control 'Right Capture Inverting Mux',0
  Capabilities: enum
  Items: 'IN1R' 'IN2R' 'IN3R'
  Item0: 'IN1R'
Simple mixer control 'Right Capture Mode',0
  Capabilities: enum
  Items: 'Single-Ended' 'Differential Line' 'Differential Mic'
  Item0: 'Single-Ended'
Simple mixer control 'Right Capture Mux',0
  Capabilities: enum
  Items: 'IN1R' 'IN2R' 'IN3R'
  Item0: 'IN2R'
Simple mixer control 'Right Sidetone',0
  Capabilities: enum
  Items: 'None' 'Left' 'Right'
  Item0: 'None'
