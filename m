From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 20:40:53 +0200
Message-ID: <1145385653.4116.88.camel@localhost>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <s5hd5ffxc1r.wl%tiwai@suse.de> <1145382922.4116.81.camel@localhost>
	 <s5hodyyvjxr.wl%tiwai@suse.de> <1145383590.4116.83.camel@localhost>
	 <s5hmzeivjom.wl%tiwai@suse.de> <1145383929.4116.85.camel@localhost>
	 <s5hlku2vizk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6VG7H6Ri6W5YqIPHPP/d"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (195.210.38.204.no-dns.no-wires.co.uk [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 358C7138
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 20:40:58 +0200 (MEST)
In-Reply-To: <s5hlku2vizk.wl%tiwai@suse.de>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-6VG7H6Ri6W5YqIPHPP/d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 20:25 +0200, Takashi Iwai wrote:

> Yes, of course, it's not an XRUN but "another type" of state.
> The driver just notifes the SUSPENDED state when any access comes from
> the app.

I still don't see why it is necessary. I can see two cases:

1) the app is frozen before the driver suspends, so that we get into a
regular xrun situation. That can be handled as an xrun

2) the driver suspends before the app is frozen, which means that the
app won't be getting any pcm progress for a bit of time, which doesn't
matter at all. Or is that the point where I'm mistaken, and it does
matter to the app if the hardware pauses for a bit (say for video/audio
sync)?

johannes

--=-6VG7H6Ri6W5YqIPHPP/d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAREUys6Vg1VMiehFYAQI5vQ//cYhrG+59QmkQvhI3E6QMb8iQl+MInRuP
lTD9vNImqAkzOx4rZJlsQWbokDrKgenwYvHHDhGRNlYF5xiKxD7F+xukx8TBZ0Xc
ls2+rMszzJmcLoFC1svcqS4LYkpB0pTgb6htf+q7ispgWzJZ2vM6iDSMJPSIpx7F
2D4tHJ7UBMmarSRTjE5ncm3/WzZzK3hdw6hnB721rezBu/Nonr7ueHAKZNbS8Eaa
C/sEphtuWJsaBsG9PC2oeMM5EIhScB8VVhu41UTe5f8aWA2bN0ezmbTmV9WZ5joM
s7kA7fIKreARLxDjwyA43OYnhOomyM4ACCvXqQ27tPme61t2hzHE3255IGay3SZ3
IEMD63Mit54Gb+Kx46AmX0Evhe6h0VTcOhMCGUxIJhRUobgqxbc4+ePQJc7UUKDO
/30JRrT7Deg7o2NR7rIkr8ldV1l51zGq+wtjJe6QW87Ul/SQ5+H5mI2mcwsXibso
RiI71cWe1z0FLEfInakrrDMtNseqo8CC//MHlLWx1Ll+DnqwsjiYkRzoG3mOLwkf
5WnPtB+Jc/1FezYL0P+opBggz+OqYhlFyl6Lsvi+NzdmQoyOpoSAJN14W9qU8jI+
zyI4ss8/RmdU4YgeaBLZJoEikthQ3p34Hr7+I2itetsgr6wNfs69aggrK5PNlxAt
Je/MbRl25SQ=
=ynXT
-----END PGP SIGNATURE-----

--=-6VG7H6Ri6W5YqIPHPP/d--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
