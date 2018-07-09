From: Ladislav Michl <ladis@linux-mips.org>
Subject: Binding volume and mute switch
Date: Mon, 9 Jul 2018 12:10:13 +0200
Message-ID: <20180709101013.GA21707@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A1926739D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jul 2018 12:10:14 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990505AbeGIKKO39s-u (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Mon, 9 Jul 2018 12:10:14 +0200
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hello,

to provide almost self descriptive controls to alsamixer I'd like to achive
something like this: http://ladislav.michl.sweb.cz/alsamixer1.png
Master volume is muted using switch coupled with master volume control,
microphone is muted using switch coupled with microphone volume control,
etc...

For mic and line input is works as expected, but for sidetone and
master volume I had to use "proper" names for mixer controls,
see bellow:

/* Input mixer */
static const struct snd_kcontrol_new max9867_input_mixer_controls[] = {
	SOC_DAPM_DOUBLE("Mic Switch", MAX9867_INPUTCONFIG, 6, 4, 1, 0),
	SOC_DAPM_DOUBLE("Line Switch", MAX9867_INPUTCONFIG, 7, 5, 1, 0),
};

/* Output mixer */
static const struct snd_kcontrol_new max9867_output_mixer_controls[] = {
	SOC_DAPM_DOUBLE_R("Line Bypass Switch",
			  MAX9867_LEFTLINELVL, MAX9867_RIGHTLINELVL, 6, 1, 1),
};

/* Sidetone mixer */
static const struct snd_kcontrol_new max9867_sidetone_mixer_controls[] = {
	SOC_DAPM_DOUBLE("Sidetone Switch", MAX9867_SIDETONE, 6, 7, 1, 0),
};

/* Line out switch */
static const struct snd_kcontrol_new max9867_line_out_control =
	SOC_DAPM_DOUBLE_R("Switch",
			  MAX9867_LEFTVOL, MAX9867_RIGHTVOL, 6, 1, 1);

static const struct snd_soc_dapm_widget max9867_dapm_widgets[] = {
	SND_SOC_DAPM_INPUT("MICL"),
	SND_SOC_DAPM_INPUT("MICR"),
	SND_SOC_DAPM_INPUT("LINL"),
	SND_SOC_DAPM_INPUT("LINR"),
	SND_SOC_DAPM_MIXER("Left Input Mixer", MAX9867_PWRMAN, 6, 1,
			   max9867_input_mixer_controls,
			   ARRAY_SIZE(max9867_input_mixer_controls)),
	SND_SOC_DAPM_MIXER("Right Input Mixer", MAX9867_PWRMAN, 5, 1,
			   max9867_input_mixer_controls,
			   ARRAY_SIZE(max9867_input_mixer_controls)),
	SND_SOC_DAPM_ADC("ADCL", "HiFi Capture", MAX9867_PWRMAN, 1, 0),
	SND_SOC_DAPM_ADC("ADCR", "HiFi Capture", MAX9867_PWRMAN, 0, 0),

	SND_SOC_DAPM_MIXER("Digital", SND_SOC_NOPM, 0, 0,
			   max9867_sidetone_mixer_controls,
			   ARRAY_SIZE(max9867_sidetone_mixer_controls)),
	SND_SOC_DAPM_MIXER("Output Mixer", SND_SOC_NOPM, 0, 0,
			   max9867_output_mixer_controls,
			   ARRAY_SIZE(max9867_output_mixer_controls)),
	SND_SOC_DAPM_DAC("DACL", "HiFi Playback", MAX9867_PWRMAN, 3, 0),
	SND_SOC_DAPM_DAC("DACR", "HiFi Playback", MAX9867_PWRMAN, 2, 0),
	SND_SOC_DAPM_SWITCH("Master Playback", SND_SOC_NOPM, 0, 0,
			    &max9867_line_out_control),
	SND_SOC_DAPM_OUTPUT("LOUT"),
	SND_SOC_DAPM_OUTPUT("ROUT"),
};

static const struct snd_soc_dapm_route max9867_audio_map[] = {
	{"Left Input Mixer", "Mic Switch", "MICL"},
	{"Right Input Mixer", "Mic Switch", "MICR"},
	{"Left Input Mixer", "Line Switch", "LINL"},
	{"Right Input Mixer", "Line Switch", "LINR"},
	{"ADCL", NULL, "Left Input Mixer"},
	{"ADCR", NULL, "Right Input Mixer"},

	{"Digital", "Sidetone Switch", "ADCL"},
	{"Digital", "Sidetone Switch", "ADCR"},
	{"DACL", NULL, "Digital"},
	{"DACR", NULL, "Digital"},

	{"Output Mixer", "Line Bypass Switch", "LINL"},
	{"Output Mixer", "Line Bypass Switch", "LINR"},
	{"Output Mixer", NULL, "DACL"},
	{"Output Mixer", NULL, "DACR"},
	{"Master Playback", "Switch", "Output Mixer"},
	{"LOUT", NULL, "Master Playback"},
	{"ROUT", NULL, "Master Playback"},
};

With other control names than "Digital" for sidetone digital
mixer, sidetone switch is shown separately from sidetone volume.
The same for master volume switch, which is bind with master
volume only once its name is "Master Playback".

Is it intended to work this way or there is some other, more
elegant way how to bind mute switch with volume control.
(above solution seem too fragile to me)

Thank you,
	ladis
