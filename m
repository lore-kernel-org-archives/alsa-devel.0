From: Werner Van Belle <werner@yellowcouch.org>
Subject: Reported latency > buffersize and sometimes <0
Date: Wed, 18 May 2011 14:00:35 +0200
Message-ID: <4DD3B4E3.5090509@yellowcouch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6879505083329777759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id BC1BE243A5
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 14:03:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6879505083329777759==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig95101DD5C24C389460E4FBD8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95101DD5C24C389460E4FBD8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I recently started to check whether the new alsa drivers still work with
BpmDj (http://bpmdj.yellowcouch.org/). Thereby I encountered the problem
that the reported latency might be larger than the buffersize itself.

I guess this has to do with the asynchronity between asking the question
and retrieving the answer (e.g: a thread switch might come in between
and the actual latency is in that case bumped beyond the buffersize.. or
so .. Does this reasoning make sense ? Can I assume that such weird
values are indeed correct ?

Another problem I sometimes encounter is that the returned latency is
-1; a very annoying number since the stream was truly honoustly playing,
so how can the latency be so low then ?

With kind regards,

Werner,-

--=20
http://werner.yellowcouch.org/



--------------enig95101DD5C24C389460E4FBD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJN07TkAAoJEDQztpxTPuxVMP0P/2xFDrLxIZAj/DHRC1gPRVP9
vk7zGHP5aYWG245Wn6U+MIxcrbnBpStVN7xkXE4TagmylpjksLwNyei4PA/OsaI/
VRdI0mi36bPg9XtunZFh6a3B+fQ2n05I4ofz6fIatx7wyTpiHjBQaeXrwIgN5+4L
s6aHCbNgcDNybX0pFxossEjaI9mQMoTQYqWMY0zKFOIYovvy9En3VbGPZIQvUc70
lcwaImdQF4ObAAE86vimR6UZxK1AxyGLku/qtW3f1RLq5j/2qaU0eHtlJX7Y4vZJ
W4nKCbt8xaMQGOSO+LZ7eIMPx5jc//sqRTkHRgYIQ5gKmhK7SFt0+Ork8JU/C2V5
yz2OmrMtC4wJuf2JrZk24wPUGwukZw5PwHnppkQlFnDKBMMvX9v25czzud6w8Qzd
YXsfTONEnXDIqZEt1UwVGs4WyEJQ3e4EW3Sb/AcWadwkTsWDzmq7J1+aQAxuhLYT
vR28LYvGD5vh2s9kKgmTb77t0doXLIstAEPeMpegEN/iPde0y/P8b+Aprc+iTR76
L9HanQ56mXvWcPGeHNJEdsnVOWwF6oOQQI7Y8rKcS94PV9zqOY/H+ryTTvg8mYwx
EMNPyJGibgc7yaOxL+fStoLNWvvL9EH9euowGmgSSV9ZaQrXR2LF0dg6mgRYOF5c
gUUnlmaMv1MslV/o2p6s
=HWwg
-----END PGP SIGNATURE-----

--------------enig95101DD5C24C389460E4FBD8--

--===============6879505083329777759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6879505083329777759==--
