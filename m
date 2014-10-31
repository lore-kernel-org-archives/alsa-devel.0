From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: mfld-compress: implement .power
	callback
Date: Fri, 31 Oct 2014 12:52:10 +0000
Message-ID: <20141031125210.GY18557@sirena.org.uk>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
 <1414666259-4450-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6117544244739581946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91535265835
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:52:32 +0100 (CET)
In-Reply-To: <1414666259-4450-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6117544244739581946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q2efgaiYRy6GdUpU"
Content-Disposition: inline


--q2efgaiYRy6GdUpU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 04:20:58PM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> .power callback is required to invoked for compressed audio as well to tu=
rn
> on/off sst, so invoke them

Applied, thanks.

--q2efgaiYRy6GdUpU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU4X5AAoJECTWi3JdVIfQonUH/0Ebr/7O+vr5AgWroEJ1IBHL
4qSHiGt6qj7MCJhHMoh3oLtfXdikVQxM0MyfuUKsZ33tBzajQ3Fd9Xv9GAxNnmcM
yY91wFNFG62vDQsBjT3BmxLM5zs4d1aul4KOcNfwUY3r8KzeZWXNGzNMQoWfw+5d
gZFXaBWFiUsbAML4peRzL9aA6u639bwlEASrJW/Fs++eQHCi/EuLKP+i1/4kr8pp
LI0eQvvN3lFlY7zw6d+RnhMFJIedSOvAae882zwD/KCrUdU2aPe0mOBqskFpiiMj
QN2QjmlGcRX+f5geL6MRtENcGewK0mBIIZCvyoahEWxruqu04lxCI/mZLoNbiUY=
=Y/x/
-----END PGP SIGNATURE-----

--q2efgaiYRy6GdUpU--

--===============6117544244739581946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6117544244739581946==--
