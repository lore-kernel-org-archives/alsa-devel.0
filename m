From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: making aoss able to wrap fopen() calls
Date: Thu, 5 Feb 2004 17:26:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402051727.25712.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.teamspeak.org (port-212-202-6-222.reverse.qsc.de [212.202.6.222])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA01024
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 17:28:22 +0100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey,

During a thread on alsa-user I was told that aoss does not wrap fopen() cal=
ls.=20
Since I am trying to dmix/dnsoop/asym some oss applications, I am trying to=
=20
find a way around this restriction.

Could you point me to a good idea of implementing this ? On irc I was=20
discussing doing a libc wrapper that replaces the fopen calls with some=20
substitute (that aoss can handle), but I'm not sure if its the way to go.=20

Please tell me how it can be achieved.

Thanks in advance
Peter
=2D --=20
He played the king as if afraid someone else would play the ace.
		-- John Mason Brown, drama critic
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAIm7Fg2ieGvTmHiURAu2/AKCTbppd/g5Fvg7l50XK6UdCaknhFACfdzkf
GEqmfQ/1VT15FUoF1T5/3Xw=3D
=3DjMJf
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
