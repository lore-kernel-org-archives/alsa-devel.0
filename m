From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC : dwc : add different playback/capture base
Date: Fri, 23 Oct 2015 00:01:47 +0900
Message-ID: <20151022150147.GR8232@sirena.org.uk>
References: <1444320760-21936-1-git-send-email-alexander.deucher@amd.com>
 <1444320760-21936-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0170972760=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1444320760-21936-3-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============0170972760==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ep5m4srWGXPl6O+g"
Content-Disposition: inline


--Ep5m4srWGXPl6O+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2015 at 12:12:35PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> Some platforms (Ex: AMD CZ) can have separate dwc controllers with
> different base address for playback and capture. This patch adds
> necessary changes to support it. Platforms which make use of it can
> supply a quirk in platform data to make use of this. By default,
> playback and capture base addesses are assumed to be same.

If these are two physically separate controllers that don't share
anything then why are they being represented as a single device as
opposed to just having two devices, one for playback and one for
capture?  You'd still need to register the DAI differently but it should
be a much less invasive change and map much more naturally onto the
device model (what if some system has put playback and capture into
separate power domains for example?).

If we do go with this then we will also need an update to the DT binding
to document how the additional resources associated with the second
controller are described.

--Ep5m4srWGXPl6O+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKPpaAAoJECTWi3JdVIfQC4gH/2QrbB88NUABG1hhh9PifxvF
8Hhb08Zfk/kQicUU/0jKmKGZd5KpgimVd9C3R/dO3cjz/zQRdreRbvx3WD452NLe
AQLTPBWyRFE5jj+i1X5+Wknd7+88UiBr/Mdn/cMnZXezzmx+bIzN7GotY/P2TMEs
PbzFuycCNMABHi1gdvbAhlaXhwD41wBOYJsKn0C58jNLncj2H4qb0WeaIiPLqXUc
aq41cnCkvRaUrE1nNgNv7Ms8ts5aOChaUAXMjDYYYH4+Wpp/6wpdmAUhaRGIkrP5
4iAcGX4hADpp+JDchm2MULQF8+FCmjMDC7T/8bXK6A2ABHR79z45Dr9tlp3hzZo=
=IR5s
-----END PGP SIGNATURE-----

--Ep5m4srWGXPl6O+g--

--===============0170972760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0170972760==--
