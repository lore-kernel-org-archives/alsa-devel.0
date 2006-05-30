From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: handling rate change on digital inputs?
Date: Tue, 30 May 2006 16:11:23 +0200
Message-ID: <1148998283.4372.18.camel@johannes>
References: <1148997314.4372.16.camel@johannes>
	<Pine.LNX.4.61.0605301559330.9178@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0364737646=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F37714E
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 16:11:38 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605301559330.9178@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0364737646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XQAwp9jmNj7159pXsTbu"


--=-XQAwp9jmNj7159pXsTbu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-30 at 16:07 +0200, Jaroslav Kysela wrote:

> Yes, the stream must go to the DRAINING state immediately when rate (or=20
> other parameter) does not match (it's good to check this condition in the=
=20
> interrupt handler) and trigger() callback must return -EIO in this case=20
> when stream is requested to come up (START, PAUSE_RELEASE or RESUME).

Do you know if there's any sample code for this somewhere? Or if any
drivers implement this properly?

johannes

--=-XQAwp9jmNj7159pXsTbu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHxSiKVg1VMiehFYAQJYxw//dlhm6XXFh3bXsRcJXf98U+FfV7quiWoK
rS3xXDQEt0j5O6rgYYvH56WIEI/8xO02zA7+HFhakX3LXgMmc2BsD1lHLxYBGAg3
GUBb3sK6wOPWSiG7o0BeeC5W1FywDroa4gIJXDr1eFuVjVkVKLBlj19GIj1jAFby
8diNeVVpWeCiyD7gs6Rw9pWgK433K9fqK413w82mLvI2jQ0P2N9l5MNVIkmnmPwx
+y8kgHq4jGDN8MhEpkcb7iGstWs63E5VdVLgrqC9X4MWvNKygt6zuZ5/Metrhh7f
LUZIXaprzQBqOg85OoqpxtqzQRpOXZUd0ifbt2hkSI59sbWBeiIF9PlmCEaQ3mWj
ossThh2VqhcMALlcfO6NKoEMvRyTykgz68MArDiY75JZc9hG3sl+5dZc9DUvvBkG
98nVmBr2a5y4tWr32IvO44U5qjvZ/yqSoSjLuDmNAF0fZYBeQb/QFLBZz+06UbTi
YPED03Gd4QyOLTaVrNaYy2PmHQUCKcWm7ZzDqoAkg95fYU6hiR/nIoxTZIP3tKkO
9zVR08SFW9u+aXq5CK1YTamuRD0e25dFXEFvT6Wr2pGPc8HiDlhJe6inBOjT6Sw3
KlTIzFf6ej3ZwUkYY2MqO5Z3r3xhE1FsLH4UQ+wbvw3gRZS48xFh5QEw8m4X3M5e
E8VebKQhiMM=
=ucJS
-----END PGP SIGNATURE-----

--=-XQAwp9jmNj7159pXsTbu--



--===============0364737646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0364737646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0364737646==--
