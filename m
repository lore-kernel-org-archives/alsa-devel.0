From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: locking looks odd
Date: Wed, 17 Aug 2016 21:41:38 +0900
Message-ID: <432ef155-10ed-5703-2ce8-84be8660829c@sakamocchi.jp>
References: <20160816210322.GD4466@var.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4890198690563156214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E689D266F97
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 14:41:52 +0200 (CEST)
In-Reply-To: <20160816210322.GD4466@var.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4890198690563156214==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nu61o2GFwADl4IrvPFfmnbOApNeiaDief"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nu61o2GFwADl4IrvPFfmnbOApNeiaDief
Content-Type: multipart/mixed; boundary="8F3GIV2COSSgOTUbnIlj7HaBxBgTPO0v6"
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 alsa-devel@alsa-project.org
Message-ID: <432ef155-10ed-5703-2ce8-84be8660829c@sakamocchi.jp>
Subject: Re: locking looks odd
References: <20160816210322.GD4466@var.home>
In-Reply-To: <20160816210322.GD4466@var.home>

--8F3GIV2COSSgOTUbnIlj7HaBxBgTPO0v6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On Aug 17 2016 06:03, Samuel Thibault wrote:
> Hello,
>=20
> We are having odd issues with libasound 1.1.2 which we didn't have with=

> libasound 1.1.1, more precisely
>=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D833950
>=20
> so I'm having a look at the locking API introduced in 1.1.2, and there
> are some oddities:
>=20
> - snd_pcm_new seems to initialize pcm->thread_safe to 0 by default, thi=
s
>   does not seem safe. The attached patch initializes it to 1, which
>   fixes the bug in our tests.
>=20
> - snd_pcm_hw_open_fd forces it to 1, thus ignoring what snd_pcm_new set=
=2E
>=20
> - one can find both __snd_pcm_lock and snd_pcm_lock functions, what is
>   the expected difference between them?
>=20
> - __snd_pcm_lock takes locks when thread_safe >=3D 0, while snd_pcm_loc=
k
>   takes locks when thread_safe =3D=3D 0, this looks really odd.
>=20
> - libasound could just not link against libpthread,
>   pthread_mutex_lock/unlock are already provided as empty stubs by libc=
,
>   the overhead will thus only be hit when the application links against=

>   libpthread (libasound will then properly use pthread locks).

Thanks for this information. Unfortunately, committer of this
modification (a subsystem maintainer) has a summer vacation, so it's
delayed for you to get replies for to questions.

In my opinion, the second item you addressed to is a bug of this commit,
to introduce the environment variable.

pcm: Add LIBASOUND_THREAD_SAFE env variable check
http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dcommitdiff;h=3Dc4b69027=
8eeaf9a6805f67f6709e4aa33e58773a;hp=3D7a8a1d155267fb6e21ddaa0787d121ec47a=
15bf2

I don't know exactly the others. Anyway, I'll continue to investigate
these issues and cooperate to solve them.


Thanks

Takashi Sakamoto


--8F3GIV2COSSgOTUbnIlj7HaBxBgTPO0v6--

--Nu61o2GFwADl4IrvPFfmnbOApNeiaDief
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXtFuKAAoJELWlhsfWb9NBfXYQAMRpn9rKjfLtjYv+ju6aYzkr
J3AsR43I60eqmHUrTK0S+Z/LDTD4IKpGbIscJ2T0zBmp8soFp2yQ3Q59anrBkbWL
lFZrEanI433HgZafzAqC8emLFgSMlycblozMvuWNqI5Qt9EJwGbRhvz54Nke4BNB
H+IjgdJUnxPypNSPlYvUiLUbsdWyOwC2qmY+fK/B0kvcK1zlF4/W7zIXk7RD44tU
5dUasgSdaTq7ynOsLdBJ/pAxsnUC3nVwXHjizZlSXkIhIVofXdIgUkJ4PPwuk+I9
9saa+DagKurxQdoXsXxGIj+Gbs1QxePXqOr/hoCOqA6W0acsyMMJgdyMYG070b4D
jTYnmOjGTofTenq2Sh044iz3avCJxNBY+Q1LH3eUDH3tBDeyP2iwNodzQWs/6Au4
xgklzmB+csnDJAHh79c4Qg7Gma1z/Qvk0Qk7leGMoa/7CIxjFUepQFFWjTc5sZj5
nP2JlGuos5M0qGZ0SDZzrqpkC71vvDSeE9+jcDysTDqxFUnQ/sapZ5AVdcwUaNSF
mYgJRN/lzK9HYIFyqYUcY1yZpaongwXFWprI5Tkdq97yauB7mghrCgYNivWwsSS/
5uVagrk8oGAoxmcUzKp9Sy+ZsMHSwWbTe3WGoGdJf1/0QMT7QA61E16HqVekg4VN
uwL8XzKBoNLcpxEJ/tkC
=Ns8F
-----END PGP SIGNATURE-----

--Nu61o2GFwADl4IrvPFfmnbOApNeiaDief--

--===============4890198690563156214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4890198690563156214==--
