From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: pcm hw parameters?
Date: Tue, 28 Mar 2006 14:11:49 +0200
Message-ID: <1143547909.13615.26.camel@localhost>
References: <1143206387.28247.22.camel@localhost>
	 <s5hodzrew57.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qvMbaSx+5/H76ODcfFhm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 719DE1AF
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 14:11:57 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 45625957F2
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 14:11:57 +0200 (MEST)
In-Reply-To: <s5hodzrew57.wl%tiwai@suse.de>
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


--=-qvMbaSx+5/H76ODcfFhm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-27 at 17:37 +0200, Takashi Iwai wrote:

> It's hard to restrict parameters on demands (although theoretically
> it's possible).  We usually provide two different devices, one for
> the normal i/o and another for the digital i/o, to avoid such
> conflicts.

I'm doing something like that now... Mind taking a look at i2sbus-pcm.c
in my git repo http://johannes.sipsolutions.net/snd-aoa.git/ ?

johannes

--=-qvMbaSx+5/H76ODcfFhm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCkoA6Vg1VMiehFYAQKrVBAAuM7vxWfLOqzNps3P1aU+rtlK4Q8z1GFP
ekbluLqOmVW5GwBfJ/kL6N2muEZ2hJNNClLgKz5G8YNtsfnG/pzF4XP4ThJDHWGl
7taL74MkSidd/3f7KI8cv8WuujpLyg4ofOS0D5prkX2HjEgZF3QUX5P9XeFRTkZa
XVfUK9SPePccT7Ld+za7sFbSoAOGCy4IIQvI1gdFZchilRmx01sh4wGMsh2K2GJa
9kY4/XXRM90Vzu0hue5hCvdle+O1LNUh6sGx78LK04nr/K9Oc2U5FPVKP5Pbqcu2
RvQfwN25OMatd10EeupFytqIxakTAeig9BeeVPj6zWx5vX92tsHpXInYjbkBpWLR
SIyGdBLwq/ebKvF4M+k/kU42rbxk84d93ugKVXDU7FLF5HhU0UCJ1ZflNpQOj/qy
ALpN7IgJEEc0Gy6RW4pFluJ3wXYtaGzDEwpPYJteBQXAUrED8w4BYTc+sTXPGx4Q
omibqNStY4quULrwgu6zrD4k6nxOSIruTm00dPZirZ8Xqb2Gx563NBv0XlCfVKY/
EdQ01IuSB8nzroeMOCEbzX55cIsoDAAfk6TWBp9e+aUSG3SGLAnQHh6wIJTIweV+
2JJskc8cGtzSYLd4XVPH185VsHTGIqbiaICyhhPIqOePDMcoA/nlMMmOgrlRpIdc
C/UhQ8ZzHM8=
=hgpx
-----END PGP SIGNATURE-----

--=-qvMbaSx+5/H76ODcfFhm--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
