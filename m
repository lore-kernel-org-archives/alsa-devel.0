From: Eric Anholt <eric@anholt.net>
Subject: Re: [RESEND PATCH] conf/cards: add VC4-HDMI card
Date: Fri, 07 Apr 2017 10:20:20 -0700
Message-ID: <87r314qgmj.fsf@eliezer.anholt.net>
References: <1488451773-22010-1-git-send-email-boris.brezillon@free-electrons.com>
 <s5hinn4w6l8.wl-tiwai@suse.de> <87lgrd48ve.fsf@eliezer.anholt.net>
 <s5h60igaar8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1413199745725586809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 98DFC26686A
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 19:20:24 +0200 (CEST)
In-Reply-To: <s5h60igaar8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1413199745725586809==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Takashi Iwai <tiwai@suse.de> writes:

> On Thu, 06 Apr 2017 21:46:29 +0200,
> Eric Anholt wrote:
>>=20
>> Takashi Iwai <tiwai@suse.de> writes:
>>=20
>> > On Thu, 02 Mar 2017 11:49:33 +0100,
>> > Boris Brezillon wrote:
>> >>=20
>> >> Add a conf file for the VC4-HDMI sound card.
>> >>=20
>> >> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> >> ---
>> >> Hi,
>> >>=20
>> >> Sorry for the noise, but I didn't send this patch to the alsa-lib
>> >> maintainer on my first attempt.
>> >>=20
>> >> This patch is adding a card config file for the audio sound card whose
>> >> driver has been submitted here [1] (not accepted yet).
>> >>=20
>> >> Since I am a total newbie to the alsa world, I'd like to get some
>> >> feedback on this patch.
>> >>=20
>> >> Also, the card only supports 2 to 8 channels, and I wonder if we shou=
ld
>> >> add a plug element to support mono streams, and where this element
>> >> should be added (after or before the iec958 element).
>> >
>> > Applied, thanks.
>>=20
>> Thanks!
>>=20
>> Any recommendations on how to restructure this so that things like
>> 'aplay' from the console also work by default?
>
> Well, once after you have your card config in
> /usr/share/alsa/cards/vc4-hdmi.conf, aplay should work as is.
>
> If not, check /proc/asounds output.  The entry looks like
>  0 [ID            ]: DRIVER - SHORTNAME
>                      LONGNAME
>
> and in your case, "DRIVER" must be "vc4-hdmi", as same as the config
> file name.

It doesn't work as is -- the default ends up not having iec958
conversion, so nothing will play.  You can do aplay -D iec958, which
works but only as long as you've got stereo input (it seems plug can't
do mono-to-stereo on iec958 data)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljnylQACgkQtdYpNtH8
nujOyQ//WqU15wdtT5bTrYb+i3nyPXC4T/tHGNDrgTnD9u+lme9fb2MPqgzeS+dR
AnRHpJO4YEChxua2DHSTPTQKBzGb0Yyc65Ey9pmcbeIDcz3A+x03/eSC72mvFnWc
mDejPYOEBiFM7w7tDFVYzKV0ZmWIllbYOhT1i6tOdhugjYUH15LieP2Dik5AFL7x
IkRgwfCU12Gka+1zBgQznlfSagYBcgwn6nkFvl44/wLrU53nj6V+0co5n7+yHYGj
jm6VkGLBaUniDd+yjPotTA59lbcbvSOzmb+5aA2hnSX2lGfosDhHc474zKMUNP+z
UEbsfX/tq68s/MuzT0XnNHdRDgRxp+zyv37dMBF7b+TzHKCan7G2ODh5TXN1Vc8o
Cp37FG3VPwARm5zIX53mjl4dbHlsdG5PtPrvyIaniOe2AH0Lz9GYA/YNTbQK2kJL
/Pl5j7pHb9C7gjM7JOC5WolPtRSCmmw2eCR5lF7/TaIJKTcgGkDYUo2VuaCdgN3S
gnYYUs4NyMJ49n3k9jB/6S/AHPJOg6sdlxtx4xQ/E+vCXUIIYWlF4yUT/huejVHc
ZNa2tfkA+mYqk2iBY4h/eLhZmTY742Qx1lOnMf6vkaQ880dRUAsyoGseLM07XJWj
xeldnKl8gKQFhPTAt+g/phKV80s6q0nQjonnlSryhc7iQzK2N9E=
=DLSf
-----END PGP SIGNATURE-----
--=-=-=--

--===============1413199745725586809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1413199745725586809==--
