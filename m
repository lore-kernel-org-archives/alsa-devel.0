From: Jordi Mallach <jordi@debian.org>
Subject: USB fix
Date: Mon, 10 Mar 2003 12:31:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030310113115.GB6536@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
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
Cc: debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--nmemrqcdn5VTmUEE
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is the last thing we think we need to tell you guys about.

We need to apply this patch to rc7 and rc8 to get usb compiled. If we
don't apply it, we get the following:

gcc-2.95 -D__KERNEL__ -DMODULE=3D1 -I/tmp/modules/alsa-driver/include
-I/usr/src/kernel-headers-2.4.20-k7-smp/include -O2
-mpreferred-stack-boundary=3D2 -march=3Di686 -malign-functions=3D4 -D__SMP__
-DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-DKBUILD_BASENAME=3Dusbmidi   -c -o usbmidi.o usbmidi.c
In file included from usbaudio.c:2:
=2E./alsa-kernel/usb/usbaudio.c: At top level:
=2E./alsa-kernel/usb/usbaudio.c:1619: `usb_audio_probe' undeclared here (not
in a function)
=2E./alsa-kernel/usb/usbaudio.c:1619: initializer element is not constant
=2E./alsa-kernel/usb/usbaudio.c:1619: (near initialization for
`usb_audio_driver.probe')
=2E./alsa-kernel/usb/usbaudio.c:1620: `usb_audio_disconnect' undeclared here
(not in a function)
=2E./alsa-kernel/usb/usbaudio.c:1620: initializer element is not constant
=2E./alsa-kernel/usb/usbaudio.c:1620: (near initialization for
`usb_audio_driver.disconnect')
=2E./alsa-kernel/usb/usbaudio.c:1622: initializer element is not constant
=2E./alsa-kernel/usb/usbaudio.c:1622: (near initialization for
`usb_audio_driver.driver_list')
=2E./alsa-kernel/usb/usbaudio.c:1625: initializer element is not constant
=2E./alsa-kernel/usb/usbaudio.c:1625: (near initialization for
`usb_audio_driver')
=2E./alsa-kernel/usb/usbaudio.c:1625: initializer element is not constant
=2E./alsa-kernel/usb/usbaudio.c:1625: (near initialization for
`usb_audio_driver')
=2E./alsa-kernel/usb/usbaudio.c:1625: initializer element is not constant
=2E./alsa-kernel/usb/usbaudio.c:1625: (near initialization for
`usb_audio_driver')
=2E./alsa-kernel/usb/usbaudio.c:2456: warning: `snd_usb_audio_probe' defined
but not used
=2E./alsa-kernel/usb/usbaudio.c:2563: warning: `snd_usb_audio_disconnect'
defined but not used
make[2]: *** [usbaudio.o] Error 1

If we apply the attached patch, it works ok. What we wonder is if this
is something happening in Debian only, as I've seen no reports of this
on the list, which is suspicious.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="05_usbaudio_build_failure.dpatch"
Content-Transfer-Encoding: quoted-printable

#! /bin/sh -e

# 05_usbaudio_build_failure.dpatch by Steve Kowalik
#
# DP: Fix build failure in usb/usbaudio.c.

=2E debian/patches/patch-opts

if [ $# -ne 1 ]; then
    echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
    exit 1
fi
case "$1" in
    -patch) patch $patch_opts < $0;;
    -unpatch) patch $patch_opts -R < $0;;
    *)
        echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
        exit 1;;
esac

exit 0

--- alsa-driver/usb/usbaudio.c      28 Jan 2003 16:20:03 -0000      1.9
+++ alsa-driver/usb/usbaudio.c      2 Feb 2003 13:07:24 -0000
@@ -1,6 +1,44 @@
 #define SND_NEED_USB_WRAPPER
+#include <sound/driver.h>
+#include <linux/usb.h>
+
+#ifdef OLD_USB
+#define snd_usb_complete_callback(x) __old_ ## x
+static void __old_snd_complete_urb(struct urb *urb);
+static void __old_snd_complete_sync_urb(struct urb *urb);
+
+static void * usb_audio_probe(struct usb_device *dev, unsigned int ifnum,
+                              const struct usb_device_id *id);
+static void usb_audio_disconnect(struct usb_device *dev, void *ptr);
+#endif
+
 #include "../alsa-kernel/usb/usbaudio.c"
=20
+#ifdef OLD_USB
+/*
+ * 2.4 USB kernel API
+ */
+static void *usb_audio_probe(struct usb_device *dev, unsigned int ifnum,
+                            const struct usb_device_id *id)
+{
+       return snd_usb_audio_probe(dev, usb_ifnum_to_if(dev, ifnum), id);
+}
+                                      =20
+static void usb_audio_disconnect(struct usb_device *dev, void *ptr)
+{
+       snd_usb_audio_disconnect(dev, ptr);
+}
+
+static void __old_snd_complete_urb(struct urb *urb)
+{
+       snd_complete_urb(urb, NULL);
+}
+
+static void __old_snd_complete_sync_urb(struct urb *urb)
+{
+       snd_complete_sync_urb(urb, NULL);
+}
+#endif
=20
 /*
  * workarounds / hacks for the older kernels follow below


--PmA2V3Z32TCmWXqI--

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+bHeDJYSUupF6Il4RAiu0AJ9jKZiPAMfG8iOCy0UdM5A+iDv4awCgnXq+
r2fjZ/GvBDvQLMnZGpAxoB4=
=rvRw
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
