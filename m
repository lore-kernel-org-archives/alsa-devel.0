From: "Feng Ye" <fye@broadcom.com>
Subject: Does amixer has to be used to make a complete path in
	ASoC?
Date: Sun, 22 May 2011 17:41:14 -0700
Message-ID: <9383297B60843144AC17878B479520F1169F03C829@SJEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mms1.broadcom.com (mms1.broadcom.com [216.31.210.17])
	by alsa0.perex.cz (Postfix) with ESMTP id B1239243FA
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 02:44:22 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I wrote ASoC driver with interacts with WM8750 codec chip.  It does not work, no sound at all. Some codec registers are not programmed right, and the check_power callback (in soc-dapm.c) always return 0.
I think the problem may not be in the driver, instead, amixer should be used to select the codec mixer settings to build a complete audio path (like the LEFT MIXER in wm8750).
I have following questions:

1.       Is my understanding correct? amixer has to be used before aplay?

2.       Is there way to do it in the code instead of using amixer?

3.       If amixer has to be used, where I can find sample wm8750 amixer setting usage for a simple playback from I2S in to Lout1 & Rout1 out?

Here's the simple code in my driver, just FYI:
static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
                SND_SOC_DAPM_SPK("Ext Speaker", NULL),
};
static const struct snd_soc_dapm_route wm8750_audio_map[] = {
                { "Ext Speaker", NULL, "LOUT1" },
                { "Ext Speaker", NULL, "ROUT1" },
};
... (in dai_link init function):
                err = snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets, ARRAY_SIZE(wm8750_dapm_widgets));
...
                snd_soc_dapm_add_routes(codec, wm8750_audio_map, ARRAY_SIZE(wm8750_audio_map));
                snd_soc_dapm_sync(codec);
... (in snd_soc_ops startup function):
                snd_soc_dapm_enable_pin(codec, "Ext Speaker");


Thanks,
Feng
