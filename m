From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-pcm: Correct dma mask
Date: Tue, 3 Mar 2015 14:08:48 +0000
Message-ID: <20150303140848.GP21293@sirena.org.uk>
References: <1425382694-30424-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7910128962035633192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BFB42614C1
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:09:01 +0100 (CET)
In-Reply-To: <1425382694-30424-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7910128962035633192==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z0yPRMMxO/ZomZ5q"
Content-Disposition: inline


--Z0yPRMMxO/ZomZ5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 01:38:14PM +0200, Peter Ujfalusi wrote:
> DMA_BIT_MASK of 64 is not valid dma address mask for OMAPs, it should be
> set to 32.
> The 64 was introduced by commit (in 2009):
> a152ff24b978 ASoC: OMAP: Make DMA 64 aligned

Applied, thanks.

--Z0yPRMMxO/ZomZ5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9cBvAAoJECTWi3JdVIfQbJ0H/3yv54DTY6k8ki+FfMMHC98J
rhVIUpgvsadPHRpcOblmffDHBZTw0m1HbSYwGQiC1mHN/6JpHY9b8fiFbPAE6Ao+
La6xoP3mxSvvpjW0cvTmB23TCJUbGyEv6l2EMrsDBbJHD+4l6TDk87GcySaSu//2
fHgRyp0cu1XsjryB1raZCFpaQJ8Xf5ahY5MD25de5LqwQ8hCtC07SIn8gmufbxP4
ovgbYLWT8312w+XnkKW1t16Yq4rRT9yuXLduU8e2/edeJdYq11KKBASi5KR8dmFe
qIS16A1IkbQotsvDuf6hGZGT5uOZcs6vDWY7UdQu4U1hpKG/KlVMl1ZoEjgBExM=
=SZq9
-----END PGP SIGNATURE-----

--Z0yPRMMxO/ZomZ5q--

--===============7910128962035633192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7910128962035633192==--
