From: Mike Hearn <mike@navi.cx>
Subject: Patch for AOSS
Date: Mon, 04 Apr 2005 17:38:07 +0100
Message-ID: <pan.2005.04.04.16.38.04.98290@navi.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,

The following patch makes SOX work with the "aoss" program.

Unfortunately I originally wanted aoss for a game, zap!
(www.zapthegame.com) so I could listen to music using XMMS at the same
time as playing, but aoss+dmix introduces far too much latency for that.
It's on the order of a second or two for some reason. Do you know of any
fix?

[mike@littlegreen Zap-v1.166.0]$ cat /proc/asound/cards
0 [SI7012         ]: ICH - SiS SI7012
                     SiS SI7012 at 0xdc00, irq 11



thanks -mike

--- alsa-oss.c~ 2004-09-13 17:07:57.000000000 +0100
+++ alsa-oss.c  2005-02-13 00:02:37.710981560 +0000
@@ -62,6 +62,10 @@
 #endif
 #endif
=20
+#ifndef O_LARGEFILE
+#define O_LARGEFILE 0100000
+#endif
+
 int (*_select)(int n, fd_set *readfds, fd_set *writefds, fd_set *exceptf=
ds, struct timeval *timeout);
 int (*_poll)(struct pollfd *ufds, unsigned int nfds, int timeout);
 int (*_open)(const char *file, int oflag, ...);
@@ -689,32 +693,28 @@
=20
 #include "stdioemu.c"
=20
-FILE *fopen(const char* path, const char *mode) {
-
+FILE *fopen(const char* path, const char *mode)
+{
        if (!initialized)
                initialize();
=20
        if(!is_dsp_device(path))=20
                return _fopen (path, mode);
       =20
-       return fake_fopen(path, mode);
+       return fake_fopen(path, mode, 0);
+}
+
+FILE *fopen64(const char* path, const char *mode)
+{
+       if (!initialized)
+               initialize();
+
+       if(!is_dsp_device(path))=20
+               return _fopen (path, mode);
+
+       return fake_fopen(path, mode, O_LARGEFILE);
 }
=20
-#if 1
-# define strong_alias(name, aliasname) \
-  extern __typeof (name) aliasname __attribute__ ((alias (#name)));
-strong_alias(open, __open);
-strong_alias(close, __close);
-strong_alias(write, __write);
-strong_alias(read, __read);
-strong_alias(ioctl, __ioctl);
-strong_alias(fcntl, __fcntl);
-strong_alias(mmap, __mmap);
-strong_alias(munmap, __munmap);
-strong_alias(poll, __poll);
-strong_alias(select, __select);
-strong_alias(fopen, __fopen);
-#else
 int dup(int fd)
 {
        return fcntl(fd, F_DUPFD, 0);
@@ -742,10 +742,6 @@
        return fcntl(fd, F_DUPFD, fd2);
 }
=20
-#ifndef O_LARGEFILE
-#define O_LARGEFILE 0100000
-#endif
-
 int open64(const char *file, int oflag, ...)
 {
        va_list args;
@@ -758,10 +754,25 @@
        }
        return open(file, oflag | O_LARGEFILE, mode);
 }
-#endif
=20
-static void initialize() __attribute__ ((constructor));
+# define strong_alias(name, aliasname) \
+  extern __typeof (name) aliasname __attribute__ ((alias (#name)));
+
+strong_alias(open, __open);
+strong_alias(open64, __open64);
+strong_alias(close, __close);
+strong_alias(write, __write);
+strong_alias(read, __read);
+strong_alias(ioctl, __ioctl);
+strong_alias(fcntl, __fcntl);
+strong_alias(mmap, __mmap);
+strong_alias(munmap, __munmap);
+strong_alias(poll, __poll);
+strong_alias(select, __select);
+strong_alias(fopen, __fopen);
+strong_alias(fopen64, __fopen64);
=20
+/* called by each override if needed */
 static void initialize()
 {
        char *s =3D getenv("ALSA_OSS_DEBUG");
--- stdioemu.c~ 2004-06-25 17:26:51.000000000 +0100
+++ stdioemu.c  2005-02-12 23:26:28.000000000 +0000
@@ -1,4 +1,4 @@
-    /*
+/*
=20
     Copyright (C) 2000 Stefan Westerfeld
                        stefan@space.twc.de
@@ -18,7 +18,8 @@
     the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
     Boston, MA 02111-1307, USA.
=20
-    */
+    Modified to add support for 64 bit fopen by Mike Hearn <mike@navi.cx=
>
+*/
=20
 /*
  * This source only exists because some very special programs think that
@@ -67,7 +68,7 @@
        return result;
 }
=20
-static FILE *fake_fopen(const char *path, const char *mode)
+static FILE *fake_fopen(const char *path, const char *mode, int flags)
 {
        cookie_io_functions_t fns =3D { fdc_read, fdc_write, fdc_seek, fd=
c_clean };
        struct fd_cookie *fdc =3D
@@ -83,9 +84,9 @@
                if(*mptr =3D=3D '+') open_mode |=3D 3; /* 3 =3D readwrite=
 */
                if(*mptr =3D=3D 'a') open_mode |=3D 2; /* append -> write=
 */
        }
-       if(open_mode =3D=3D 1) fdc->fd =3D open(path,O_RDONLY,0666);
-       if(open_mode =3D=3D 2) fdc->fd =3D open(path,O_WRONLY,0666);
-       if(open_mode =3D=3D 3) fdc->fd =3D open(path,O_RDWR,0666);
+       if(open_mode =3D=3D 1) fdc->fd =3D open(path, O_RDONLY | flags, 0=
666);
+       if(open_mode =3D=3D 2) fdc->fd =3D open(path, O_WRONLY | flags, 0=
666);
+       if(open_mode =3D=3D 3) fdc->fd =3D open(path, O_RDWR | flags, 066=
6);
=20
        if(open_mode && fdc->fd > 0)
        {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
