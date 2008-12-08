From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/8] ASoC: TWL4030: Add Analog PGA control
	switch to DAPM
Date: Mon, 8 Dec 2008 14:06:08 +0200
Message-ID: <200812081406.08116.peter.ujfalusi@nokia.com>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<20081208112336.GC5159@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 039C3103832
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 13:06:17 +0100 (CET)
In-Reply-To: <20081208112336.GC5159@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Monday 08 December 2008 13:23:37 ext Mark Brown wrote:
> On Mon, Dec 08, 2008 at 10:09:02AM +0200, Peter Ujfalusi wrote:
> > +	/* Analog PGAs
> > +	 * bit 0: APGA enable
> > +	 * bit 1: Digital to analog path enable
> > +	 */
> > +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXR1_APGA",
> > +			TWL4030_REG_ARXR1_APGA_CTL, 0, 0x3, 0x3, 0x0),
> > +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXL1_APGA",
> > +			TWL4030_REG_ARXL1_APGA_CTL, 0, 0x3, 0x3, 0x0),
> > +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXR2_APGA",
> > +			TWL4030_REG_ARXR2_APGA_CTL, 0, 0x3, 0x3, 0x0),
> > +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXL2_APGA",
> > +			TWL4030_REG_ARXL2_APGA_CTL, 0, 0x3, 0x3, 0x0),
> > +
>
> The PGA should be standard SND_SOC_DAPM_PGA()s with the digital to
> analogue switches used to implement mute controls for them.

Should I 'chain' these switches, like this:

/* Digital to analog enable/disable */
SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
		1, 0, NULL, 0),
/* APGA enable/disable */
SND_SOC_DAPM_PGA("ARXR1_APGA Enable", TWL4030_REG_ARXR1_APGA_CTL,
		0, 0, NULL, 0),
...
{"ARXR1_APGA Enable", NULL, "DACR1"},
{"ARXR1_APGA", NULL, "ARXR1_APGA Enable"},

Or should I use the wcontrols, wncontrols to implement the DA enable/disabl=
e:

static const struct snd_kcontrol_new arxr1_apga_controls[] =3D {
SOC_DAPM_SINGLE("ARXR1_APGA Switch", TWL4030_REG_ARXR1_APGA_CTL, 1, 1, 0),
};
...
SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
		0, 0, &arxr1_apga_controls[0], ARRAY_SIZE(arxr1_apga_controls)),

If the later is preferred, than probably it would be better to move the =

"DAC1 Analog Playback Volume" and "DAC2 Analog Playback Volume" from the =

twl4030_snd_controls to twl4030_dapm_widgets, separate the four paths and u=
se =

SOC_DAPM_SINGLE_TLV("ARXR1_APGA Playback Volume" ?
Hmm, in this case the SOC_DAPM_SINGLE_TLV can be also part of the =

arxr1_apga_controls...

-- =

P=E9ter
