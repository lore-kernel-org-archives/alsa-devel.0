From: Johannes Berg <johannes@sipsolutions.net>
Subject: pcm hw parameters?
Date: Fri, 24 Mar 2006 14:19:47 +0100
Message-ID: <1143206387.28247.22.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7OO9q0bzXU8v6hD+zDfD"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 129BF1D0
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 14:19:57 +0100 (MET)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 959E99943E
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 14:19:56 +0100 (MET)
Received: from [131.234.73.110] (helo=dhcp-73-110.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.60)
	(envelope-from <johannes@sipsolutions.net>)
	id 1FMmFq-0000Jh-7f
	for alsa-devel@alsa-project.org; Fri, 24 Mar 2006 13:23:02 +0000
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


--=-7OO9q0bzXU8v6hD+zDfD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Quick question: When are the pcm hardware parameters surfaced to
userspace? Are those the ones I register in snd_pcm_new?

Thing is -- I have the problem that in theory, my codec can support
anything from 8KHz to 96KHz but when turning on digital output, it needs
to be restricted to the ones the digital output is ok with.

Of course I can trivially forbid turning on the digital out when a wrong
stream is open, but what about the other way around? When digital out is
turned on, and I forbid opening the stream when say 8KHz is selected,
does it screw over userspace and fail, or can I tell it what else to
use?

Similar things happen when you have digital input and it clocks both out
and in -- then you have to output the same bitrate as the input is
coming in at...

Thanks,
johannes

--=-7OO9q0bzXU8v6hD+zDfD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCPx8aVg1VMiehFYAQK/lg//fxNZTajuviRxIXRuVrxBTS6gLQN0S5bq
Tdzu0cD9pcjYL0uQYPaOsoWwGvmbTXdMdOGnlXc8gW18vS78wyRB8D5PcGFQnl0z
/38ZLl2dm58hIzCb9Lj7Ocl6ZbKr5o4UZBorP841zs1kklazw0jc3Lh0xXq86r69
Ww2p6KQjoit3dxNK7iKjMkpWpFt38sQy5gQSeMMdWB4dMPWJedQnFO854uVHwXGB
ll3VwoaSP6MspLGjfGFBmR5f4nvRt8N9cqmoMzMd1lSbdj99wWPLF4cqPwNvhNWf
lzSDlAduEYoK9JGT9kF19ikAQk7cT7CfD/cwMy57jxYxgUM525fA9z9ZVBh6MoPy
9STURvGYB9KNOj8qNITIfdFYLlebG1CAfshPEftYG6LJBcZwu6J9Va2BnYGlvxrT
+nrw307+Mnu2sqHmSjMvmF5u3Bpxx3t3jjmXU2q9qzCxi9Dzu5DQJmH1GaMrKhLV
/R5RjOe9BUXm2T5rGScSqcJBflUQLoLM6/x0+xkq7WCkqHrAnWUCNGe34LRxuOed
VjxJF4/dnRkoEbKsozx8g6vCEbS4ImB3TApRjDYaRqsSYuvWhmRIvdvJBkfV9bx5
Lb+xROVs3NKy+ENHHs0GkAJIJHExJkIxAygg9q6ZlG9VxtupnedZWnjNeeAduIPz
ZsjSgtH5r88=
=vvt0
-----END PGP SIGNATURE-----

--=-7OO9q0bzXU8v6hD+zDfD--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
