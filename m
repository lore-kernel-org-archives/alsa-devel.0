From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sat, 31 Aug 2013 18:28:53 +0100
Message-ID: <20130831172853.GL18608@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3430543532961464733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A6EEB261AEB
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 19:29:14 +0200 (CEST)
In-Reply-To: <52220B9A.9000007@metafoo.de>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3430543532961464733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:

> Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
> widgets to the I2S streams. In your machine driver setup the link config to
> use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
> framework will then create the necessary routes all by itself. Of course
> this won't work on a platform where both the SPDIF and I2S controller are
> used at the same time, but neither does your current solution.

This is the either/or approach I've been suggesting.

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIifSAAoJELSic+t+oim9ybkP/0k88ZaDg6Ooogxr+q7Hnn/t
jG21Ses0zlX/bMNaXNHMlFXKiZa48fFuwB8X4KeR0ai84tpr6yhWEItjgUVJbG6l
a0l26+AzGUOTk25y+oMp3HegLcDyLrCzuU2nY52Vv+w6QPrK3vOoWWxgMOCdKd6M
UW5qMjmcN6TUvfJ6YRBi0uJtHBQCbaG1F7Bo9gn/BODh8CJQ/oedHCCrMQGUEskm
evQLX07wg/B7k4PISfRNSbqFefMtayMH6uMAjzQjcK3ZlFWygJCbZ1mzoWQX7KjY
UPjT1X+Hv4YnA4w1Ty41bi7c7fY8PfsV2s5hhpb4SxHf6oAY7R2hK3chMrmHPLqQ
T7U0+LL7gDq/An+E/MejfAS5dbpECEKeSciNwNyVqbmpf28NgGWKX5vSQrQvtKR2
U96atNSrqac8Zz0mTqS9gWtLUVY+36tGq99ItmDG+M1uk5/hGEvkoMWnEgadeeFX
YCgFj13yLnt5QBcPqScCVIphhs0wA46u1f/3pigK7g5TDCFUouDjCELBtPsHX7WO
JzU7hIhDyVSxiscMZx089JLOwbt2Uis0AvXzqpn0qEooqeK2whHBO4xNV3xGFWpI
ylurxUSmX/K2ttivYmechPMxw1zUoOQODKXUALLMexdKBNMf72Y9lfD5jnIVvevQ
GbTHh8Zm3S75sEd9zgYc
=ZzN5
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--

--===============3430543532961464733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3430543532961464733==--
