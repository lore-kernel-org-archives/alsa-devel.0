From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsrc-card: remove unused ret
Date: Wed, 17 Jun 2015 11:25:19 +0100
Message-ID: <20150617102519.GA3214@sirena.org.uk>
References: <201506162207.NtueFC0w%fengguang.wu@intel.com>
 <87r3pb5g1a.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3044132916744160864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EAB8E265B9E
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 12:25:45 +0200 (CEST)
In-Reply-To: <87r3pb5g1a.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3044132916744160864==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 12:36:48AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> '047000278da3a17f8("ASoC: rsrc-card: cleanup for DPCM")'
> cleanuped rsrc-card driver, but then, unused ret was left.
> Below warning happen without this patch

Applied, thanks.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgUsOAAoJECTWi3JdVIfQ3twH/iPASszOtb7gD/b+W5A6L8F/
GSgbnGJYwpwOFJKM+rVBrxwfafFEbUy3coT2OcPUp0WfcTEVHzJJKTh3cuhCaa6X
xJ1EIw52kcX4Skle7Dpl7Bvy25fRTYSmhWUVJYXmJtnUU8fGkfq+3L/pdOlGy7om
0I6PjrxmsPofQnu5Xaj7ZAN8jNODEnWQCIVxRNxSKDTO6ShKWGNaY3WRfn8uowOm
XCE7BbVzLbTJ58t+gf+nSCUjSCyPTEiZHZ0ULbY5JdcoyAWI9YXqd/EIMq8Lr2Rp
bJPvxOGgFE8dtHfOJrDHobXqNfaN6Lv/dLy+b3mK5/fKBYJrtoaafxgJ0pn1r+M=
=nCNC
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============3044132916744160864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3044132916744160864==--
