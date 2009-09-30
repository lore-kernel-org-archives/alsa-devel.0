From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] sound: Don't assume i2c device probing
	always succeeds
Date: Wed, 30 Sep 2009 17:05:11 +0200
Message-ID: <1254323111.3959.6.camel@johannes.local>
References: <20090930152542.3ef753ee@hyperion.delvare>
	<s5hbpksy0yq.wl%tiwai@suse.de>
	<20090930170006.76e145ca@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4071135802805611429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id AF746243E5
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 17:05:22 +0200 (CEST)
In-Reply-To: <20090930170006.76e145ca@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Tim Shepard <shep@alum.mit.edu>
List-Id: alsa-devel@alsa-project.org


--===============4071135802805611429==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9nANDWYa+cju1uLBmJ/R"


--=-9nANDWYa+cju1uLBmJ/R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-09-30 at 17:00 +0200, Jean Delvare wrote:

> The NULL check of client->driver, if followed by a call to
> i2c_unregister_device(), would indeed be enough. But unlike the onyx
> driver which we know we sometimes load erroneously, the other drivers
> should never fail.

All of these drivers can be loaded manually and then fail though, or am
I misunderstanding something?

johannes

--=-9nANDWYa+cju1uLBmJ/R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKw3OjAAoJEODzc/N7+QmamFMQAIK1ekBv4Oe7SMJtvy2ak7aS
DN/+VauZYbxThtspvdWxHLhgd/y2iF+tjfyGJ5FYRFyA+mnZyOUislCQ2YJEH4Sn
B84b6QVdi/ImxdujtzLlv1Kg1nr8y9QlLcgLkbQ2F/VXFTjmSkqVzlUp1WoMtgQN
Pg3PWzPH+brgTkLbTMiz0DGIxt6LnhJ3H7JP6FfNFL2KISyfQD8ci5Zd0K9I5JHb
Jvp2STrgEH5lvI0wq+aiIwQfme+9WCybLPFRhDuNFg0yCk3OwlPI51er6mFcV9Ml
s8TwAQD5Z/4x+i30uu3oXixsvIvul48Yw1Pbafd5AQYFLAGiYLOIygjSyy98pxmh
/hKmaDmtgDMXtCTrRSLFBArSDJyUuuQZ5XcOPW/zzHjGBcslt5ITyaCIlgfBoFyd
6i6dtGhryV/KC0Iyol55WXG6v3M8imkb8x0s6jVTG05HTq/+vXnZg7Pgkf40RGle
OGppvKTzHAo1BSj3ux0kXH1V8D29f0tVOIOg4NnTy//gl1XAv29cDxVK8Zfhik/u
XYspooLVktwRoHAnOA5Lj1h6bCG6p83MJjRXZehRRPowzi9i307Qd2TMuxvzm2LE
ioU+jcR7FJLISAO68S3NMqXKqtry3VN+76WeKTo9Sz/GOf0UaoNnPRMP5h90RRfG
6zj41PIWvLhj5vvD/LHQ
=9htZ
-----END PGP SIGNATURE-----

--=-9nANDWYa+cju1uLBmJ/R--


--===============4071135802805611429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4071135802805611429==--
