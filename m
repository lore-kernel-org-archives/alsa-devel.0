From: Neil Jones <neiljay@gmail.com>
Subject: Question about ASOC codec drivers
Date: Tue, 18 Jan 2011 17:35:22 +0000
Message-ID: <AANLkTim-3xObWzoF4aMUA6umYcD=wDhvY+mChqQhU=JY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7459F103859
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 18:38:11 +0100 (CET)
Received: by wyi11 with SMTP id 11so6441331wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 09:38:11 -0800 (PST)
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

Im trying to write an ASOC Codec driver for a new codec and im having
problems setting up the widgets and interconnects.

The input structure is similar to the wm8731 so i have based my codec
on this (my widget code is included at the bottom)

problem is I get this error on startup:

Failed to add route Line Input->Input Mux

Add then when I run alsa-mixer I get a memfault in the strcpy in
snd_soc_info_enum_double()

it appears to be indexing a string 1 past the end, ie
uinfo->value.enumerated.item = 3 but e->texts is pointing to the
tansen_input_select[] array of strings which only has 3 entries, so it
blows up (e->max = 7??).

also shouldn't the strcpy by a strncpy as we are copying to a fixed
64byte buffer ?

thanks for anyhelp.

Neil



my widget code:

static const struct snd_kcontrol_new tansen_snd_controls[] = {
SOC_DOUBLE_R("Master Playback Volume",
	     TANSEN_TM_OP_TOP7, TANSEN_TM_OP_TOP8,
	     0, 0xFF, 0
	     ),
SOC_DOUBLE("Line/IPOD-In Gain", TANSEN_TM_IP_TOP5, 5, 2, 0x7, 0),
SOC_DOUBLE("Mic-In Gain", TANSEN_TM_IP_TOP4, 0, 4, 0xF, 0),
};

static const char *tansen_input_select[] = { "Mic In",
					    "Line In",
					    "IPOD In",
					  };

static const struct soc_enum tansen_ip_enum =
SOC_ENUM_SINGLE(TANSEN_TM_IP_TOP2, 4, 0x7, tansen_input_select);

/* Input mux */
static const struct snd_kcontrol_new tansen_input_mux_controls =
SOC_DAPM_ENUM("Input Select", tansen_ip_enum);

static const struct snd_soc_dapm_widget tansen_dapm_widgets[] = {
SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
SND_SOC_DAPM_OUTPUT("LHPOUT"),
SND_SOC_DAPM_OUTPUT("RHPOUT"),
SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0, &tansen_input_mux_controls),
SND_SOC_DAPM_PGA("PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
SND_SOC_DAPM_MICBIAS("Mic Bias", TANSEN_TM_MICBIAS_1, 4, 1),
SND_SOC_DAPM_INPUT("MICIN"),
SND_SOC_DAPM_INPUT("RLINEIN"),
SND_SOC_DAPM_INPUT("LLINEIN"),
SND_SOC_DAPM_INPUT("RIPODIN"),
SND_SOC_DAPM_INPUT("LIPODIN")
};

static const struct snd_soc_dapm_route intercon[] = {

	/* outputs */
	{"RHPOUT", NULL, "DAC"},
	{"LHPOUT", NULL, "DAC"},

	/* input mux */
	{"Input Mux", "Line In", "Line Input"},
	{"Input Mux", "Mic In",  "Mic bias"},
	{"Input Mux", "Ipod In", "Ipod Input"},
	{"ADC", NULL, "PGA"},
	{"PGA", NULL, "Input Mux"},

	/* inputs */
	{"Line Input", NULL, "LLINEIN"},
	{"Line Input", NULL, "RLINEIN"},
	{"Ipod Input", NULL, "LIPODIN"},
	{"Ipod Input", NULL, "RIPODIN"},
	{"Mic bias", NULL, "MICIN"},
};
