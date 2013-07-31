From: Mark Brown <broonie@kernel.org>
Subject: Re: New dapm panic on beaver with next-20130730
Date: Wed, 31 Jul 2013 11:36:10 +0100
Message-ID: <20130731103610.GH9858@sirena.org.uk>
References: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
 <51F8A933.4080708@metafoo.de>
 <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
 <51F8B045.8030303@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4432938906938166810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AD519265478
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 12:36:17 +0200 (CEST)
In-Reply-To: <51F8B045.8030303@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Olof Johansson <olof@lixom.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============4432938906938166810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Zmx+D4iIlhaUSmU"
Content-Disposition: inline


--4Zmx+D4iIlhaUSmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 08:35:49AM +0200, Lars-Peter Clausen wrote:

> 0x6b6b6b6b is poisoned freed memory. According to the source neither
> the INR Mux nor the INL Mux widget should have any sinks. Can you
> add a couple more printks:

Dan Carpenter sent a patch which is probably the issue - I'm trying to
figure out how to boot my Beaver board so hopefully I can test, it'll be
in -next tomorrow anyway.

--4Zmx+D4iIlhaUSmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+OiXAAoJELSic+t+oim9DW4P/Aqkeyehgq6ZF+PkdNs56/jG
JuamVclhaaQB+gevTVKBg4kOmnETbVDw79XOSH4gjEx5WZBugVMfdBpnEo0pb+fh
NzXOTimqz+GwJtLHpuwjCMiINf3wx2iZ37erCvpJoncIMoUMjXq6ToAnGcCMNiFS
wJV4xVODuc5C9I4BGkqS/Vwin8gjqnuVHcXGHoX2Bukr9BWScAPk1x+B65ea1PfX
weCOPhkkivCWxz6qPEEbg1FMqG7sBpL3OHGu+E5y7vlC6BOSE6mOXPAg4rh01odV
2JL7X7LL2PeR6Uzb5YFbt3rf5VR8Q+6IeoNaKa2lKFoOk38G8rS8MwydcBLuJxav
oAZdB3FFSf4oEhhoxttSnXM8VzLjsqaggomZS1zh+VBIsWYH6lOIw3lkbXP4OAXD
rjXOwU9TVREZHA6zsrqiqCQe9UAg4Ysm3/iByXfgLVOuUqsiyO8G2J8lrXc5eD6v
klz3kkUA2ZdWIVhfC35U/nvSd5s1RiTnrO8PJSR7iyzwN2kZKwuGKZfBnbPN46YH
bJZvxvxg0ACGrSlCjstkNuFy47SEoHgc679wpi53cIwrquo2T1qyytc6A0P6H0xP
h/ztiy9tDMQt3xlLbyB5Fkc8oVvswl9Ia9eRtxgyA5j+VVH8KylkLuHlYZKNkx33
Zqh2YKyv9KQ5shJv0S1n
=v9Vq
-----END PGP SIGNATURE-----

--4Zmx+D4iIlhaUSmU--

--===============4432938906938166810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4432938906938166810==--
