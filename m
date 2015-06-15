From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Mon, 15 Jun 2015 17:55:28 +0100
Message-ID: <20150615165528.GX18309@sirena.org.uk>
References: <1432931525-24193-1-git-send-email-yesanishhere@gmail.com>
 <20150602203005.GT14071@sirena.org.uk>
 <CABCoZhD4OzHDzAZuhHSG0b5jKkDNXZhsNQmViWoqHRRFGSFE9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7784564057684729364=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AC2C26520E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:55:43 +0200 (CEST)
In-Reply-To: <CABCoZhD4OzHDzAZuhHSG0b5jKkDNXZhsNQmViWoqHRRFGSFE9Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============7784564057684729364==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hEi834+foqWOL7fK"
Content-Disposition: inline


--hEi834+foqWOL7fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 03:17:55PM -0700, anish kumar wrote:
> On Tue, Jun 2, 2015 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, May 29, 2015 at 01:32:05PM -0700, Anish Kumar wrote:

> >> +     SOC_ENUM("Input Sel", max98926_input_sel),
> >> +     SOC_ENUM("DAI Input Sel", max98926_dai_input_sel),

> > These look like DAPM controls?

> 'Input Sel' is basically as below:
> DAC Input Select
> Selects the left, right or mix of left + right as the DAC input signal.
> 00 = Left DAI input (default)
> 01 = Right DAI input
> 10 = Left + Right
> 11 = Left/2 + Right/2
> So i think it is best that it is not part
> of dapm.

> 'DAI Input Sel' is the input to the power amplifier.
> 98926 amplifier can take PCM input from I2S
> or can take analog signal. So we need to set
> this as control.

Sure, but it looks like a DAPM control.

> >> +     SOC_ENUM_EXT("PDM CH0 Enable", max98926_global_enum[0],
> >> +             max98926_get_pdm_ch_zero, max98926_put_pdm_ch_zero),
> >> +     SOC_ENUM_EXT("PDM CH1 Enable", max98926_global_enum[0],
> >> +             max98926_get_pdm_ch_one, max98926_put_pdm_ch_one),

> We can get vi feedback in two channels. Customer
> can enable either channel 0 or channel 1. Channel 0
> source can be voltage or current. So basically i created
> kcontrol for that so that we can either enable channel 0, 1
> or both.

> 'PDM CH0 Enable' 1 causes channel 0 to be enabled
> for current. So i enable all the relevant bit in put callback.

The user needs to be able to tell all this from the controls, it doesn't
seem that hard - it sounds like you want to have SIGGEN widgets for the
measurements and then route them to the capture DAI normally.

> >> +     if ((ret < 0) ||
> >> +             ((reg != MAX98926_CHIP_VERSION) &&
> >> +             (reg != MAX98926_CHIP_VERSION1))) {
> >> +             dev_err(codec->dev, "Failed to read: %x\n", reg);
> >> +             return -EINVAL;
> >> +     }
> >
> > You should do this check in the I2C level probe.  The error message is
> > also wrong if the register does read but isn't what we expected.
> >
> > Are you *sure* no new revisions of the device will be made?
> yes will remove the revision check as we have
> few revisions planned.

The driver should probably print the revision for diagnostics.

> >> +     /* It's not the default but we need to set DAI_DLY */
> >> +     regmap_write(max98926->regmap,
> >> +                     MAX98926_FORMAT, MAX98926_DAI_DLY_MASK);

> > Sounds like this might be the I2S vs left justified configuration?

> basically it is dai data delay. Setting this way causes
> the MSB to be valid on second active edge after LRCLK
> event.

This should be part of setting the DAI format then.

--hEi834+foqWOL7fK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfwOAAAoJECTWi3JdVIfQGfIH/08i3EuaGP8tI5oiLjVvgyKc
rVyB5uA9kAge2GYjkgtjgsCv2RwI586wHVbdMoxk8dkxYMA9LyaeXTEw1Xgq6K9J
icuWcQsKxlcx0ZJQPC/sGBM6kK1Wvw547hTWiA+3OwpmVK7/gxGsy79N8wyvh2PM
XvdJO0eb9HFTQKLd+Fol1aUpwJVu97LD3VtRgpCK5X1PJ2Xb6RWCZ0VlzLFq7b89
JZ5YS7lr/oU1dFTfULpdj/fjyRygFNt0fA0Myn1pthl9nnNHHNr4OOlV+ZZ1KeBf
OXxR+S3WZDSN7j9f8CAXs/gKSrsuwqac/Df29MMJjvlDPMFXBNSHz7+eVF/mncI=
=7dHf
-----END PGP SIGNATURE-----

--hEi834+foqWOL7fK--

--===============7784564057684729364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7784564057684729364==--
