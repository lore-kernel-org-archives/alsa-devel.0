From: peter meng <mengsanshui@yahoo.com.cn>
Subject: Ask a question about WM8976
Date: Wed, 10 Dec 2008 14:42:58 +0800 (CST)
Message-ID: <275270.49497.qm@web15707.mail.cnb.yahoo.com>
Reply-To: mengsanshui@yahoo.com.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web15707.mail.cnb.yahoo.com (web15707.mail.cnb.yahoo.com
	[202.165.102.74])
	by alsa0.perex.cz (Postfix) with SMTP id 67F5B1037EF
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 07:43:02 +0100 (CET)
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

Hi,

I'm a newbie for alsa and using wm8976 first time .
I found the driver of wm8976 comments the contents of wm8976_dapm_widgets .

1. Is this mean all widget in wm8976  does not have power management function ? 
2. If wm8976 does not add widget then the process of 'set up audio path map ' will fails , is this correct ? 

-------------------------------------------------------------------
// TODO Widgets
static const struct snd_soc_dapm_widget wm8976_dapm_widgets[] = {
#if 0
//SND_SOC_DAPM_MUTE("Mono Mute", WM8976_MONOMIX, 6, 0),
//SND_SOC_DAPM_MUTE("Speaker Mute", WM8976_SPKMIX, 6, 0),

SND_SOC_DAPM_MIXER("Speaker Mixer", WM8976_POWER3, 2, 0,
	&wm8976_speaker_mixer_controls[0],
	ARRAY_SIZE(wm8976_speaker_mixer_controls)),
SND_SOC_DAPM_MIXER("Mono Mixer", WM8976_POWER3, 3, 0,
	&wm8976_mono_mixer_controls[0],
	ARRAY_SIZE(wm8976_mono_mixer_controls)),
SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8976_POWER3, 0, 0),
SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8976_POWER3, 0, 0),
SND_SOC_DAPM_PGA("Aux Input", WM8976_POWER1, 6, 0, NULL, 0),
SND_SOC_DAPM_PGA("SpkN Out", WM8976_POWER3, 5, 0, NULL, 0),
SND_SOC_DAPM_PGA("SpkP Out", WM8976_POWER3, 6, 0, NULL, 0),
SND_SOC_DAPM_PGA("Mono Out", WM8976_POWER3, 7, 0, NULL, 0),
SND_SOC_DAPM_PGA("Mic PGA", WM8976_POWER2, 2, 0, NULL, 0),

SND_SOC_DAPM_PGA("Aux Boost", SND_SOC_NOPM, 0, 0,
	&wm8976_aux_boost_controls, 1),
SND_SOC_DAPM_PGA("Mic Boost", SND_SOC_NOPM, 0, 0,
	&wm8976_mic_boost_controls, 1),
SND_SOC_DAPM_SWITCH("Capture Boost", SND_SOC_NOPM, 0, 0,
	&wm8976_capture_boost_controls),

SND_SOC_DAPM_MIXER("Boost Mixer", WM8976_POWER2, 4, 0, NULL, 0),

SND_SOC_DAPM_MICBIAS("Mic Bias", WM8976_POWER1, 4, 0),

SND_SOC_DAPM_INPUT("MICN"),
SND_SOC_DAPM_INPUT("MICP"),
SND_SOC_DAPM_INPUT("AUX"),
SND_SOC_DAPM_OUTPUT("MONOOUT"),
SND_SOC_DAPM_OUTPUT("SPKOUTP"),
SND_SOC_DAPM_OUTPUT("SPKOUTN"),
#endif
};

static int wm8976_add_widgets(struct snd_soc_codec *codec)
{
	int i;

	for(i = 0; i < ARRAY_SIZE(wm8976_dapm_widgets); i++) {
		snd_soc_dapm_new_control(codec, &wm8976_dapm_widgets[i]);
	}

	/* set up audio path map */
	for(i = 0; audio_map[i][0] != NULL; i++) {
		snd_soc_dapm_connect_input(codec, audio_map[i][0], audio_map[i][1],
            audio_map[i][2]);
	}

	snd_soc_dapm_new_widgets(codec);
	return 0;
}

-----------------------------------------------

Thanks advanced .
Best Regards
Peter Meng
