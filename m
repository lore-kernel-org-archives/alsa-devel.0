From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa problems
Date: Tue, 28 Mar 2006 15:44:11 +0200
Message-ID: <1143553451.13615.57.camel@localhost>
References: <1143547835.13615.25.camel@localhost>
	 <s5hu09i7m3k.wl%tiwai@suse.de> <1143551506.13615.48.camel@localhost>
	 <s5hr74m7lqi.wl%tiwai@suse.de> <1143552082.13615.51.camel@localhost>
	 <s5hodzq7ktj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3v5K6EfCaRJXcbArcXvx"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 13C3219F
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 15:44:15 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id BB4199923E
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 15:44:14 +0200 (MEST)
In-Reply-To: <s5hodzq7ktj.wl%tiwai@suse.de>
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


--=-3v5K6EfCaRJXcbArcXvx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-28 at 15:36 +0200, Takashi Iwai wrote:

> > Because the pcm is created by my i2s bus driver (which knows it can onl=
y
> > have one pcm per i2s bus).
>=20
> What do you mean one pcm?  One PCM substream, one-directional stream,
> or both one pcm instance containing playback and capture streams?

I can have at most one pcm instance containing one playback and one
capture stream per i2s bus.

> The question is rather the flow of creation.
> Usually, the registration occurs at the very last of initialization
> stage, i.e. all devices are probed and initialized to be ready for
> use.  Then the driver calls register function.
>=20
> If the registration _must_ be done dynamically, one by one, the
> situation becomes a bit more complicated.  It's not only to the driver
> but to the user-space things.

Yes. It must be done dynamically.

> > Right now it's even more broken requiring me to create both the playbac=
k
> > and capture stream without knowing if there's anything on the bus that
> > can handle it.
>=20
> You don't have to create an empty PCM, but create a PCM on demand, as
> usbaudio.c does.  It doesn't create both streams.

Right.
Let me explain the control flow:

First, i2s busses are discovered, but no pcm instances created for them
yet.

Then, codecs are discovered, and each on registers with the i2s bus it
sits on. At that point, the codec could support input only, and it
announces this to the i2s bus. Thus, the i2s bus creates a pcm with just
a capture stream, and registers it.

Now, another codec is discovered, and it is on the same i2s bus, but
supports playback and capture. Now, my i2s layer handles switching
between which one of them gets to capture, so that's fine, but when I
now try to add a playback stream to my pcm, this playback stream never
shows up.

[the actual situation is slightly different, but this serves well to
illustrate it and might actually happen this way in the future]

Now, I cannot defer registration of the pcm until the second codec is
discovered because there's no way to know if a second codec even exists,
and even if it exists if the user compiled the module for it.

johannes

--=-3v5K6EfCaRJXcbArcXvx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCk9qaVg1VMiehFYAQKIOw/9EtNhkuxXsHcMvVdDRArCgrYp+zBsfqVz
SxQMDCJ7xOfEyqRATKltDOZgicyNY1q0IdELaS/7TQRbiPzeRjZ9VbJSQuPfZ5eE
UraRSO8D+sC2sq/qhXbvWIJvB+dvxCH6uPqUNpNWYRkzMYg7eip0pTJ0CX9hhYxf
YDaCmpbgfBkCnpsgVyJVlSVB0tYWI5EC8cEpHyLLG2MdBHS4UU5/Tdkrbz07DdLS
gVZFSDC5DNVlFGQHBC9AgmrPqKiirXc75PXZv6QZ87+fXS3ojh05HP1QgyJOtwRw
OuYfz24eUKceLNl7cn7d8soyNYte3hxCxms+bdGXA+mJZ+PmwgVDS5mRz00Ck76h
Bz0jLKBtLrFw48AdGUgNry+yPkKxzmfThQ2BWpZioYUVe/jcpVo5POrTWNVQkdDo
K6ICvSLhaMN0OPHuXC2P8jlR9GbKGnswlMkLyrVfiDNWgd7AqgwOhF/c9lRqRTXA
nqz9rhnDAAtVK0Q2Blx8WI9nZKxSVhUy3yllRcwb95RPT6Bd9KtdujtC6UehEpdl
X2qdveDiy43+VjTaf593gc4+8KsAUd1mdZRC4m8FG8VgIYrHlaI+Ymz1k0BnGcdd
JgdqbFRKuPeDSFy0oE3bovIRtC0p4bbSComS4pnYSi+jEaBCyN6g99N1tKetuwH8
+nc2KCMyJUA=
=nFZZ
-----END PGP SIGNATURE-----

--=-3v5K6EfCaRJXcbArcXvx--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
