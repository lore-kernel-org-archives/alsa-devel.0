From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel on macbook5,
	1 (was: lockdep warning on	2.6.29-rc1	with	pulseaudio)
Date: Wed, 14 Jan 2009 17:18:50 +0100
Message-ID: <1231949930.3789.1.camel@johannes>
References: <1231866121.3847.6.camel@johannes>
	<s5hiqoj870o.wl%tiwai@suse.de> <1231868779.3840.11.camel@johannes>
	<s5hk58yfko5.wl%tiwai@suse.de> <1231928348.3730.7.camel@johannes>
	<s5h4p0288sb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5359745026321198291=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E2A0103827
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 17:19:13 +0100 (CET)
In-Reply-To: <s5h4p0288sb.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5359745026321198291==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jc4dezeOpT+8/vT4e98H"


--=-Jc4dezeOpT+8/vT4e98H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-14 at 11:46 +0100, Takashi Iwai wrote:

> You can try GPIO setup via hda-verb program.
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/misc/hda-verb-0.3.tar=
.gz
>=20
> For example,
> 	hda-verb /dev/snd/hwC0D0 1 SET_GPIO_MASK 3
> 	hda-verb /dev/snd/hwC0D0 1 SET_GPIO_DIR 3
> 	hda-verb /dev/snd/hwC0D0 1 SET_GPIO_DATA 3
> will set GPIO#0 and #1 to 1.
>=20
> Try the above first without model option.

No luck.

> BTW, looking at your alsa-info output, all volumes are quite low.
> Try to raise more.

I played with the volumes before, didn't help. Should I try to look into
the Apple driver binary?

johannes

--=-Jc4dezeOpT+8/vT4e98H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJbhBmAAoJEKVg1VMiehFYoT0P/2sgSCA1Xcq4S9Tv1FTpMFQE
j8aOx6pnaKrn4ctqBbxV6YyYAFIHU7dbvGQS7SkINKYX9pGC7PwhbIZR9Tj2HxhM
s9yBTkO/TqgVqgtTvZxRaimRxfxna977vSsPzgqgq2ShSw5vI5uXoSPm1nlb7cqy
eM2knRG0niGWOE5RFCHO5wj6NSGIJ3S20dEv4GWfs7nFIfy0IBQQhjI9sBnByVJY
2iF3xr5o0vgtq/frPRujxsb6UL4jRsosWuxO2kjkhKX2ya1WnRX7hUN+h2QDahYl
XbMl5ghSYd2TA3m5XwqAOGTgLruY065rQiDq29jFkT3AQS/EsNgXa5TqxYFjOf0h
NBPHicDMKPnfBxb8Vn4fDhML3Lvurgtt7EukGsZhH31TjBvbdyz6l0/VNMBaHbEm
qN3NMNC2yJD+oouXGrm/D4ny+X7vX6H3DbeA0PY65bqJFliysWrbu62FR+BiqzOg
QYBtt8dcy8ixH9cct68w1nbPIPuvCwwp2Q5TE5CO6pHU84HYxE0ZOz8Gi1jCu5ww
6l8xLFMLtrg2+R6nbFxhxQiASQmgLOvPXS4UpG7fSVp2gTyiYj9LFy00Psqi6VKa
0RXPMNY4NWa4TFU2OONFFiPn7ndB0Y5sqCL8w5gEtpGPTnOcg34T3XGNCZM1BjLZ
PYhs3gL/NlixNpt78x70
=GGoQ
-----END PGP SIGNATURE-----

--=-Jc4dezeOpT+8/vT4e98H--


--===============5359745026321198291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5359745026321198291==--
