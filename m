From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Support new HDA codec
Date: Sat, 25 Feb 2012 11:50:48 +0000
Message-ID: <20120225115048.GD3167@opensource.wolfsonmicro.com>
References: <AB277FB27524F74C87ACAFF84F2767490D5205C4E2@NTMBOX.central.cirsa.com>
	<s5hehtkxma6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1909503210756051661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB4B824462
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 12:50:51 +0100 (CET)
In-Reply-To: <s5hehtkxma6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
List-Id: alsa-devel@alsa-project.org


--===============1909503210756051661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 04:51:13PM +0100, Takashi Iwai wrote:

> That being said, if nothing special is needed, the support of this
> codec wouldn't be too difficult, I suppose.  But, sometimes codecs
> need special vendor-specific verbs, and we can't know without the help
> of vendors.

It should be very standards confirming and not require any magic Wolfson
specific verbs to use the functionality, a generic HDA driver should do
fine with an appropriate setup from the BIOS.

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPSMsRAAoJEBus8iNuMP3dTwcP/RUu5RioKr6EfGiPWhMJd6t7
cpO2OIUUT8d1/jpO1MUqutFFdqzG5/Kgo5MLeorJv9O9HA3094a64Wa0PIxotAMP
p2yNdi6F1fLFM5+PM9cQ9Vyczzxam8fhY7W7uBUAvCu5/Kd21yBfTWenoyMlkVLa
cownej09WPwBo6ST0qZholzkkTX6+ItHzBXDX2SGdAkf+uOfkNJAko01km+HfL9j
GI/Jmh2opz21Klfc3pOCddrkxhZCnvNqeZfMQYbxFlW/YiTx4ojWLleA7KZPElG0
hcoO6t6evWjUIb0j1XkmRYFjxpNdQ/Ga5SA7iHTtcv5iCzmOCzYBi+xHTq4YECBM
RtjuOW25D9MSvBWrF4gpP4kXQiS8mG3AvMJ1sLYzvPNY0p17GJz9IzuT5G6XeKdB
LJwULJdsBN0EwwcmWj9/U4l0L63sXKJW9R5gtLUYU0DWb1qlFzHfVc8r+p41wXcq
iXa29YVM4A0ELt372sZx9v2rQnM2C7lyQJ0VUu1Lo8pbt8sPXa+I69ciRR6WfaYh
+u5jNrGI0HnqPRmB07hdErcdoiQ4hkKMXtvNpugoof/z5pueCF2RwXIjnUf8NbWa
buGgRy9gRGkBF+aKSeiaH4O/jlLXDfV9DYkR7Nppq/Ywp2F8sKONgP5JPRAd6wG3
ZynQUyefTfyyZP6fkNVT
=H8ha
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

--===============1909503210756051661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1909503210756051661==--
