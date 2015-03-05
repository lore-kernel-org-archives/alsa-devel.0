From: Mark Brown <broonie@kernel.org>
Subject: Re: Using simple-audio-card with imx6sl-evk
Date: Thu, 5 Mar 2015 11:13:12 +0000
Message-ID: <20150305111312.GH21293@sirena.org.uk>
References: <CAOMZO5C_-fv8A7kaM42dbskpmr91xkVk-5uTXN6Pe-TxydFo2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3591489748774645815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EAFD260442
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 12:13:26 +0100 (CET)
In-Reply-To: <CAOMZO5C_-fv8A7kaM42dbskpmr91xkVk-5uTXN6Pe-TxydFo2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3591489748774645815==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gG/WL4KA7JrsMxZ/"
Content-Disposition: inline


--gG/WL4KA7JrsMxZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2015 at 12:07:23AM -0300, Fabio Estevam wrote:

> When I try to play I get:

> root@freescale /home$ aplay clarinet.wav
> [   16.424340] wm8962 1-001a: Unsupported sysclk ratio 680
> Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono

> and the track is played with the wrong frequency and wrong sysclk ratio.

> Any suggestions as to how to use simple-card on this board?

The problem is that simple-card doesn't understand anything with a more
complex arrangement than a single dumb clock.  Moving the clocks over to
the clock API and then configuring them that way is probably the way
forwards here.

--gG/WL4KA7JrsMxZ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+DpHAAoJECTWi3JdVIfQWR0H/006USmkldaC9Aw0z22DnZFu
n830STojA6Pw8mGx8gGJ8jd4TUbRFQnuSCJorLJZCqqN2VFBjcxuNQ6AHtaHvct6
6GmfurUw8eCSO/bh9ZEVJ+cTQMuT000mY9XCTqD8SlsT0W7NPxDw72PpddqIS/ES
+rnT9LW3e18aIu8Byx06aWCfXkAsQfYsKb1c8ZMlMHbyOc4XeNtTaiZcTK3oD1bP
bjQEQKFPRCTgppkY5UCVOAAQcLjfjPBOngsifZgg+I5ROMjzauQ6GDIj/7JId7ab
42hvUAsUkaKravUxn6RiiU4GSZWaNgvoBkdZqk5vVNWeeyCAUVHtZdHwjpC7itA=
=pLtf
-----END PGP SIGNATURE-----

--gG/WL4KA7JrsMxZ/--

--===============3591489748774645815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3591489748774645815==--
