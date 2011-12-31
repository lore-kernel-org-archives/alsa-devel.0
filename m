From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 3/6] ASoC: blackfin: Add .owner to struct
	snd_soc_card
Date: Sat, 31 Dec 2011 01:33:24 -0500
Message-ID: <201112310133.26362.vapier@gentoo.org>
References: <1324559698.10821.2.camel@phoenix>
	<1324559842.10821.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4231061217526403206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A7B124366
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 07:33:22 +0100 (CET)
In-Reply-To: <1324559842.10821.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lothar@alsa-project.org, Liam Girdwood <lrg@ti.com>, =?iso-8859-1?q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: alsa-devel@alsa-project.org

--===============4231061217526403206==
Content-Type: multipart/signed;
  boundary="nextPart4278099.QGhimid1n5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4278099.QGhimid1n5
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 22 December 2011 08:17:22 Axel Lin wrote:
> Missed .owner of struct snd_soc_card will prevent the module from being
> removed from underneath its users.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart4278099.QGhimid1n5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO/qy2AAoJEEFjO5/oN/WBqLIQAOWlq6AybaEJJxhSKmmb/HlL
6A4FSjv8Wh3sCe7+D0cOMf/0oWe/XmfOcnAztTlnmw569rzIrDPlScRIHBVyh13F
rZyu2bivDx8PduE6VUyoz82diY1MC09040s9pzdc8W6IjoqzVo6lM0c6wmwSxNv4
swHx4chhPTu1qhknzrRFL0G6bxPAB5IcwBrKa1tadU2DnO8s6ZzBKiUD2YVq0sXt
IpAsPyX5Dx3JpNA9fMjV0a40X6s/4vtrlpOy3qQTTZDK6BBsg5nbQv7EyTMarJ89
jYkcz+CZtNJ99RNzCsZADaDwEVDSUWbLZP/XPGNKLQAzYuKz1NgLeqzKOQJcPk+x
G9q8Ss/yJIEjuXOe/iGNkWeXCJK3vVi830s7Vz8lJUKpqg6N34PdONKCXuBR221M
kS4JFxxuBA9nSuC7PDGKzZBTmNbbwVeOoSvaar3qiCdbfLElIAFMMOa1KkE8bUVR
BexgxuC6QDFoesr8vJqjJc5dzNXN3Ee/7XdwicEXhnQKQJEwOiG/wUZ3JoIYVOgK
zlddEaaeyJPoeU7UaNevOaoT3XFzt1rLTSJVaI3gar/h7OVRCC+1STB6Xj/OzE+l
1ZEv5YsoB26247FoCvoJA+SApZuT4PjsksE58iz/DUF8KkU0ZoE9OWWbGKtQOPxC
arbumP5k9fnsTZXy5KAK
=rhVl
-----END PGP SIGNATURE-----

--nextPart4278099.QGhimid1n5--

--===============4231061217526403206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4231061217526403206==--
