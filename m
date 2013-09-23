From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: How to deal with snooping in firmware?
Date: Mon, 23 Sep 2013 18:37:35 +0200
Message-ID: <1379954255.13736.47.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8320156517297753987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 424F12610B3
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 18:37:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Siyuan Wang <wangsiyuanbuaa@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8320156517297753987==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-XNeYvK7JpIk55sZsvdqU"


--=-XNeYvK7JpIk55sZsvdqU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear ALSA folks,


with Ubuntu 13.04 and AMD Kabini boards, there are audio distortions,
which are not present under Microsoft Windows [1][2]. Disabling snooping
fixes this, which is in line with the information from an earlier
discussion [3].

As it works under Microsoft Windows, is this indeed a driver problem and
should be fixed there? Is it better to disabling snooping by default in
the firmware and let the driver enable it? What do you propose how to
fix this?


Thanks,

Paul


[1] http://review.coreboot.org/#/c/3934/
[2] http://review.coreboot.org/#/c/3934/1/src/mainboard/amd/olivehill/get_b=
us_conf.c
[3] http://lists.freedesktop.org/archives/pulseaudio-discuss/2012-May/01356=
8.html
    [pulseaudio-discuss] [alsa-devel] Adjust volume may cause audio playbac=
k corruption


--=-XNeYvK7JpIk55sZsvdqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iEYEABECAAYFAlJAbk8ACgkQPX1aK2wOHVgMIwCfVXHk3tOs2RsSDQRhReyNhmHy
c3wAnjoGpbQ7iOkxJCrP10o50+Eb9G6O
=PQF7
-----END PGP SIGNATURE-----

--=-XNeYvK7JpIk55sZsvdqU--


--===============8320156517297753987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8320156517297753987==--
