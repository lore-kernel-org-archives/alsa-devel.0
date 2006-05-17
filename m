From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 14:17:54 +0200
Message-ID: <1147868274.15507.6.camel__42428.8435061046$1147868467$gmane$org@johannes>
References: <1147780945.29795.110.camel@johannes>
	 <s5h7j4m40kf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tzaq+7jw3g0GL/6/SoNi"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E7155178
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 14:17:59 +0200 (MEST)
In-Reply-To: <s5h7j4m40kf.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--=-tzaq+7jw3g0GL/6/SoNi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-16 at 14:27 +0200, Takashi Iwai wrote:

> I don't think it's alsa-lib that prevents the negative or non-zero
> integer range.  The fact amixer works implies that it's an
> app-specific bug.  But I'm not 100% sure and need more
> inside-looking.=20

Basically, I think what I'm saying is: "why doesn't alsa-lib shift the
range to start at zero?"
It already does so many manipulations, that one wouldn't hurt...

johannes

--=-tzaq+7jw3g0GL/6/SoNi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsUcKVg1VMiehFYAQIrFw/+JHlsySCmNJ7WvXz/dl6S4IJrX8OkTezK
Wj+CUuTACk3xYMUCmDDsZtYj2ef3jpZHStIVUREPGwacRUDrKe6S9z1/YATT++7P
KTLh0BSmtAEw000HqOk92uxTHDKmfa8Cq+UwcI+Wj8go3d0k392wUI3wa01P6Qt7
MJ2vsEN1LiWeIJkY4pbCaJRWZYIwvhIC5OQf+w7namYixquULNO9tX8r7KL3I6PJ
9f0qNrm2Pt/gQC+kCZJlPUBgxV3VFpnaszN5scqNSPE+ic8wV4J0vMqzIERA2uZd
5aKsX2MSiRoP/hExeR0907hbZT6a2BtENRU1xvBfa6SlX6QqpvdrY1FpDJrdk4LP
UTUnshX6IxI0K9S8gvtuI5ktWKg/LhUmZG/nKOpIYGh0Er/RM0ELnmpSHjuw+/q0
Wl6K+zWg7DJzRM3JoX1c8WmvDzuF2f/MTSX4P69KrgYjIO8XvpOwbgiJcC7ffuTt
Tmr20kUcssl9N9hVVbummTlX0qizh4x9ZQGr2f61RvmDwpHZZYvGSTK0Fy3oRoUw
JMPBdSJJ2zOgP87It8d8zllfaJM2cYPrr2mxM8De4McYU9baH+RUzb2fpk1qgVxA
G/cwv4jXElgXd/OYPDftKKBus6XbLniCDI/ucu+AP/Siaki3uD2pGlPPG6gYkvml
h7jXjB0slC4=
=MgzH
-----END PGP SIGNATURE-----

--=-tzaq+7jw3g0GL/6/SoNi--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
