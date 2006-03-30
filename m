From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: pcm parameters, digital output ...
Date: Thu, 30 Mar 2006 17:06:05 +0200
Message-ID: <1143731165.4617.0.camel@localhost>
References: <1143632082.9481.6.camel@localhost>
	 <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0cQu5W9IEzyCGAU1ftti"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 170C315A
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 17:06:18 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id AE90A98DDF
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 17:06:17 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-0cQu5W9IEzyCGAU1ftti
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-30 at 16:51 +0200, Jaroslav Kysela wrote:

> The mask is R/O variable and the bit definitions are different for=20
> consumer and pro modes, so the driver can describe exactly which bits are=
=20
> supported for these two different modes.

Yes, I know, I just don't see why there are different modes. If the chip
has different modes, shouldn't the driver be able to switch between them
based on the consumer bit in the actual iec958 values it gets from
userspace?

> AC97 code is probably not a good example. The "shift" to specific PCM=20
> device is not implemented there. Look to snd_ice1712_spdif_build_controls
> in ice1712.c . This code is good.

Hmm, ok. Did you read my earlier discussion about why I do *not* want a
shift to a specific pcm device?

> I'm not sure, if we need a new format when we have information from the=20
> control elements, that the stream is not PCM encoded. But on other hand,=20
> these formats can be used with some conversion layers in alsa-lib=20
> for handling of these streams and prevent extra things like resampling,=20
> volume processing etc.

Aha, good point, I could use the iec958 bits to determine the mode. But
that's out-of-band information, so it is not too nice to rely on it
imho.
And exactly like you say, resampling etc. cannot be done on compressed
information.

> Also, there is a possibility to use subformat value (which is not used=20
> so far for S16_LE/BE formats) for the non-pcm stream specification.

I'm not too familiar with these internals :)

What I'm currently doing is defining for each codec what kind of
transfer formats it supports, see=20
http://johannes.sipsolutions.net/gitweb.cgi?p=3Dsnd-aoa.git;a=3Dblob;h=3De3=
ca7a269906ceb41b411afcad14c54f4a181588;hb=3D4e1bc0b35020b3b1cac87f60cb67671=
e2c9a801e;f=3Daoa/codecs/onyx/snd-aoa-codec-onyx.c#l430

Then the generic framework cuts that down to whatever is usable() at the
moment depending on the selection of the iec958 and analog mute mixer
elements. Hence there you can see what I'd like to do with a new format
(which I called SNDRV_PCM_FMTBIT_COMPRESSED_16BE for now).

johannes

--=-0cQu5W9IEzyCGAU1ftti
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCvz2qVg1VMiehFYAQINBQ//adP/GPkjOfHGoEW4f3NYqY6uBSUhsg7I
oO2NQpwCaEEzNKIxs1bDezNX3zTxKLYrGs8+PzzGmtboIb+g4f688GI5x3foROCn
f+ZnZi9NYrHnSwTWcxwV+YIz82abFpvxT3v5NcCjnYtKtagSXj72rfMhjJdIVfag
utLY490DprbblaOE8C/xO0f25RAq8fKr1LPTZfztUdZM8OfRmMo6nt+ZgHvdaIXm
Y9Oh/FnPba8EXcDUVZD2u1nGoHlrrH+N+60rAU4N8QIVuGjJdxDbaL9UhzQKkuhZ
3Q3jD4cu3q4f/bINCxCXWluNGbnOnZ23x5UxUD3mHCZrAUgcdgVBYwiG/oNcdH9y
5TOzdQNlYTa1QZR7vHEV13bvpJPjBnMjFORWjyr2qsQ28zBLXg1aCdgaQR/P9zLp
IaTeGGh+EQEuQoje9IZ+PMc2UUbv0tCq9y5mOI7ZQRBU0zTU524xr9hHjTZoEkvx
OoCWZhoS+p8lhZzMkANcEvc+GgM9R9835B+V11ni+3ARdgk2Uw82XP7E4GZftfNZ
ojmoAAQYoA57Hn1w5EvVbBZs2rt5qi7xch5PF4yewj7HbRUJKY0frOkvJTyI61J7
6Id2+uqJ3hlVGVCdV485q5IA5HwjBjbYVzUSMBj+NW8R8oqJVSwA3aJC2joQ/OGU
P4zdIfhQbJ4=
=fM9S
-----END PGP SIGNATURE-----

--=-0cQu5W9IEzyCGAU1ftti--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
