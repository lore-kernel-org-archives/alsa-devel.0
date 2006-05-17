From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 14:39:37 +0200
Message-ID: <1147869577.15507.17.camel@johannes>
References: <1147780945.29795.110.camel@johannes>
	 <s5h7j4m40kf.wl%tiwai@suse.de>
	 <1147817023.6753.5.camel@localhost.localdomain>
	 <s5hy7x10y5t.wl%tiwai@suse.de> <1147868218.15507.4.camel@johannes>
	 <s5hd5ec4yn7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0mzGBs7DpD3dLdh7VguY"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF66419C
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 14:39:43 +0200 (MEST)
In-Reply-To: <s5hd5ec4yn7.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--=-0mzGBs7DpD3dLdh7VguY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 14:35 +0200, Takashi Iwai wrote:

> The question is where to implement a huge table or a complex
> conversion function -- whether in the driver or in alsa-lib.

Well if it was in the alsa-lib I could just give it a formula that
contains an exponential and some constants, and that's all it needs. But
in the kernel it has to be a lookup table since I can't do floating
point math easily.

johannes

--=-0mzGBs7DpD3dLdh7VguY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsZh6Vg1VMiehFYAQL9BxAAxGXCzbkZ8T5EThYGDaATmQjCBdsiCGY3
roI8CkeiKJVoPcjhubLoUbNQRLtSZ03/JWkZnZMbM7U8IpnJT/cMzp0HoQwgXI5Y
nf13RH1sYgtMnsHQXjhpirBYRpCLP6S/3GyLJ/t0UCuV0ZtLfFVwFDr7zZ9jHG6b
Gl/Y52HD8gQa3RHjblGxJkULAmdM1S9xHeH5ibKaOxFU2zOCRreuyb2CEGl1FDJw
AUHPqL3TbqVgPT+P4tPlMQm6ikfGUXpNnYk219aYA5H9czJsSlJFcI08ccRN8KOW
PvbSqDk1Y3fuxUPaY+345z3IezS3q3dfSFSnzC0EbYyYsXu8jwPWtB7Zmxv5wT0K
ARSGOmeZf3XcwYOcPTd0hxukgIs8R5m1W7Wa9Z1U3V5d0yxMxpftc+oazM6birVa
5UjZQELdIpySDzZo/4ND7eQxjv25X7SBNQisBfS+2Vwv6sMmlfB7U0LWQe82WkBR
gbS1UCJJZL2Owxay3/7LgzIVc6dDLQty3dOWeF8jBsHnMhlNN1HlAph7Q4j07i9W
UUSCGz9k2zQkZFygVDvPI2cTHexNUXl7RhwYki0qKhGISRDRJ7r2V66ssKPf7wRz
v9IY/Y8lRMzlotMcS+wq83DgJjJUOS2tdh2dXwIgwgCggQziqCp0hvxZEB/n+2MB
SP/G1w/cWSI=
=v+pD
-----END PGP SIGNATURE-----

--=-0mzGBs7DpD3dLdh7VguY--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
