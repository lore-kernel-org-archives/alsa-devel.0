From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 20:06:30 +0200
Message-ID: <1145383590.4116.83.camel@localhost>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <s5hd5ffxc1r.wl%tiwai@suse.de> <1145382922.4116.81.camel@localhost>
	 <s5hodyyvjxr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-puOSFrLTeNUTKMz8TXau"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (195.210.38.204.no-dns.no-wires.co.uk [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E318171
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 20:06:34 +0200 (MEST)
In-Reply-To: <s5hodyyvjxr.wl%tiwai@suse.de>
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


--=-puOSFrLTeNUTKMz8TXau
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 20:05 +0200, Takashi Iwai wrote:

> We cannot freeze the running user process at the very same moment the
> driver's suspend callback is called...

Yeah but we can freeze the pcm before the app, so for the app it's just
as though there was a small pause/hiccup/whatever

johannes

--=-puOSFrLTeNUTKMz8TXau
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAREUqo6Vg1VMiehFYAQLMKBAAw1SzVmYJU5FIIq8xNry5zJoxW+JXuPgL
LPzXJbLN0/Bdf/aagNF2Iogh+XZA7FC8O5CccGAjZrp5q75i1r1TLt57WtL1wAHu
42wTUDrUgz93T56MGx36apZzxMAhU2oPEtNa8We3McP4L8EY5/ayYzCx1MaPhXYm
iT10rijt3CbttoqUazxcV9RAMrEg7cHXVlRqUAUkiqL5rpIpO/MsJRMjs3d0e22e
fgB/MQb7Gs5kLbVe1lCC/i/vfr1QWDWCn9Gi1YVcn4gzuFkEmCZcqJM/cLqGFPaG
YdKoqSOvcQy56/YeKoXR4nJ0cGglEk2HdD9plajcXGzV3hSRgH8E0S4VHch9IH5N
MV77FO+GTyiwcW+Kr959q8UmNbji00i0TVY22nUPIHwNtslOc5k4p4JId0H/pkv5
wv7eV3UUgkfDjHxAmCcFWLpAtSquvBKMD0I+TBO07XnyN5m73kqZCooKAIkia9yp
z39WH67S6W28vioWOHiwrku/a8qFVDn5kU+wiS2QYXDZe5H6v0uLm/8WJitoTEuh
/bnUU40a37dXRS96m+xTLYXjecHi23+xfMEqkO/p1TJejev5lw89nMyRK4ca7caG
v+8qZKajVLUyC2piaRf9xXQAk97RzSHZhMcHE1U1PyF4BumPLY8ujzpDGrzJQjOZ
qTGLcLtRp1k=
=4dxP
-----END PGP SIGNATURE-----

--=-puOSFrLTeNUTKMz8TXau--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
