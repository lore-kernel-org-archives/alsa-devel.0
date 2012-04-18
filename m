From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] configure.in: look for ncurses pkg-config
	first
Date: Wed, 18 Apr 2012 12:23:21 -0400
Message-ID: <201204181223.22077.vapier@gentoo.org>
References: <1334759154-22302-1-git-send-email-vapier@gentoo.org>
	<s5hty0h6ml1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1940553020942696434=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id CA07E10441B
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 18:22:34 +0200 (CEST)
In-Reply-To: <s5hty0h6ml1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1940553020942696434==
Content-Type: multipart/signed;
  boundary="nextPart1499719.m57PuNZWZA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1499719.m57PuNZWZA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 April 2012 12:17:46 Takashi Iwai wrote:
> At Wed, 18 Apr 2012 10:25:54 -0400, Mike Frysinger wrote:
> > Newer ncurses installs pkg-config files, and these are much easier
> > to manage when cross-compiling, so default to searching for those.
> > If they can't be found, we fall back to the existing xxx-config.
>=20
> Thanke, applied now.
>=20
> BTW, at the next time, it'd be helpful ir you put something indicating
> it's for alsa-utils.

sorry, i always forget multiple projects (kernel & user) use the same list
=2Dmike

--nextPart1499719.m57PuNZWZA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPjup6AAoJEEFjO5/oN/WBUvIP/RfFEgrTl1sI/dNC2RtaqKqv
viQorhJLcjXwXCn4JlO3FB9plGK48PqGf4B9G+LdUEkL/xSBo137qypXlqA46qfE
BMUV1ro0BHuWl2FPxahpgnlc0DSNlU8zijAEHw9u85VADs65+wFftr0btPrrN9iK
L3uvozLhB6c95LfEmhkgTvNh6KetGdrgeRFj9M06pNHS2lZFziieXjPTkDxt78m8
8KxC33gWmaam8gnluGVz4mDCj/jScNXjwzMbBmRvQSVuOGBeIyrJpfiUKjrz3knz
UUFbwDo4aUyoc7bnfYQf3sNoVv8NMW6V/9wUYRRPeRIJwr5hieE79FoJIlua3OTo
KY1mTAo7bnGnX7JfuBYg6L6iYGRsgmEFVO2VHu1BnIoO6wBZ2nOkvDmvdk532IKA
r6yVzebzm7XG50ZAhMewAd2sXj3ZlMe+TCDDyy45nHxnWVmuGw6IaffHiFfz3jlf
tNtqzpVaOUFywlNJaEY01h0xUl3CknA6pQTSRqcrP7Cjzhifh76zmdLZ3NA0hKag
J4v3lUzGTssgCeav4yscwtM7QJj4v5h+ZE2KDHhfqoy4Qmy/p2ILduiPY1Z8NNSq
ii5W6AJfEjBc4b5SNrG94VNUj6jrDB+Ball7CJcSsytHmcWh1AWzJKjRSEmyDwSE
K2tife6zhMGf8R7MRvsW
=wai5
-----END PGP SIGNATURE-----

--nextPart1499719.m57PuNZWZA--

--===============1940553020942696434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1940553020942696434==--
