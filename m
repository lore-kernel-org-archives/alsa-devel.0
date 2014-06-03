From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: add I2C dependencies as needed
Date: Tue, 3 Jun 2014 23:00:50 +0100
Message-ID: <20140603220050.GC2520@sirena.org.uk>
References: <46560700.2S4p0nUZl8@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4186025135634246031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6358261AB6
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 00:01:14 +0200 (CEST)
In-Reply-To: <46560700.2S4p0nUZl8@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4186025135634246031==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 08:38:27PM +0200, Arnd Bergmann wrote:
> We have in the past added 'depends on I2C' for some of the PXA boards
> after hitting randconfig build bugs. I have seens a couple of new
> bugs in this area during the linux-next cycle for 3.16, after it
> became possible to build some more PXA machines with I2C disabled.

Applied, thanks.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjkWPAAoJELSic+t+oim98mgP/RhpB0Rro2vg1/jEkTMhr40n
8zRyK9OPKn1gG7fofvqDygFG/L2Esx3G+HOTmiFILtzLrXOb0MSFAplvvPalcopQ
9yM8/ixMjRDx9WbfZsCmAqWz1XEoosQcX1Rltpex/5iAdltf62iyKQEvcYchyZeo
UyeuBarXd2HD3zBrk0O4nxuMrBRHwRw31UJd6IsNyuau/pmEaIKHyhYyOwPlNaZV
lYDrCwMXsFTlSIrgZPLoUq3EPVf8+iWTw5vhZFjZ15GescjxJNRtsWqCGHW7ktdt
662yBHoZ90And8tEZvS7Q40K2+lYee+WY5Xbe/ppWAWrky2BH2jfezZyYeAVFaP+
vk8fjwmehFF0i2g45tb1mMWdTdXRf4WK4+X1VEG/svghHsbq0w7LnRrXbnoQoW6J
Q6zmd2LZ575H0UOhedtj+Kg7l4gKmkjXjw0nKXzIDa2qVzbQv1CPU/rFZL2e26bk
rhcTnE0MmcPcx6EmCmS92pqCZgBX+0yEm68Rl6p31eGC7wwQ/4Rc8UVxoAUukYcI
Iwpd4FJXfpVz0PC+HyxQIkmgu7ThFAsMd+Rnz6qKFHWIKvKTscFZLilfrg+tgP2C
0qB4LY9Ht75nFo9HlBFlKtRTWtL4/MlafJbE4gaYYNpuQbHOk8s4fHYmFfacelP2
jaVlQ3MCcTU1tAr+lzVr
=Mu8g
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

--===============4186025135634246031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4186025135634246031==--
