From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Fri, 6 Nov 2015 21:22:12 +0000
Message-ID: <20151106212212.GL18409@sirena.org.uk>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
 <20151104183322.GD2549@ck-lbox>
 <87oaf9bls9.fsf@belgarion.home>
 <20151106092913.GC3378@x1>
 <20151106092733.GG2549@ck-lbox>
 <20151106094828.GD3378@x1>
 <87r3k2am8o.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg/E/yN4pR4or5qL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r3k2am8o.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--bg/E/yN4pR4or5qL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 09:47:35PM +0100, Robert Jarzmik wrote:

> Ok, so where I should target this code at ? Should this land in
> sound/soc/soc-ac97.c ? Or somewhere else ? I'd like to see where you think the
> init_gpio() and free_gpio() should be put.

Sounds like a reasonable place, or possibly even the ALSA level AC'97
stuff (though I'd question if anyone would ever use it outside of an
ASoC system).

--bg/E/yN4pR4or5qL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPRoEAAoJECTWi3JdVIfQrSkH/i75usxZBQ5TJql5ZfFEv5so
UdwRUG5VigU8XYoqEM81XZwRNPFMBLFbDpj5pQ+cdX876WNEICvszsTSJnRbeDBj
mQSEYABae7hV1++ikkeVSg+8pneizj5/mmIOsFYQXiNIG3W0PudFSTQRwjhBS59y
Yp19cFVMbb+kl4eJw23n32EeDloSl9FCBgJAcKdwl/6j5J8eiIu7fZqi3ohkzlIN
W+1doC/hPMUyehLldqQUPTFuGjQQIy387HZbyFbe6+stCzEqrcNM66+lWyX5SG7h
ucM/XR2RZmLVFgkPlsYWIuNfULa6ldk+P3jf4mXhey51jnXQmLDHc4ZjwV/4Hhs=
=DXam
-----END PGP SIGNATURE-----

--bg/E/yN4pR4or5qL--
