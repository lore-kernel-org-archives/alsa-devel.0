From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [RFC] tty (or char) bus?
Date: Sun, 19 Jul 2009 15:19:22 +0200
Message-ID: <4A631D5A.3030105__23131.236623931$1248156357$gmane$org@imap.cc>
References: <4A5CA4CB.8070500@tis.icnet.pl>
	<20090717175428.GB4852@const.linuxsymposium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8563612771073656212=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D6967243AF
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jul 2009 15:19:38 +0200 (CEST)
In-Reply-To: <20090717175428.GB4852@const.linuxsymposium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8563612771073656212==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88B07A3DAEE0D42B989E0F02"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88B07A3DAEE0D42B989E0F02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Scripsit Samuel Thibault die 17.07.2009 19:54:
> Janusz Krzysztofik, le Tue 14 Jul 2009 17:31:23 +0200, a =E9crit :

>> AFAICS, even if tty lowlevel write() could be used unmodified, a
>> convenient way of reading characters from a tty is missing and should
>> be implemented in a line discipline. Please correct me if I am wrong.
>=20
> Have you seen the receive_buf line discipline hook?  Indeed it's not a
> read() operation as from userland, but at least you can get the data
> from the tty that way.

That's as it should be. A read() operation that sleeps until some data
is available isn't very useful in kernel mode, as it can only be used
if you have the ability to sleep. A callback function which runs your
code as soon as the data arrives is a much better fit, although of
course it requires a bit of rethinking.

>> OTOH, I found that some kind of abstraction layer for acccessing devic=
es=20
>> over a tty could be convenient. Instead of allocating a new line=20
>> discipline for each specific device, sometimes found on a specific boa=
rd=20
>> only, why not just create a new bus type?
>=20
> I'd tend to agree with you, as I also have a use case for that: braille=

> & speech synthesis devices.  However for now I haven't found a really
> convincing argument why line disciplines aren't enough.

I was in the same situation three years ago when I implemented the
ser_gigaset driver for an RS232 connected ISDN adapter, and found the
line discipline (LD) interface quite adequate once I had figured out
how to use it. The only inconvenience is how LDs are loaded and
attached to a serial interface, via the TIOCSETD ioctl, because you
need a userspace daemon which keeps the tty device open so that the
LD stays attached to it.

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig88B07A3DAEE0D42B989E0F02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFKYx1jQ3+did9BuFsRAg3/AJ9DoJ8L+mJpXb4/JW/rGFaS+bFcywCffH+L
DGXR59/J2JT3LJpG45D6TTs=
=MRKk
-----END PGP SIGNATURE-----

--------------enig88B07A3DAEE0D42B989E0F02--

--===============8563612771073656212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8563612771073656212==--
