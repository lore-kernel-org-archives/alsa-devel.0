From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: place size constrain
 on period, not buffer
Date: Fri, 9 Mar 2012 12:19:34 +0000
Message-ID: <20120309121933.GJ3273@opensource.wolfsonmicro.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-3-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6137120239840359972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBD1910BBD0
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:19:36 +0100 (CET)
In-Reply-To: <1331248757-3408-3-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============6137120239840359972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 01:19:16AM +0200, Grazvydas Ignotas wrote:
> Placing a constraint on buffer size is not enough, programs are
> still free to use periods that are smaller than FIFO, which causes
> transmit underflows as soon as the stream starts if program operates
> in period-sized writes, ending up in endless loop of underruns.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfVPAAoJEBus8iNuMP3dPYQP/3suRFYYdX+xPkjP+iDPb+z2
SvFOIXZ+J9ELpi8LUyO9dVYmfI4uJCSVZ+DCIihBwa+Kp5IahODLVlUPCGfzLuio
GmhDK6sd/WhNA/K17jUW9POvUC+8/mIkH20SB+kDhvdGAbLEswfVuC/kzjlHYTm7
EIFotYiq3yYco6DxGOYhshTZG2T19EvElNLn5hfSHB0zOCeNthdfEHBE6E5eo7Vb
PKcrDOJecDtjzC2zo7gb++SCnsfCrlXrXdi6ZAQFHlTk5Ingl0MYITm2FMs57J81
TY5CrreGYWMg7+IeJ78RPOCow2KE+YPuYuhgS2pbmUTJw+AQkeoBDJQCTfqgbzTE
vjeGZU/nezCiou9L/qGZtId/1u0FNaw8NZUSDbyDQnLZnQCyXs+1LIqLvXrEalBQ
TSQKW5WWIt1rrwG+N2rsrqKB2pHHMkL8boFzSc6aMBijYHdCW36QQzAK2n/xbqu+
4OmIo+PgkoCzhWvVHE4K/GFkfaoS1lWslRV2Oz2bPe3om0ETVBBB82z0KUGJvwsa
S7srdS+S2fJPN5nAzy6wSsH7fpbMUzekh8jpdabB82WLPlkku26wbHeULJgd2FrX
a+aSqPftLAHS2Q01NWQLwP0iJ8aOPqhhCTwpxqSlsS8T9VeJElthGwmXqQnWI5C2
vp7SYzfn4rdRy5b8aj9W
=P0oJ
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--

--===============6137120239840359972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6137120239840359972==--
