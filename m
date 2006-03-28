From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa problems
Date: Tue, 28 Mar 2006 15:21:22 +0200
Message-ID: <1143552082.13615.51.camel@localhost>
References: <1143547835.13615.25.camel@localhost>
	 <s5hu09i7m3k.wl%tiwai@suse.de> <1143551506.13615.48.camel@localhost>
	 <s5hr74m7lqi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RclO8xEnPUA1cHiYIrDH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1AA7199
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 15:21:28 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id B1C7399258
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 15:21:28 +0200 (MEST)
In-Reply-To: <s5hr74m7lqi.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-RclO8xEnPUA1cHiYIrDH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-28 at 15:16 +0200, Takashi Iwai wrote:

> Why do you need to register the device before creating instances?
> It means that apps are allowed to access the driver even though it's
> not ready.   This looks like a wrong design.

Because the pcm is created by my i2s bus driver (which knows it can only
have one pcm per i2s bus).

Then once codecs are discovered, they attach, and the streams are
created.

Right now it's even more broken requiring me to create both the playback
and capture stream without knowing if there's anything on the bus that
can handle it.

johannes

--=-RclO8xEnPUA1cHiYIrDH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCk4UaVg1VMiehFYAQIWQQ/+NbwSgboFdrfHp3oGvf0lzVAzs1UOBdaT
YOBYUFzZ01M8Ep8hOeRh30ifC2V1wo04BpbgA0+uEZADzFj3xwH8UCyvW3mXUEQk
mIUT9Xp97IOgOtcaUPrC5RaC7mfMs5pdQ3YRT8+JnoMIT5+N71dSLslvtp36Ik3v
G1CssrnRATsG0Qy5Krz6cHy9hTfK1Xg0k0AESC7Glp5+M7Ek4Tf2Ytf39KOV+LbJ
FNrIT7ozRXcs8NOaQm7aGpvbMIDi5Y+u08DRAg9BwPsCW/4E7VXsxWy4vPp0QbOq
MieQtt4AjvdMLLTs0/Igzd1+tE3vFxaE1ulkFt1LcaKyNUfISPK7iSgltMUiBaHI
PrIlHvT6i2hQdc8gHax1JKqboPlMiOguXLNG06L/K0VdQZO7JG6/Oj8LKiTbGnPO
jpH+Dofdz7rJ+101AJvi19w3cLberM0kRVVgPnUTsWDqaejKG1AriyFiSnF/Nfg1
hkGs4oLw1e8w4fPNtWRZasRMRd0leRJl4RteQwBw/IoOPuJfKPBt9b/hRU9nWF2o
UylUOYoNVhNwPT17PSCT6dnH1lcK1wodEJj5bbr6QHWgjVdXoeSDmUyg0+1bk/67
AOyue45HHXwVZM9ZO60XuPGRPGSPjmVlR7XfU9y05wjoIFnYIkUs501gKnN7yUUQ
/w6Qw3cTfH8=
=+dSn
-----END PGP SIGNATURE-----

--=-RclO8xEnPUA1cHiYIrDH--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
