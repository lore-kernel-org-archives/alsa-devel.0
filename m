From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC: AMD: added condition checks for CZ specific code
Date: Fri, 30 Jun 2017 11:16:36 +0100
Message-ID: <20170630101636.olnregex24rugg27@sirena.org.uk>
References: <1498235706-31111-1-git-send-email-alexander.deucher@amd.com>
 <1498235706-31111-5-git-send-email-alexander.deucher@amd.com>
 <20170628180539.3uns3nudnjrjsx7o@sirena.org.uk>
 <MWHPR12MB167880D4FDA44921AB2397F997D20@MWHPR12MB1678.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1875919131=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <MWHPR12MB167880D4FDA44921AB2397F997D20@MWHPR12MB1678.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "rajeevkumar.linux@gmail.com" <rajeevkumar.linux@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "perex@perex.cz" <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org


--===============1875919131==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kulj4ifmnmdpipdu"
Content-Disposition: inline


--kulj4ifmnmdpipdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 12:58:02PM +0000, Mukunda, Vijendar wrote:

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]=20
> Sent: Wednesday, June 28, 2017 11:36 PM
> To: Alex Deucher

Please fix your mail client to quote mails in a more normal fashion,
this looks pretty broken...

> >These defines are being added in the middle of a file but CHIP_STONEY is=
 also used in another file in the previous patch (and apparently extensivel=
y throughout the DRM driver already).  This is obviously not good, >we shou=
ldn't have multiple copies of the definition.

=2E..especially in that it's reflowing the message it's replying to to
cause 80 column problems and has serious problems in that regard itself.

> We will modify code to use single definition for CHIP_STONEY and CHIP_CAR=
RIZO.
> There are only two chip sets based on ACP 2.x design(Carrizo and Stoney).
> Our future Chip sets going to use different design based on next ACP IP v=
ersion.

Write the code well, that way we don't have bad patterns in the codebase
and if plans change with regard to new variants you're covered.

> In the current patch, Condition checks added for Carrizo for setting SRAM=
 BANK state.
> Memory Gating is disabled in Stoney,i.e SRAM Bank's won't be turned off. =
The default state for SRAM banks is ON.
> As Memory Gating is disabled, there is no need to add condition checks fo=
r Stoney to set SRAM Bank state.

Some documentation of this in the code would be good.

--kulj4ifmnmdpipdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllWJQMACgkQJNaLcl1U
h9ABdwf/TiBzZsxqwihHL4f4e8oF1IOzOQJg8lBD7b8mPoFCwy13fIJ18oB8kbhQ
6BG7y14kH87CMz4bNgRVEf0rVnVOILythEIMaX965gUw2nggYjJLA1+9BtzUEojQ
ocaC8skktEcdbk6HaZNoW2yRoouT7DzRuPZyPALIilMEjAFzufdKrg7TT+4I5voE
ZQV9VlAKkrIkarFdwLIpVOD+kGGIO8YUMyPFnXzHcSCZLZWWpTBFSB7u2dAaA4n+
URZaYW6MmUoVUD/EbDs3+/6Cdqk5JOeWbWJLDs81kuWGHBcwVX51dF71uLvz/wuL
8vUTyM2ZYm1D9JfqvdUL0i/aW/fJGg==
=B2MX
-----END PGP SIGNATURE-----

--kulj4ifmnmdpipdu--

--===============1875919131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1875919131==--
