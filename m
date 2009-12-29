From: Chris <cpollock@embarqmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 349696 bytes (1821 ms).
Date: Mon, 28 Dec 2009 21:49:13 -0600
Message-ID: <1262058553.20808.15.camel@localhost.localdomain>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1446990015926627554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id A4D1E10380E
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 04:49:16 +0100 (CET)
In-Reply-To: <4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1446990015926627554==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-FUYezjl0uPbq0hQVavr1"


--=-FUYezjl0uPbq0hQVavr1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-12-28 at 13:14 +0800, Raymond Yau wrote:
> Do you mean that you cannot find a test case to reproduce the bug ?

Not exactly, for instance 20 seconds after freshclam ran I see this in
my syslog:

Dec 28 21:26:30 localhost pulseaudio[11266]: ratelimit.c: 52 events
suppressed
Dec 28 21:26:30 localhost pulseaudio[11266]: asyncq.c: q overrun,
queuing locally
Dec 28 21:26:30 localhost last message repeated 10 times

then this:

Dec 28 21:27:24 localhost pulseaudio[11266]: asyncq.c: q overrun,
queuing locally
Dec 28 21:27:24 localhost last message repeated 10 times
Dec 28 21:27:37 localhost pulseaudio[11266]: alsa-util.c:
snd_pcm_avail() returned a value that is exceptionally large: 839968
bytes (4761 ms).

The above is while the drive was 'thrashing' for a couple of minutes

I've also determined via experimentation that with pulseaudio running
copying a 1.2Gb file to a thumb drive takes an average of 30minutes.
This what I've done:

1. Using Gnome Commander I attempted to copy the 1.2 Gb file to a thumb
drive, after about 30 minutes I had to stop the transfer at about 35%.
2. Disabled pulseaudio in Mandriva command center, logged out and back
in again.
3. Again tried to copy the save file to the thumb drive, this time it
took about 3 minutes.
4. Re-enabled pulseaudio and again tried to copy the file, this time
using pulseaudio -k ; pulseaudio -vvvv on the command line. I saw
outputs like this:

W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: asyncq.c: q overrun, queuing locally
W: ratelimit.c: 600 events suppressed

I have the complete log as a 15k bziped file. Can it be sent to the
list?

Chris

--=20
KeyID 0xE372A7DA98E6705C


--=-FUYezjl0uPbq0hQVavr1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAks5fDkACgkQ43Kn2pjmcFxXMACfUjWWyG0w3GEWBTQNJJY9vrEC
KxsAnAujqJb+FU3ASVCsWdfaeQcHSLOS
=Gfzx
-----END PGP SIGNATURE-----

--=-FUYezjl0uPbq0hQVavr1--


--===============1446990015926627554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1446990015926627554==--
