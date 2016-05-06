From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: da7219: Add ACPI parsing support
Date: Fri, 6 May 2016 17:42:08 +0100
Message-ID: <20160506164208.GV6292@sirena.org.uk>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <bb23ba754ed1f51c9b20ccd4a2b87520ce7c1893.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <20160506123909.GT6292@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D463C303@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3759786874344876931=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE4C5260867
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 18:42:21 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D463C303@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3759786874344876931==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S+p9DbwVuimCDe+R"
Content-Disposition: inline


--S+p9DbwVuimCDe+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2016 at 02:45:00PM +0000, Opensource [Adam Thomson] wrote:
> On May 06, 2016, 13:39, Mark Brown wrote:

> > > -	/* Handle any DT/platform data */
> > > -	if ((codec->dev->of_node) && (da7219->pdata))
> > > +	/* Handle any DT/ACPI/platform data */
> > > +	if (((codec->dev->of_node) || is_acpi_node(codec->dev->fwnode)) &&
> > > +	    (da7219->pdata))
> > >  		da7219->pdata->aad_pdata = da7219_aad_of_to_pdata(codec);

> > >  	da7219_aad_handle_pdata(codec);

> > Surely we should be able to check if there's firmware data without
> > enumerating every possible firmware type?

> There doesn't seem to be a unified check for this. Also, Given these are the
> only two types the driver expects and supports right now, I don't see a problem
> being explicit here in the checking.

Again it's pointing out something that looks like it's missing from the
fwnode API - if people are supposed to be able to write firmware neutral
drivers they should be able to do everything they need at the fwnode
level.

--S+p9DbwVuimCDe+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLMlfAAoJECTWi3JdVIfQXOgH/34y5Cdv00qQtzfpM/JSaw1n
ZY7acdExkDDgSMmGK/QT/caLRPx1a2wO1mA67XlCI8DoPtENeRCvatBtnmK6hnDr
6JZh6sW9pvEPMKUWsXMc7edhgqpMlkO3gamU7Ie82w9KE0CCJuvGD8vcxLEuqd+e
rgAkb4wLOnvwpEOVwggcnYowhss6VHeOVUpv5nRtp8ft08r/lXvtB3KTyRLnU7MZ
0gKUsIGrt25JGFh4Hf7qOgy+Yp9vBiNbKWU2ClhEm231Vv5DPYc9vOh35wkM+cjD
fRDhNBu9v6kk1H5yAtMjZc6XobQELR/ZYvm6DqllvBF67LFTujk8WNXxEjpF7XQ=
=T58q
-----END PGP SIGNATURE-----

--S+p9DbwVuimCDe+R--

--===============3759786874344876931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3759786874344876931==--
