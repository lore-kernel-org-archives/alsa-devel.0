From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [BISECTED] 2.6.36 regression for ALC892
Date: Fri, 26 Nov 2010 19:27:37 +0500
Message-ID: <20101126142737.GA3522@belkar.wrar.name>
References: <20101125211803.GA4236@belkar.wrar.name>
	<s5h7hg0sk04.wl%tiwai@suse.de>
	<20101126091211.GA3505@belkar.wrar.name>
	<s5heia8qvry.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5145863518328736919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from haley.wrar.name (wrar.name [109.74.195.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 766C8244DD
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 15:27:46 +0100 (CET)
In-Reply-To: <s5heia8qvry.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5145863518328736919==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 26, 2010 at 10:28:01AM +0100, Takashi Iwai wrote:
> Try the very latest alsa-driver snapshot or sound-2.6 git tree.
> You should have an individual "Headphone" volume as well.
Yes, that makes difference: I was able to use the headphones after raising
that new volume.

--=20
WBR, wRAR

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJM78PZAAoJEOih81koZvPBS+4H/ilBPQen1LXKUrbw4BT1TMqS
p3uyNlMkzUYl+zZSRncizkADwNtqiGsIMgk+sZXj1DqiDpB3DkZn5zEw3QlVhRSx
y/U800nJJ4/bAZUk/eIH7CxEleAfDLGV2YJDDwP4S0DeBfT0fsJlEKZnKv+nO8pg
2EM56qBAIaNyw14P6bFhvl+Ye/cYYmpc1eIGsTpbLstpug/gSR+KQjb2tTwQ5HP/
j3Iucn+EZTjEnS9kUlSaqkd7RD6ahiVts6lbiGcTl7uydrvLM1SxszTAjdY2ls0/
WFJzUtMPFYeK13w9bZkPKLP0YaJjyaIMzdfvYJpTKTid5gLYgYYEOyOrX/hoPLM=
=RnoN
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

--===============5145863518328736919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5145863518328736919==--
