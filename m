From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 07/13] ASoC: kirkwood: move calculation
 of max buffer size to kirkwood.h
Date: Mon, 5 Aug 2013 18:07:19 +0100
Message-ID: <20130805170719.GX9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63yG-0004le-16@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1456636766234500759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5532650F7
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:07:22 +0200 (CEST)
In-Reply-To: <E1V63yG-0004le-16@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1456636766234500759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2ShJCx8wt5zW4IJW"
Content-Disposition: inline


--2ShJCx8wt5zW4IJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:28:04PM +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied, thanks.

--2ShJCx8wt5zW4IJW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9vEAAoJELSic+t+oim90AAP+wR1WEhE44cH4Ly+CAiVwfMP
WSraBSVhtbwdvlYKBiIx6S4e3gXXvao6qO5MuxwR270UER7Xb1XGHo25ZxbYmwXR
q6967AA/hicIb5Ir8JZM40M/EOCYKuL2/1M/vknlpdTcq36RyZjIk79MX9b3pIVr
6o8OrGoJH0vrzvWKIxT7Mj6m87AnbP5tPdEkXWcFsTZuNFR62PHJNYeY4+imLLKc
pA1O3TGHF7T2eRWANJIG7mEXNOD38qFSncyrEcs12T53raGNTk0ZVun9GlJZ8yZy
p9Kj7D7jAEYttoTPrpDHN/DI2m1vhXMv98V0O0xdneABKb2Z34miJ3ZWehZh9IIZ
T7AlrM4TInNEnkCCcR01zk7I1uvEm6IeXTu1kYv7O7Idrbg67gzHADtNXMfNlgUD
N1BMilR4HA87zV6PbB8E3oarbK/lgLUgbYoO+b8a+VNkP6frzEt5F10lReIvUKoC
n0vZrIHNzeqIONyb5EnDmL+CPZdO53Fkjtacaq1f7OItR+UX6yS86QwnKiwWkSoS
028acZjaF8yObGf4NkgadjVqJMjIVM/rIcFwnGarFAdCCQtgbCVkSIlp8oSIUVI2
entIycQUXOuxqbmF07W93KoyXydpfUgq5SwOzECF0V7DbEJ2TxFyiz3dh9KJU8Ue
Exi3Ed9qG3ug8LO5r5NP
=3Rha
-----END PGP SIGNATURE-----

--2ShJCx8wt5zW4IJW--

--===============1456636766234500759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1456636766234500759==--
