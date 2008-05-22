From: Geoffrey Wossum <geoffrey@pager.net>
Subject: AT32AP7000 (AVR32) + WM8510
Date: Thu, 22 May 2008 11:20:08 -0500
Message-ID: <200805221120.08815.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E21EB1037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 18:19:44 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id 52A3CB469F
	for <alsa-devel@alsa-project.org>; Thu, 22 May 2008 11:19:43 -0500 (CDT)
Received: from [192.168.1.71] (LRS-CiscoBackup [192.168.1.1]) by
	barracuda.pager.net with ESMTP id ueiuvEt89ufgCmcp for
	<alsa-devel@alsa-project.org>; Thu, 22 May 2008 11:19:43 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm attempting to bring the sound up on a board using an Atmel AT32AP7000 
(AVR32) microcontroller with a Wolfson WM8510 mono CODEC.

I'm using the Linux 2.6.24.3.atmel.3 kernel, the latest available for the 
AVR32.  I've patched this kernel with the ASoC subsystem and WM8510 driver 
from git://opensource.wolfsonmicro.com/linux-2.6-asoc, as it appeared when 
v2.6.24 was tagged.  I've also written the platform driver for the AT32, 
which is very close to the AT91 driver, and a machine driver for my specific 
hardware.  I'm letting the WM8510 provide the I2S clocking from its internal 
PLL.

I'm having issues getting the sound to work.  I found what I believe are 
several bugs in the wm8510.c.  I also had to lie about the WM8510 supporting 
2 channels.  Otherwise, the upper ALSA seem to include only 1 channel in the 
data stream, and the WM8510 seems to still expect 2 channels in the I2S 
stream.  A patch is found a the bottom of this email.  With this patch, the 
registers on the WM8510 seem to be getting configured properly (all the clock 
rates and such look correct), but I get no signal at the speaker outputs or 
the mono output, no matter what the mixer settings are.  They just sit VMID 
after the initial power up of the chip.  

Is anyone else using the WM8510?  Any hints or suggestions?

TIA,
---
Geoffrey


Index: linux-2.6.24.3.atmel.3/sound/soc/codecs/wm8510.c
===================================================================
--- linux-2.6.24.3.atmel.3.orig/sound/soc/codecs/wm8510.c
+++ linux-2.6.24.3.atmel.3/sound/soc/codecs/wm8510.c
@@ -186,7 +186,7 @@ SOC_SINGLE("Speaker Playback Volume", WM
 SOC_SINGLE("Speaker Boost", WM8510_OUTPUT, 2, 1, 0),
 
 SOC_SINGLE("Capture Boost(+20dB)", WM8510_ADCBOOST,  8, 1, 0),
-SOC_SINGLE("Mono Playback Switch", WM8510_MONOMIX, 6, 1, 0),
+SOC_SINGLE("Mono Playback Switch", WM8510_MONOMIX, 6, 1, 1),
 };
 
 /* add non dapm controls */
@@ -209,14 +209,14 @@ static int wm8510_add_controls(struct sn
 static const struct snd_kcontrol_new wm8510_speaker_mixer_controls[] = {
 SOC_DAPM_SINGLE("Line Bypass Switch", WM8510_SPKMIX, 1, 1, 0),
 SOC_DAPM_SINGLE("Aux Playback Switch", WM8510_SPKMIX, 5, 1, 0),
-SOC_DAPM_SINGLE("PCM Playback Switch", WM8510_SPKMIX, 0, 1, 1),
+SOC_DAPM_SINGLE("PCM Playback Switch", WM8510_SPKMIX, 0, 1, 0),
 };
 
 /* Mono Output Mixer */
 static const struct snd_kcontrol_new wm8510_mono_mixer_controls[] = {
 SOC_DAPM_SINGLE("Line Bypass Switch", WM8510_MONOMIX, 1, 1, 0),
 SOC_DAPM_SINGLE("Aux Playback Switch", WM8510_MONOMIX, 2, 1, 0),
-SOC_DAPM_SINGLE("PCM Playback Switch", WM8510_MONOMIX, 0, 1, 1),
+SOC_DAPM_SINGLE("PCM Playback Switch", WM8510_MONOMIX, 0, 1, 0),
 };
 
 /* AUX Input boost vol */
@@ -251,7 +251,7 @@ SND_SOC_DAPM_MIXER("Mono Mixer", WM8510_
 	&wm8510_mono_mixer_controls[0],
 	ARRAY_SIZE(wm8510_mono_mixer_controls)),
 SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8510_POWER3, 0, 0),
-SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8510_POWER3, 0, 0),
+SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8510_POWER2, 0, 0),
 SND_SOC_DAPM_PGA("Aux Input", WM8510_POWER1, 6, 0, NULL, 0),
 SND_SOC_DAPM_PGA("SpkN Out", WM8510_POWER3, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA("SpkP Out", WM8510_POWER3, 6, 0, NULL, 0),
@@ -393,8 +393,8 @@ static int wm8510_set_dai_pll(struct snd
 
 	wm8510_write(codec, WM8510_PLLN, (pll_div.pre_div << 4) | pll_div.n);
 	wm8510_write(codec, WM8510_PLLK1, pll_div.k >> 18);
-	wm8510_write(codec, WM8510_PLLK1, (pll_div.k >> 9) && 0x1ff);
-	wm8510_write(codec, WM8510_PLLK1, pll_div.k && 0x1ff);
+	wm8510_write(codec, WM8510_PLLK2, (pll_div.k >> 9) & 0x1ff);
+	wm8510_write(codec, WM8510_PLLK3, pll_div.k & 0x1ff);
 	reg = wm8510_read_reg_cache(codec, WM8510_POWER1);
 	wm8510_write(codec, WM8510_POWER1, reg | 0x020);
 	return 0;
@@ -412,23 +412,23 @@ static int wm8510_set_dai_clkdiv(struct 
 
 	switch (div_id) {
 	case WM8510_OPCLKDIV:
-		reg = wm8510_read_reg_cache(codec, WM8510_GPIO & 0x1cf);
+                reg = wm8510_read_reg_cache(codec, WM8510_GPIO) & 0x1cf;
 		wm8510_write(codec, WM8510_GPIO, reg | div);
 		break;
 	case WM8510_MCLKDIV:
-		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK & 0x1f);
+		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK) & 0x1f;
 		wm8510_write(codec, WM8510_CLOCK, reg | div);
 		break;
 	case WM8510_ADCCLK:
-		reg = wm8510_read_reg_cache(codec, WM8510_ADC & 0x1f7);
+		reg = wm8510_read_reg_cache(codec, WM8510_ADC) & 0x1f7;
 		wm8510_write(codec, WM8510_ADC, reg | div);
 		break;
 	case WM8510_DACCLK:
-		reg = wm8510_read_reg_cache(codec, WM8510_DAC & 0x1f7);
+		reg = wm8510_read_reg_cache(codec, WM8510_DAC) & 0x1f7;
 		wm8510_write(codec, WM8510_DAC, reg | div);
 		break;
 	case WM8510_BCLKDIV:
-		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK & 0x1e3);
+		reg = wm8510_read_reg_cache(codec, WM8510_CLOCK) & 0x1e3;
 		wm8510_write(codec, WM8510_CLOCK, reg | div);
 		break;
 	default:
@@ -597,14 +597,14 @@ struct snd_soc_codec_dai wm8510_dai = {
 	.name = "WM8510 HiFi",
 	.playback = {
 		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 1,
+		.channels_min = 2,
+		.channels_max = 2,
 		.rates = WM8510_RATES,
 		.formats = WM8510_FORMATS,},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 1,
+		.channels_min = 2,
+		.channels_max = 2,
 		.rates = WM8510_RATES,
 		.formats = WM8510_FORMATS,},
 	.ops = {
