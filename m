From: Michael Mauch <michael.mauch@gmx.de>
Subject: alsa-lib-0.9.2: storage size of `vec' isn't known
Date: Sat, 29 Mar 2003 02:16:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030329011657.GB936@elmicha.333200002251-0001.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

with kernel 2.4.21-pre5, I get:

source='socket.c' object='socket.lo' libtool=yes \
depfile='.deps/socket.Plo' tmpdepfile='.deps/socket.TPlo' \
depmode=gcc /bin/sh ../depcomp \
/bin/sh ../libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -c -o socket.lo `test -f socket.c || echo './'`socket.c
gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -c socket.c -Wp,-MD,.deps/socket.TPlo  -fPIC -DPIC -o socket.lo
socket.c: In function `snd_send_fd':
socket.c:45: storage size of `vec' isn't known
socket.c: In function `snd_receive_fd':
socket.c:78: storage size of `vec' isn't known
make[2]: *** [socket.lo] Error 1

When I include sys/uio.h, it compiles. I don't know whether this is the
right place for this include file, though.

Regards...
		Michael

--- src/socket.c.orig	Tue Mar 18 19:03:24 2003
+++ src/socket.c	Sat Mar 29 02:14:58 2003
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/uio.h>
 #include "local.h"
 
 #ifndef DOC_HIDDEN


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
