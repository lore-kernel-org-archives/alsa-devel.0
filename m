From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] fix /proc/asound/card*/via82xx formatting
Date: Wed, 3 Dec 2003 11:35:31 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031203083531.GB1753@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

In ALSA 1.0.0rc1 the data in /proc/asound/card*/via82xx seems to be
formatted badly (missing '\n', so all register values end up in a
single line):

==========================
VIA 8235 at 0xe000, irq 22

00: 0000238004: 032bc06c08: ff3fffff0c: 0d00089810: 3f00000014: 0000000018: ff0fffff1c: 0000000020: 3f00000024: 0000000028: ff0fffff2c: 0000000030: 3f00000034: 0000000038: ff0fffff3c: 0000000040: 0000000044: 0000000048: ff0000004c: 0000000050: 0000000054: 0000000058: f42415d45c: 0000000060: 0000000064: 0000000068: ff0000006c: 0000000070: 0000000074: 0000000078: ff0000007c: 0000000080: 022cbb8084: 0000000888: 000000008c: 0000000090: 0000cc0194: 0000000098: 000000009c: 00000000
==========================

This trivial patch fixes the problem:

--- alsa-driver-1.0.0rc1/alsa-kernel/pci/via82xx.c.via82xx-proc	2003-12-03 10:53:31 +0300
+++ alsa-driver-1.0.0rc1/alsa-kernel/pci/via82xx.c	2003-12-03 11:25:07 +0300
@@ -1711,7 +1711,7 @@
 	
 	snd_iprintf(buffer, "%s\n\n", chip->card->longname);
 	for (i = 0; i < 0xa0; i += 4) {
-		snd_iprintf(buffer, "%02x: %08x", i, inl(chip->port + i));
+		snd_iprintf(buffer, "%02x: %08x\n", i, inl(chip->port + i));
 	}
 }
 

-- 
Sergey Vlasov

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zaBTW82GfkQfsqIRAiJHAJ0QpjZuMkTNQaa1qYFZcclMlYNqsACfaHL5
CHCnuFBnI8Tc7iJ90gegmWs=
=8arF
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
