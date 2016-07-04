From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rockchip-max98090: Fix NULL pointer dereference
 while accessing to jack." to the asoc tree
Date: Mon, 4 Jul 2016 10:47:35 +0200
Message-ID: <20160704084735.GR6247@sirena.org.uk>
References: <1462435421-21205-4-git-send-email-enric.balletbo@collabora.com>
 <E1b0CjK-00007p-Fj@debutante>
 <CAFqH_53jTEG7NvWt+9NBV_BVk28PZFdNSm89_DCqZvDBV+o9ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u+HAydxlPP+oPOdi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_53jTEG7NvWt+9NBV_BVk28PZFdNSm89_DCqZvDBV+o9ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org


--u+HAydxlPP+oPOdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 09:24:12AM +0200, Enric Balletbo Serra wrote:

> I just saw that these patches and the others in the patch series were
> not applied yet. As are fixes and were accepted since middle May, I

No, they are actually applied like the e-mail said - please see my git.

> expected see the patches merged in this release cycle, but we're at

In general if you think a fix needs to go in urgently it's best to
specifically identify this.  If nothing is specifically said and it's
not obviously related to something done recently then the tendency will
be to assume that the issue was recently introduced and is a fix for a
development version.

> rc6 so I suppose I'll need to wait to see them merged for 4.8 merge
> window. Please can you coordinate with Heiko and make sure that these
> patches were merged before he merges the patches to enable the audio
> on Veyron? Otherwise we will break Veyron support for a while. I'd
> really like have audio working on Veyron.

As things stand they'll be merged in the next merge window.  They're
buried in the middle of a branch with other things so I can't just send
the branch as-is.  If these new patches you're talking about are going
to get merged in the merge window as well so we're presumably mostly
fine?

--u+HAydxlPP+oPOdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXeiKmAAoJECTWi3JdVIfQ8YEH/j6r90+EvpRd2/5n5fFv5fbR
ZI1XsG0m6zClErCYYcSJa6B+CGNOdtngyWok37wwcInvlcJaug/pOGaZ1KNMsrFs
MFJugWPeB6g6Z/JgYvYFzOAUThfOuLIlYsHVHxTQS0jskYKOhSmIr50jVy9j4P0G
Fy6WCD49Xs+DffgSef4u0y6lAS4/V48vP//mxRn/WAdzi2PpJ1lumb3gp79JDDR0
YW0fl/lTiupKbiEHlAXq4tTzLdVo0IdkAVZZWeEsSDxKLHiaiWWe2Jx3Bn3gQgiV
eiJ3/rkpmj3gHacKT19gDpw5VlCNUVi7A1DzvP4GuAR0l1k3uCNLW0OANKXhsI8=
=IUk9
-----END PGP SIGNATURE-----

--u+HAydxlPP+oPOdi--
