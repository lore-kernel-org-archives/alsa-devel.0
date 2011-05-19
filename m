From: Werner Van Belle <werner@yellowcouch.org>
Subject: Is the latency call thread safe ?
Date: Thu, 19 May 2011 15:28:53 +0200
Message-ID: <4DD51B15.60505@yellowcouch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7412450771189983375=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id BA27110384B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 15:31:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7412450771189983375==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD26792171F745506ED1433B3"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD26792171F745506ED1433B3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

Can anybody chime in and tell me whether the latency call for a dsp
device is thread safe  or not? If not, what would be the possible
outcome due to race conditions ?

wkr,

--=20
http://werner.yellowcouch.org/



--------------enigD26792171F745506ED1433B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJN1RsbAAoJEDQztpxTPuxV5L8P/jVz+lJV3gs8TDEdcNvY9y/k
91O//aodJKXfuF1wP0jYRrckR+xaiRUAP/AlSJ25HXzYedGFJpKqLu0alSLQvwA+
1KTVa5myaBkL45vZH9/l7zV51B/pOKZYgkw3g9ns6vCj9TL2Kd9U1xXtOpL51vtF
sHZwNQX11Sk5KsSDvIiLL5JgmzKcCn+bPz1jIM7get9HZ+uXWVKwvxEEVOh9LeXu
SNaHPM8jmAGa6lhNyN7GB5xVc5l+s9lkq49+dSywI0D3vIckR1oTv6EYe4+a5BGD
GWAvW5YGEEnznTt3WNf6S27w9rZU/FJm4p4byegl2W+QJNAUamWm73LyKD96ol8a
EVYpoWtK0uuHFsstytduKMqXjAMsXRE+5tS7dBOpCQimukT+SAwXEj+msnzDo8Jn
fM2gQeflr7ekT7ZRCQj1AmxBMUG2PDtUr2JwUSd4lRCGL6CnpY0KqGZ1zE8Ta8/C
iguJnZ7NkPMzJLYBt2fg2NC5l7cBTjvQpHx7rpfzOTzUA/4y3Mj7GOqdK3rrsQGd
FOS5WBLX6662P5KoH+/P7uRn8/zZdO28n7EsFxJ/wS5iQvtb+kfUl0wzECeyfxer
+so7gzew8dLmP0CwxMoMrZK0rWAhZFN3Dg4lGHNFXm1YdotWUhvi9x3XAdhpjyiu
+4V67Moc1Dq8cE99r7Xt
=d+bz
-----END PGP SIGNATURE-----

--------------enigD26792171F745506ED1433B3--

--===============7412450771189983375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7412450771189983375==--
