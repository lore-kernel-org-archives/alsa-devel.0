From: Sebastian Kapfer <sebastian_kapfer@web.de>
Subject: [BUG] alsa-lib leaves sound device open for child processes
Date: Mon, 3 Feb 2003 23:16:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030203231629.26ee7464.sebastian_kapfer@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.BNIoOis)P6Gbkt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=.BNIoOis)P6Gbkt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


The alsa-lib doesn't set the close-on-exec flag on its PCM device FD's.
The consequence is that processes spawned by alsa-lib clients inherit an
open file handle to the PCM device and thereby block it.

For example, mplayer can disable and re-launch the xscreensaver daemon.
In the alsa-enabled version of mplayer, the xscreensaver process
inherits a pcm handle, although xss can't make use of it. This
effectively forces me to restart xss manually after each mplayer
session.

Suggested fix:

--- src/pcm/pcm_hw.c.orig	2002-10-12 13:49:54.000000000 +0200
+++ src/pcm/pcm_hw.c	2003-02-03 23:07:14.000000000 +0100
@@ -867,6 +867,11 @@
 		ret = -errno;
 		goto _err;
 	}
+	if( fcntl( fd, F_SETFD, FD_CLOEXEC ) != 0 ) {
+		SYSERR("fcntl FD_CLOEXEC failed");
+		ret = -errno;
+		goto _err;
+	}
 	if (ioctl(fd, SNDRV_PCM_IOCTL_PVERSION, &ver) < 0) {
 		SYSERR("SNDRV_PCM_IOCTL_PVERSION failed");
 		ret = -errno;

-- 
Best Regards,   |   Hi! I'm a .signature virus. Copy me into
 Sebastian      |   your ~/.signature to help me spread!

--=.BNIoOis)P6Gbkt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+PupBnfcZmxgeNYgRAmnQAJ9xzRkDNFZaUgegvaPnVtsLjdD/1gCgumWo
9TYTIgr2cI3jcnR6YxApKKs=
=GwyM
-----END PGP SIGNATURE-----

--=.BNIoOis)P6Gbkt--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
