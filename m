From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: enable speaker protection
	features
Date: Fri, 23 Jun 2017 16:09:22 +0100
Message-ID: <20170623150922.prdfk5r72aw4b4av@sirena.org.uk>
References: <1498184697-2156-1-git-send-email-bardliao@realtek.com>
 <20170623113324.cdtfp57gaatrpojc@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70267665F@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0816611726522055371=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B876266AE9
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 17:09:32 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70267665F@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, Alex Lee <alexlee@realtek.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0816611726522055371==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jz7tqdrk3wdh2mei"
Content-Disposition: inline


--jz7tqdrk3wdh2mei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 01:55:29PM +0000, Bard Liao wrote:
> > On Fri, Jun 23, 2017 at 10:24:57AM +0800, Bard Liao wrote:

> > You shouldn't be changing the register defaults away from the physical
> > defaults, just do it with a normal register write.  Changing the
> > defaults will break cache resyncing.

> Agree. The reason I did it is the register will also be modified by
> regmap_register_patch.

If it goes in via a normal write it'll still get restored, just as part
of the regular cache writeout on resume.

--jz7tqdrk3wdh2mei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllNLyIACgkQJNaLcl1U
h9BAYwf9FDmXPlY9cYhOCeVJb4lfhblpdeKW4UI76k/L1jocTNYzI8twYrXkP3JH
dGCQzQNg2g12yJAB3Ef9q2Q3s26d86IzZtipAINKjhxUluqzhWNQfgh08L+0dsVO
nWqBpr3j/sfcXffYcxvbNUps3WKrp2FOXqINqq0HJWAphEF1l3g47DAffNAZB4DA
AivARFZ49nWBvzdjdPoCOvhDgw5gtJRoHaS9sdpA9wZGdKbqoe3kCgMnMeeMyjM9
u418kFMuZXA5E9gwGut732vXpt64BfLm6wvoKq0zpjnTIHVpxsA8qkKNJLjTX7e1
a3h+xjNNUg//1GOGuN6zg5zCzO/trA==
=DIIf
-----END PGP SIGNATURE-----

--jz7tqdrk3wdh2mei--

--===============0816611726522055371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0816611726522055371==--
