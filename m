From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Fri, 27 Apr 2012 10:35:17 +0100
Message-ID: <20120427093516.GB18260@opensource.wolfsonmicro.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423185936.GW8318@opensource.wolfsonmicro.com>
	<4F9A649E.4000300@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5181178885257168186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E17110BE5B
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 11:35:20 +0200 (CEST)
In-Reply-To: <4F9A649E.4000300@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5181178885257168186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 11:19:26AM +0200, Ola Lilja wrote:
> On 04/23/2012 08:59 PM, Mark Brown wrote:

> > This won't work with probe deferral - if we need to defer then the
> > driver will squash down the -EPROBE_DEFER and fail totally.  Not a big
> > deal, though.

> Hmm, OK, how should I solve this?

Just passing back the first error you get should do the trick.

> > Similarly this is just a REGULATOR_SUPPLY.

> Is there already support for this in the core?

If you search the code for REGULATOR_SUPPLY... :)

> >> +static const struct soc_enum enum_mic1breg_sel = SOC_ENUM_SINGLE(0, 0, 2,
> >> +								enum_micreg);
> >> +static const struct snd_kcontrol_new dapm_mic1breg_mux[] = {
> >> +				SOC_DAPM_ENUM_VIRT("Mic 1b Regulator Select",
> >> +						enum_mic1breg_sel),
> >> +};

> > Can you explain how this hardware works in more detail?  It seems very
> > odd to be changing the regulator used to supply something at runtime.

> Yes, different customers have different regulators tied to the different mics.
> E.g. VMIC1 can be used with MIC2 etc. These settings are stored in a DB in
> userspace and therefor we have it as a control reachable from userspace, but I
> see the point that this could also be put in the mach-folder and thus fixed
> during build-time.

What are these regulators?  Are they internal PGA supplies or are they
microphone biases?

> >> +static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
> >> +				struct snd_ctl_elem_value *ucontrol)
> >> +{
> >> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> >> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
> >> +	unsigned int val;
> >> +
> >> +	val = (ucontrol->value.enumerated.item[0] != 0);
> >> +	if (drvdata->mclk_sel == val)
> >> +		return 0;
> >> +
> >> +	drvdata->mclk_sel = val;
> >> +
> >> +	return 1;
> >> +}

> > This is really weird

> This is a way of selecting what clock is to be used during a plaback/capture.
> It cannot direclty turn on/off the clock because this is not allowed for
> power-saving reasons. Also, it needs to be accessible from user-space as we have
> code in user-space which makes this decision during runtime.

Normally the clocking control is under the control of the machine driver
and if the machine driver wants to offer any options to userspace it'd
provide its own control - usually there's way more stuff going on here
than just selecting a source and much more coordination needed with the
drivers involved.

> The same goes here... customers set this value in the database to match their
> board-design. It is not a matter of being able to reconfigure this during
> runtime but it is stored in the database, being one common place for most
> settings; runtime or one-time-settings.
> Also this could be put as a hard-coded parameter in the machine-driver.

Or put in platform data as I've repeatedly suggested.  This is the
standard way of providing per-board fixed configuration to devices in
Linux, the fact that you have a proprietary mechanism for doing this
shouldn't really influence upstream too much.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmmfYAAoJEBus8iNuMP3d8QkP/jiRmiJuFF8o9wjD4pMKT4SS
Jnxj8jtDXm6xPf6mUex2Ah6//QBaeR8bYWQwOItJXCBdCYBrnqhx8pT3KYr9ZP7+
vmoIvUNyVozGlx07+Iwvmu+ayJ/joyJmPinSqhi4xQoHvqV+9BWwTI2S7i8IwRRv
PRKX09Hu1W2q9x9+MrU5bCCAe4oQhx4S2nmhNlvTCMgzkPWiSbAhv5iawZNQ5uR9
rrmyyAHVZNMkhMassCDLSVZnt5WWt+p10Evz9R59A6jpyC0QX44biQdUJV211cyl
5P/yP++jCHg3kcRLvDc8fJ5MTP3WbJq9XeV/voQ//zXstDwKCaysieJ7rYs4xKbT
JfE44VBPgQ9F9aohGvLj6DGWm11CAj1dU+15RriGzUmyUL0zkkP4sRrjHqHF3kt2
mNol9lMnfldwgeSxu4YjONM+pttUiQSar506hj21NJvlHe/j8uj0LBH3j5m20lTG
crsOcjtZ2Lc2QsKIEiHYLoZNJMxCTTFxtb8PG1grf8vzHP+GoyNpR6eTGxvzJFX+
YYd2JzxscYbeIsNuKNYg/7CLDoVgu3tf1HPAPFmpvoW7v8O3YloF8Q152zRBCR+V
hqx5nBnSIoMdowbS38zfxXWgHoGpHqyUFBpj9C/Nbcm0Yfn0axoO2vtD7YEj0wVM
3QuIkbnVgG+h7jQEjBU5
=maJP
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============5181178885257168186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5181178885257168186==--
