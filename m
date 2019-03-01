From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Fri, 1 Mar 2019 12:36:29 +0000
Message-ID: <20190301123629.GC7429@sirena.org.uk>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3772793944804035914=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45235F896C0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 13:36:35 +0100 (CET)
In-Reply-To: <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============3772793944804035914==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2019 at 03:45:44PM +0200, Jyri Sarha wrote:
> On 22/02/2019 23:27, Russell King wrote:

> > +	/*
> > +	 * If the .set_bclk_ratio() has not been called, default it
> > +	 * using the sample width for compatibility for TDA998x.
> > +	 * Rather than changing this, drivers should arrange to make
> > +	 * an appropriate call to snd_soc_dai_set_bclk_ratio().
> > +	 */
> > +	if (fmt.bclk_ratio == 0) {
> > +		switch (hp.sample_width) {
> > +		case 16:
> > +			fmt.bclk_ratio = 32;
> > +			break;
> > +		case 18:
> > +		case 20:
> > +		case 24:
> > +			fmt.bclk_ratio = 48;
> > +			break;

> AFAIK, this is not the usual choice for 18- or 20-bit samples. Usually,
> the bclk_ratio is set to the exact frame length required by the sample
> width without any padding. That is at least the case with
> tlv320aic3x-driver and 20-bit sample width.

So, this is true.  On the other hand like Russell says further down the
thread it's preserving the existing behaviour so it would be surprising
if it actually broke anything and it will help systems that explicitly
set the ratio so I don't think we should let perfect be the enemy of
good here.

As Russell outlined there's quite a bit of hopeful assumption in how
ASoC handles the mapping of memory formats onto wire formats which works
almost all the time but not always and definitely not through robust
design, that should be a lot easier to address once the component
conversion has been done as we'll actually have all the links in the
system directly visible rather than bundled up together and implied as
they are currently.  Sadly that's a lot of work with not many people
working on it so progress is super slow.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx5J00ACgkQJNaLcl1U
h9C2/Af/Z3p09N+TC8JUihisw9AkQqdpkeQpjhhTmyev9TUB1UDD+ZhwzTEmMMIM
yhcUvxgO39n8l5VeOHNiJwrc5xL1RFqQb0To01c5Z5nnzdbsY7wbaRilSW9upu8+
3FtFPqszAHeHJmspfcHga70mlMd3NzWWmbxcN+wfC9nYKme008TlcgCtMpPifLzw
Y+0TvXd3o5qD3a5dARt/9Tb/lo4HwsGhz/dsGUnw963ilSX8J72MJzdR4bnvxett
rJibhgUEv0BETdQH7k/fnQcYPOLZ1Ek99ZfxczL0L4sDorxuJJ5XoqEuLh2yZpRD
PgT6/MGoP6Dzur2k/hfy7643iWHGuw==
=JbO2
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--

--===============3772793944804035914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3772793944804035914==--
