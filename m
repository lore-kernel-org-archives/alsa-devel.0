From: Johannes Berg <johannes@sipsolutions.net>
Subject: handling rate change on digital inputs?
Date: Tue, 30 May 2006 15:55:09 +0200
Message-ID: <1148997314.4372.16.camel@johannes>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773059434=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 989CA142
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 15:55:26 +0200 (MEST)
Received: from [131.234.78.28] (helo=dhcp-78-28.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.62) (envelope-from <johannes@sipsolutions.net>)
	id 1Fl4gw-0007hM-8b
	for alsa-devel@alsa-project.org; Tue, 30 May 2006 14:55:26 +0100
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0773059434==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-M6io9zv8BtVcJ6jSXdb8"


--=-M6io9zv8BtVcJ6jSXdb8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

While thinking about how I can support the optical input on Apple
machines, I came to the following question:

What should I do if, while some app is recording, the input rate on the
digital connector changes?
If it changes before the app starts recording, I can tell the app
during .open what rate I have, but while it is recording? Can I (and
should I) kick out the application?

johannes

--=-M6io9zv8BtVcJ6jSXdb8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHxOuqVg1VMiehFYAQKoQw//XmWtkTYoi1Zx3qS2XJyTRyfTt7KZSW5W
208hKfYtNXzE94sGr3Ffi2VsMdcqs4cdzY2mZryuITM/etQeTtPI1d61/5s9GlIQ
DIJ44K0dEVAL4K8cVcLMBpqMjjo44o3gT15w+VQ2sp8PyrGhNtPvzEP2/Qgp0iHS
O0OkJpeyQfSWCS4pCOUPb70Zz8aAueJfC+zO12ekJDgW5UsxmCOS31Rmo2XcP7F1
erhOj8udJbx8XbfL1PLFoNUhKXEpvJTgjX/Mbo+uDp07XBSW3QWNe0uArz9SeZ/c
ca0MVWaidixN9AlYMqfiBIc9CT6RCgs5oXzG+nzKCibS/HpxEn+OPKRvJQEI2gn7
S8G87AWciu98fIQl7H59rCzaFQr2W8kjp+Tnln3lp3wZY2HfEqVUKTp0qkDg4Wk1
D+pwLMzrfaHuKJYMG4gXyxuxwZf0qQL2iXwwz5L1WJixo4Nc5jDooZoZkKehuDQo
5/79Sv+SDowOumskxUTUhBTNiJGWJqNAIZgBqcVsPRb3e6PltbuFSyaWaEYkQoKH
+fDLZHHC167N8EKW+X78e0JVsP8Q3C3Lnwnsag+aDQWF5YjfKVHuzNUzvI5zAmAK
qfU6WD7A2lkUdIR4uumbErYW2Oe9NU7KXGXpUJyO2XT3FyJSgwF5VPUd6EA56QPI
eKCeckeEdpo=
=qGUV
-----END PGP SIGNATURE-----

--=-M6io9zv8BtVcJ6jSXdb8--



--===============0773059434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0773059434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0773059434==--
