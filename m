From: Eric Anholt <eric@anholt.net>
Subject: Re: [RESEND PATCH] conf/cards: add VC4-HDMI card
Date: Thu, 06 Apr 2017 12:46:29 -0700
Message-ID: <87lgrd48ve.fsf@eliezer.anholt.net>
References: <1488451773-22010-1-git-send-email-boris.brezillon@free-electrons.com>
 <s5hinn4w6l8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2728027497245942005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 28B4B266961
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 21:46:34 +0200 (CEST)
In-Reply-To: <s5hinn4w6l8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============2728027497245942005==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Takashi Iwai <tiwai@suse.de> writes:

> On Thu, 02 Mar 2017 11:49:33 +0100,
> Boris Brezillon wrote:
>>=20
>> Add a conf file for the VC4-HDMI sound card.
>>=20
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> ---
>> Hi,
>>=20
>> Sorry for the noise, but I didn't send this patch to the alsa-lib
>> maintainer on my first attempt.
>>=20
>> This patch is adding a card config file for the audio sound card whose
>> driver has been submitted here [1] (not accepted yet).
>>=20
>> Since I am a total newbie to the alsa world, I'd like to get some
>> feedback on this patch.
>>=20
>> Also, the card only supports 2 to 8 channels, and I wonder if we should
>> add a plug element to support mono streams, and where this element
>> should be added (after or before the iec958 element).
>
> Applied, thanks.

Thanks!

Any recommendations on how to restructure this so that things like
'aplay' from the console also work by default?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljmmxUACgkQtdYpNtH8
nujHaQ//ayHQ9HfpTmtD7OOGKkc4s9HG3ZbgZZLh7szC88g9rI3ovrRFT5Ly+tUs
4LYLR7Ah1bfeB3GntVwMiMWSBUS66aR3nCvQmWH2/KN2OuVozB8uKce35U/dap8N
UZ49gXPu8ePJL/beEZ6nk92r1Pq9Cl/QY7vEvsIIvTd3X/i7tg0IcQGePB9+Zeco
aqTV9jMKO7KshjAe3PBVH+3c19TRypzauLhiJ/tLxEGXmJuRx9/OQPM616nlCvbr
3VP8FRdXIbSEi99zxGMlDWI0GxBYD2gZWV67c9b+Qyr8w2soWbvCdRpEBy0Pwz01
aDrBDeNEFAfWMEW4sIGBj/BB3Rp6FAl+gjGATBa3JfLwb9HdKQHR+pXHZAvJ2Wi+
Eq6AHSKDMyOF85b56SsajhnSWT0DCKyw5RF6a0uPV7Oj8mwe7RcP80MEt09r3mEu
pbAacsFuFnVTFb85o1TuQ/zo4uvRXemRudIQAqEOoPfjty+v8j9+KFz6JA9s6Ut6
YTdO/omL8ybqPNuQIvLiNggY3+mJQnFgDhVG2Q+Polz8Dne+1Ry95T+1SwKnFJle
VL3qTUqZ9yvQD16rDAlth0sajYkoTl3fLc/PCTAo7TG/zvBYPT71lxYxdwS2SoUF
a3zz+0RQGBwXrgHXDPfwKNU2xHn23BcKUnHeFbC3jPng3dgktnA=
=+3Ak
-----END PGP SIGNATURE-----
--=-=-=--

--===============2728027497245942005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2728027497245942005==--
