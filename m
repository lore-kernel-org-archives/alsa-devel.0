From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] Update codec driver for dual mics
	configuration
Date: Tue, 28 Nov 2017 15:15:17 +0000
Message-ID: <20171128151517.fxs7dgyyhsj6zu7q@sirena.org.uk>
References: <20171121171546.5656-1-carlo@caione.org>
 <CAOQ7t2Z=gyX5jyewnM_1gD6_Vnsrs2v6GGToyEkd7tSTHc7FQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3138754064453123803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 630BE2677C6
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 16:15:23 +0100 (CET)
In-Reply-To: <CAOQ7t2Z=gyX5jyewnM_1gD6_Vnsrs2v6GGToyEkd7tSTHc7FQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org


--===============3138754064453123803==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="skg3pher4tzzn6ro"
Content-Disposition: inline


--skg3pher4tzzn6ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 02:08:05PM +0000, Carlo Caione wrote:
> On Tue, Nov 21, 2017 at 5:15 PM, Carlo Caione <carlo@caione.org> wrote:
> > From: Carlo Caione <carlo@endlessm.com>
> >
> > The RT5651 codec has 3 analog input ports. Some laptops (like the KIANO=
 laptop)
> > have two different analog mics on two ports, leaving the headset on the
> > remaining one. We need to add a new quirk to support also this configur=
ation.
> >
> > Carlo Caione (2):
> >   ASoC: intel: byt: Introduce new map for dual mics
> >   ASoC: intel: byt: Fix quirk for KIANO laptop
>=20
> gentle ping.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, though there are some other maintainers who like them - if in
doubt look at how patches for the subsystem are normally handled.

--skg3pher4tzzn6ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlodfYUACgkQJNaLcl1U
h9AOTwf8DOTbmi0BSW/2GBf0ySfgRDCCxhju2WKAupyBFMfBQStgjlhsJGZQjlZ+
xGAf6sXyoqWFFi/Sjaur9VMNOTrlZD0xEaz+CvrnjU2jkTnEE32UnoHvLq7RDXKw
/+mDzQ4fYKdCC/0mXlaHV69o1dLCPb+ttQT9JwkWjHX4Vwc+hKnwmmGlhnVn3cyf
SLDQ38+1vGno8D8GaYbNj0Vt/gn0utNGfEzHYhVwb3UDGLALmt/tlggdeE0ia8+q
72UtPUXEvbvt8l5ptCqq2GfMiSnMy/Kvo7og6UacGWvskhgdjjlUQMGJRib8607H
bahGiqFYAkAv2S7M1dyAMxTwtjSrBw==
=UUTw
-----END PGP SIGNATURE-----

--skg3pher4tzzn6ro--

--===============3138754064453123803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3138754064453123803==--
