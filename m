From: Peter Rosin <peda@lysator.liu.se>
Subject: Volume control with mute in the wrong end
Date: Mon, 2 May 2016 15:34:51 +0200
Message-ID: <5cd62e92-8905-1fea-5794-5b211d1d903d@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 75056260421
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 15:34:53 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id C407940012
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 15:34:52 +0200 (CEST)
Received: from [192.168.0.125] (217-210-101-82-no95.business.telia.com
 [217.210.101.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 886D840009
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 15:34:52 +0200 (CEST)
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

Hi!

I'm writing a driver for the max9860 codec

https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf

and it has a digital sidetone control where it can mix in
the left channel ADC into the (mono) DAC output.

The register that controls the sidetone level makes me wonder
how I should wire up DAPM for it. You set the gain for the
sidetone in the same register field as you enable it. I have
a problem though, since the mute value is at the wrong and of
the scale, i.e. you turn the volume up and up and up, and when
you reach "max" it is off. I did try to declare a TLV range
like so:

/* The dvst field has its mute in the wrong end. Sigh. */
static const DECLARE_TLV_DB_RANGE(dvst_tlv,
	 0, 30, TLV_DB_SCALE_ITEM(-6000, 200, 0),
	31, 31, TLV_DB_SCALE_ITEM(0, 0, 1));

and then hook it that up with a dapm mixer:

static const struct snd_kcontrol_new max9860_mixer_controls[] = {
	SOC_DAPM_SINGLE_TLV("Sidetone Volume", MAX9860_DACGAIN,
		MAX9860_DVST_SHIFT, 31, 1, dvst_tlv),
};

static const struct snd_soc_dapm_widget max9860_dapm_widgets[] = {
SND_SOC_DAPM_INPUT("MICL"),
SND_SOC_DAPM_INPUT("MICR"),

SND_SOC_DAPM_ADC("ADCL", NULL, MAX9860_PWRMAN, MAX9860_ADCLEN_SHIFT, 0),
SND_SOC_DAPM_ADC("ADCR", NULL, MAX9860_PWRMAN, MAX9860_ADCREN_SHIFT, 0),

SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture", 0, SND_SOC_NOPM, 0, 0),
SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture", 1, SND_SOC_NOPM, 0, 0),

SND_SOC_DAPM_MIXER("Mixer", SND_SOC_NOPM, 0, 0,
	max9860_mixer_controls,
	ARRAY_SIZE(max9860_mixer_controls)),

SND_SOC_DAPM_AIF_IN("AIFINL", "Playback", 0, SND_SOC_NOPM, 0, 0),
SND_SOC_DAPM_AIF_IN("AIFINR", "Playback", 1, SND_SOC_NOPM, 0, 0),

SND_SOC_DAPM_DAC("DAC", NULL, MAX9860_PWRMAN, MAX9860_DACEN_SHIFT, 0),

SND_SOC_DAPM_OUTPUT("OUT"),
};

static const struct snd_soc_dapm_route max9860_dapm_routes[] = {
	{ "ADCL", NULL, "MICL" },
	{ "ADCR", NULL, "MICR" },
	{ "AIFOUTL", NULL, "ADCL" },
	{ "AIFOUTR", NULL, "ADCR" },

	{ "OUT", NULL, "DAC" },

	{ "DAC", NULL, "Mixer" },
	{ "Mixer", "Sidetone Volume", "ADCL" },
	{ "Mixer", NULL, "AIFINL" },
	{ "Mixer", NULL, "AIFINR" },
};


But DAPM and some tools (e.g. alsamixer) do not properly recognize the
mute value at the wrong end on the scale for the sidetone. So, the
sidetone path is never off (in the dapm sense).

I can use amixer to set the special mute value, and it states
-99999.99dB, so I think the tlv declaration is correct, at least in
theory. But as I said alsamixer is thoroughly confused by the control
and behaves rather strange...

If I change the tlv declaration so that DAPM thinks the mute is in
the natural end of the scale, the paths are off in the dapm sense
when the sidetone is muted (but the sidetone is not in fact muted,
of course).

Is there anything I can do to make DAPM handle this insane register
field better?

Cheers,
Peter
