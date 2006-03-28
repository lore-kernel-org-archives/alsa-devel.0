From: Johannes Berg <johannes@sipsolutions.net>
Subject: alsa problems
Date: Tue, 28 Mar 2006 14:10:35 +0200
Message-ID: <1143547835.13615.25.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jewp0FuNvWI7kkel4Bq4"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B86E1AF
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 14:10:51 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8B5CF957F2
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 14:10:50 +0200 (MEST)
Received: from [131.234.73.110] (helo=dhcp-73-110.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.60)
	(envelope-from <johannes@sipsolutions.net>)
	id 1FOD60-00084z-6T
	for alsa-devel@alsa-project.org; Tue, 28 Mar 2006 13:14:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-Jewp0FuNvWI7kkel4Bq4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I continued writing the new driver for the apple machine sound stuff,
and I keep running into alsa bugs which is pretty frustrating.

1)
#include <sound/core.h>
doesn't compile because it requires sound/driver.h *before* it.

2)
snd_pcm_new_stream doesn't create the pcm devices when the pcm has
already been registered.
Since I don't know a priori which directions (playback/capture) my pcm
will support, I wanted to add the pcm, register it, and then add
substreams to it. No such luck, so now I have to register both
substreams (I can only support one in each direction anyway) without
knowing if they can ever be used...

3)
No way to get rid of some kinds of resources, like pcms...

Concluding, I'd say that there ought to be some effort to make alsa more
dynamic with the kinds of devices you have in card...

johannes

--=-Jewp0FuNvWI7kkel4Bq4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCknuKVg1VMiehFYAQKrJQ//RqgaKkDVKnlOoU8c3mzKfkM+IYGqfJjy
P9DPfJ+2FLW9oY1vRPbc+O5VObu5nBxYLEeMpghjP8EyFWiVO/N37f9sznnOWDLv
VI892Ju2JO05ORL+0P1U71glYw60knv6Htm/AQqADbzSkd2btxqHhRV29uGv1wvq
WhdP8OPKXJeouf2S0ifwqzJ6Vu6yDseZraJLxy1BsLJ/pBnKYZVEJv0MDVHk/zm1
zldKXwvFe/cGJ0XuBVkU4APRGKm2SRXicE3Y2oGxEgTfTscwMKeEoL6LdAwKa9Ik
iD1VWzayG2OL6hIAsWbYobUoEN4MInNcX18CWfZAPhNka8E4XQrsRiJ72Ywxel/F
2BpFvk5yHphBgMNT1aW46Ah1MOhC3OTgU2/lQTb+qiPxNU5Eg5JuXh9mBfqR55Og
Qf0MhMEoSBdB2lP836gnnW3KbMYuBqmpNE3SBU9PrL6AA0C2nN8d2i11JGqPVDpd
2nYI5ObS9gwAvXAoKU11nFJ+ny1SPn3p4DUiUkw662ZyFy4dVmrTdasAnlKiGMYE
3C8SmToUFeFffKXZQzyJrMmulZH/XjTDVwEwZSfNEmQ2vVWbDdr8L//pW0ISYMu+
cinAzgh7Y9Y73tgQIxBOkey3vBujB8d0JmFHrOv7sYK7hk6j9PArD6vN6RkLQAu7
FYojCZ9aVPU=
=RFae
-----END PGP SIGNATURE-----

--=-Jewp0FuNvWI7kkel4Bq4--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
