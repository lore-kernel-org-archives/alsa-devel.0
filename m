From: Stephen Warren <swarren@nvidia.com>
Subject: Tegra driver silent running on linux-next
Date: Tue, 21 Dec 2010 21:57:58 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD78CE0@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E4661037F5
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 06:58:21 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

I've made the Tegra audio driver compile against ALSA's -next, and it seems
like it's working; the files in /sys/kernel/debug/asoc contain everything
I'd expect, aplay -[lL] list what I'd expect, aplay runs without errors
and completes after the expected about of time, same for speaker-test.

However, the headphones are completely silent.

Note that all I've done is take the patchset I posted here, and make it
compile against ALSA -next. I haven't yet fixed any of the feedback you
gave.

I wondered if that was due to missing DAPM/routing information in harmony.c,
so I added what I think is the minimum to get things working:

static const struct snd_soc_dapm_widget harmony_dapm_widgets[] = {
	SND_SOC_DAPM_HP("Headphone Jack", NULL),
};

static const struct snd_soc_dapm_route audio_map[] = {
	{ "Headphone Jack", NULL, "HPOUTL" },
	{ "Headphone Jack", NULL, "HPOUTR" },
};

static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
{
	struct snd_soc_codec *codec = rtd->codec;
	struct snd_soc_dapm_context *dapm = &codec->dapm;

	snd_soc_dapm_new_controls(dapm, harmony_dapm_widgets,
					ARRAY_SIZE(harmony_dapm_widgets));

	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));

     // Not sure if these should be there; existing drivers seem to
     // do things in different ways...
	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
	snd_soc_dapm_sync(dapm);

	return 0;
}

static struct snd_soc_dai_link harmony_wm8903_dai = {
	.init = harmony_asoc_init,
...

However, still silence. I dumped the wm8903 debug files and again they
seem reasonable; see below.

Do you have any ideas what might be wrong; is there a requirement to
call extra APIs from the machine driver now to set things up, or
did the call order of some ops change? I don't see anything like that
when diffing other drivers.

Thanks for any pointers.

localhost dapm # cat HPOUTL
HPOUTL: On  in 1 out 1 - R0(0x0) bit 0
 in  static Left Headphone Output PGA
 out static Headphone Jack
localhost dapm # cat Left\ Headphone\ Output\ PGA 
Left Headphone Output PGA: On  in 1 out 1 - R14(0xe) bit 1
 in  static Charge Pump
 in  static Left Output Mixer
 out static HPOUTL
localhost dapm # cat Charge\ Pump 
Charge Pump: On  in 0 out 0 - R98(0x62) bit 0
 out static Right Line Output PGA
 out static Left Line Output PGA
 out static Right Headphone Output PGA
 out static Left Headphone Output PGA
localhost dapm # cat Left\ Output\ Mixer 
Left Output Mixer: On  in 1 out 2 - R13(0xd) bit 1
 in  DACL Switch DACL
 out static Left Headphone Output PGA
 out static Left Line Output PGA
localhost dapm # cat DACL
DACL: On  in 1 out 2 - R18(0x12) bit 3
 stream Left Playback inactive
 in  static CLK_DSP
 in  static DACL Sidetone
 out DACL Switch Left Output Mixer
localhost dapm # cat CLK_DSP 
CLK_DSP: On  in 0 out 0 - R22(0x16) bit 1
 out static DACR
 out static DACL
 out static ADCR
 out static ADCL
localhost dapm # cat DACL\ Sidetone 
DACL Sidetone: On  in 1 out 2
 in  Left ADCL
 out static DACL

-- 
nvpublic
