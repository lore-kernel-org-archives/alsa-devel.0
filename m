From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Thu, 26 Apr 2012 18:20:10 +0100
Message-ID: <20120426172010.GP3207@opensource.wolfsonmicro.com>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8497331967879153415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2524A10BBB2
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 19:20:13 +0200 (CEST)
In-Reply-To: <1335448142.20000.40.camel@mars>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8497331967879153415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QAdlk5ze2izLk3Ap"
Content-Disposition: inline


--QAdlk5ze2izLk3Ap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2012 at 03:49:02PM +0200, Christoph Fritz wrote:

> I added some printks into ac97_write() "sound/soc/codecs/wm9712.c" and
> when I do for example change "Item: Mic Boost [dB gain: 20.00] " I get
> this:

>  write  eh 8000  [6808]
>  write  eh 8000  [6888]

> but when I try to change "Mic Select Source" or "Item: Differential
> Source", nothing happens here.

Odd.  Can you see the write actually happening on the bus?

> Why is wm9712_enum[0] never used?

I rather imagine it's just a simple case of the feature having being
missed when the driver was implemented.

> Is "SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel)," correct? Because of
> the ">> 1" shift in ac97_write() ?

What makes you think it might not be correct?

--QAdlk5ze2izLk3Ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmYPCAAoJEBus8iNuMP3d06QP/2vBQrzvQMNej3qLwHz2vuAZ
msR1sIn5LhK5steNGB8HgZ0aTfb1HgXHP/Kol1JgIXEkuZiY0shwntjxPEY8yYf5
Ibs+eznGYV4YN+XUlJyfSK/GGpRKZKqYk2SgoBNaGuSTS8wQsfCplJjWq51vMqrS
ZzpBliwolsh3nLr6NBjPx+fr072lVlKTUVUBbXOPVuHV06adu5J6YfhW+SOUr1In
XH/Yo3egoLq3NrUQ+1cQ4+8HUsU9iG1ejMgMqo0lP4N6tER4aCrjNv4OY4JiSxfW
hshaT/BFCwI5G4ZF2OSVhPZqLeruoznVNzuCppZEyRA6BfKeTCN0InoMUxFQZcxX
GSEWjt+f3QCZ8AelR/h96VnUQHFDFazsTcEueqrE6gaQIH2BKHQwQspQOkqh14rR
enOeJyCc5Pa/x67iZ25c2uzrwqchzt6n+OUkncROGWoy9StF7bxPOCydgDKn/Fui
dQtIu/xIjkrL5GNh0/Yi8VgzgAMmSfemMmmLl4V9aHLy/UCIqNv9nxZjqyvJI7IE
2fbDc0KRq09h2/0SnV2KSSZAyY6qNRSeM0qtyqUibYkA5Obu+y98Ail68I+oKssr
Aapp2nBUwk7Ly/ebFSixSQKeRKRJzz64olt0SlD77+CtuVC07qq+RT1+M3dSzgSi
Lg0wT6HR1fUTlOCZuXB3
=Bz8J
-----END PGP SIGNATURE-----

--QAdlk5ze2izLk3Ap--

--===============8497331967879153415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8497331967879153415==--
