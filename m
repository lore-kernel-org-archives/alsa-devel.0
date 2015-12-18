From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/13] PM / Domains: export symbols to
 add/remove devices from genpd
Date: Fri, 18 Dec 2015 11:25:52 +0000
Message-ID: <20151218112552.GZ5727@sirena.org.uk>
References: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
 <1449272440-8735-7-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2343519288481695719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5EC0265736
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 12:25:58 +0100 (CET)
In-Reply-To: <1449272440-8735-7-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2343519288481695719==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zrEArbvrm/ur3HOL"
Content-Disposition: inline


--zrEArbvrm/ur3HOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 06:40:34PM -0500, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> Drivers which can be built as loadable module needs symbols
> - pm_genpd_add_device/pm_genpd_remove_device to add/remove devices
> to/from genpd. Those drivers create platform devices, which comes
> under a powerdomain.

This has already been applied by Raphael - it's generally better to just
mention dependencies like this rather than resending, it can get
confusing otherwise.

--zrEArbvrm/ur3HOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc+1AAAoJECTWi3JdVIfQ3Y4H/jUPp4oJ9NqvstSLHUSLDuK3
jkAd7TG1x4L1vhiBUaCtNa9H2yGBsC3eQHTyZ+LWxNNCTuni3s8XfRLobHqqZO6F
BaTVXE+vRCDafYGqmOgDMZ0aOZ93DzmrqS4EM5xUyrwnL0ixXbcZaVNavnv9kgSv
tsghEQGezn1auxzwoPmt8tWZ/TlsVUVHndkwr4VvoS4ais6gk9mhaiqikZvsmR+F
bzBbTGUjZ3CYMvx8ohVYT6tRgszrqPPVPeMeefwWKtHpLEklRuiNWQcZkoex08Xn
QGj483HreFrw68BWd3oYx4kw6nheUgIyVnphs1Ilv+382eJ6FRz7ptC4yOZIMIU=
=0jTS
-----END PGP SIGNATURE-----

--zrEArbvrm/ur3HOL--

--===============2343519288481695719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2343519288481695719==--
