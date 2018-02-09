From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC
	driver
Date: Fri, 9 Feb 2018 15:47:46 +0000
Message-ID: <20180209154746.GA10104@sirena.org.uk>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
 <20180131170330.GB7763@sirena.org.uk>
 <1518171736.19973.7.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7195620427727531889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D366266E55
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 16:47:52 +0100 (CET)
In-Reply-To: <1518171736.19973.7.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, dl-linux-imx <linux-imx@nxp.com>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7195620427727531889==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2018 at 10:22:16AM +0000, Cosmin Samoila wrote:

> > > +static const char * const ak4458_dac_select_texts[] = { "OFF",
> > > "ON" };
> > This looks like the users should be switch controls - what's the goal
> > here?

> I think this is to allow users to switch off sound for all channels but
> it seems silly to have 4 controls doing the same thing.
> We now have two options:
> - one control to switch off sound for all channels
> - one controll per DAC

If they're mutes they shouldn't be in DAPM at all, just make them
standard controls - they should stack up with the matching volume
controls.

> What do you mean by "users should be switch controls" ?
> Should we use SND_SOC_DAPM_SWITCH instead of SND_SOC_DAPM_MUX?

They quite clearly aren't muxes so if they need to be in DAPM probably
switches but it's not clear that they need to be in DAPM.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp9wqIACgkQJNaLcl1U
h9Dytwf7BvqgidVkfdFep3z7nEGdH+Z7pP7MHkL9WikBp0BQ1dNw2I2RYeRWdSeC
I8Pg9HZnr25ofiC6VZhBZzxlk3EEFxHtWxscaqDe7atcj9RJWEjGFoJAQpBW+kwi
BcDjUlq5Gr6wNvJ+mw58hRzI3r6rJ3Fz60k+AkeekeFxqBbvh8yOv/+fbKQ412re
bEBk0WDYwSXyO7AoaFsYVAO5JJOkek0hhnkla9m/NjuViRP+IUnM069wmywxSp05
KybSKljp+HO3Atg4fzZZ/i6W/XI9To/6ShS/GblUwVH+u5udaMgynplsAOtrOF33
c2Kz91eTV/Z7CxYqp26xc8978Cm2Vg==
=nfT0
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============7195620427727531889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7195620427727531889==--
