From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] [patch 1/1] imx-sgtl5000: return
 E_PROBE_DEFER if ssi/codec not found
Date: Thu, 4 Jul 2013 15:59:06 +0100
Message-ID: <20130704145906.GC27646@sirena.org.uk>
References: <20130620212100.075892857@rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0924584483862955551=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D8DA4261AB4
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 16:59:11 +0200 (CEST)
In-Reply-To: <20130620212100.075892857@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0924584483862955551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ejChHpkz4tWrd0Q0"
Content-Disposition: inline


--ejChHpkz4tWrd0Q0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 11:20:49PM +0200, Arnaud Patard wrote:
> If the ssi or codec drivers are not loaded (for instance, because spi or i2c
> bus drivers are not loaded), returning -EINVAL will for people to unload and
> then reload the module to get sound working. Returning E_PROBE_DEFER will
> mitigate this.

Applied, thanks.

--ejChHpkz4tWrd0Q0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1Y23AAoJELSic+t+oim9BLIP/0LJNYkxkgYIRnzwnN3x0VFb
//NNjg+L5n+3cNvRVjAoESDC0fk/v5wongRJcgf4Rb6QKDYMWIcc/2cYdF7/56Lh
OmHQR0pktuOh7PM7oTKP3elWpM0oWvR+L2cwf0kATdxR0Pkg2rCXpl9CzqI/NaOr
OwfzFih82Mc/b0PuAMX7eSF999WGriU5avqBIFcF2g+rvDnmGToSUwv1DNpZph1c
VV7WIjKoLd8JjEpUqFPxzoA0iKnzA+kIt2kf6UaKX2Cv0nC2YEGwnx/N5CMXr32p
FBFEgYkApHUlEGnQZaP1M2alh4vpHI+qFHFQrtsbtDk9naT7P2JgWRwudND6XHU9
AaIhJQzJepE93TgN/mAWVB6DqQTtVwVpChu5kOwFJS15iwOnRnwitCGWZG7iZqCk
Rl57EMNbYrNXi7nXwzL2tHGqE+uH4BhxU3t53O9gyXzpSxiZURC96FiS9js4K44r
iQU9kts9Ept5NYgyQkIHn6D4gqarlqGdq6aUnHuZDFxXfUmcM2wcPSZHSRmy1qZo
WGLlVuzl0mIqwehaJzJrSkQC6rRpYVgzH0aX5YGcdo7q/URF4GMmpBLYSbWgpxhv
Io5ka0S7qoD2k2/RrtpdNVx7kQ/ojwp06jpVRe4ucRD2DoEHmAIhNtJAbQcIWmgc
BD2Bqe1AG7dnQJrpKzsF
=FakI
-----END PGP SIGNATURE-----

--ejChHpkz4tWrd0Q0--

--===============0924584483862955551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0924584483862955551==--
