From: Jordi Mallach <jordi@debian.org>
Subject: Two Debian patches
Date: Fri, 7 Mar 2003 14:14:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030307131444.GA5256@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
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


--K8nIJk4ghYZn606h
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Attached are:

- a patch to quiet down a hell lot of warnings when compiling alsa
  against 2.4.20 with the XFS patch.
- a manpage for alsaconf.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="08_vmap_vunmap_calls.dpatch"
Content-Transfer-Encoding: quoted-printable

#! /bin/sh -e

# 08_vmap_vunmap_calls.dpatch by Steve Kowalik
#
# DP: Undefine vmap, vunmap; replace calls to them.

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

--- alsa-driver/include/adriver.h	1 Feb 2003 11:09:21 -0000	1.1.1.2
+++ alsa-driver/include/adriver.h	20 Feb 2003 12:43:42 -0000
@@ -320,11 +320,11 @@
 #endif /* 2.5.0 */
=20
 /* vmap/vunmap wrappers */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+/* #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) */
 /* 2.4 kernels with xfs patch have the following, but we don't use them an=
yway... */
-#define vmap(array,pages) remap_page_array(array,pages,0)
-#define vunmap(ptr) vfree_nocheck(ptr)
-#endif /* 2.5.0 */
+/* #define vmap(array,pages) remap_page_array(array,pages,0)
+#define vunmap(ptr) vfree_nocheck(ptr) */
+/* #endif 2.5.0 */
=20
 /* vmalloc_to_page wrapper */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 19)
--- alsa-driver/alsa-kernel/core/pcm_sgbuf.c	1 Feb 2003 11:13:05 -0000	1.1.=
1.2
+++ alsa-driver/alsa-kernel/core/pcm_sgbuf.c	20 Feb 2003 12:43:42 -0000
@@ -109,7 +109,7 @@
 	}
=20
 	sgbuf->size =3D size;
-	vmaddr =3D vmap(sgbuf->page_table, sgbuf->pages);
+	vmaddr =3D remap_page_array(sgbuf->page_table, sgbuf->pages, 0);
 	if (! vmaddr)
 		goto _failed;
 	return vmaddr;
@@ -133,7 +133,7 @@
 int snd_pcm_sgbuf_free_pages(struct snd_sg_buf *sgbuf, void *vmaddr)
 {
 	if (vmaddr)
-		vunmap(vmaddr);
+		vfree_nocheck(vmaddr);
=20
 	while (sgbuf->pages > 0) {
 		sgbuf->pages--;

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsaconf.8"
Content-Transfer-Encoding: quoted-printable

=2E\"                                      Hey, EMACS: -*- nroff -*-
=2E\" alsaconf.8 is copyright 2003 by Jordi Mallach <jordi@debian.org>
=2E\"=20
=2E\" This is free documentation, see the latest version of the GNU
=2E\" General Public License for copying conditions. There is NO warranty.
=2ETH ALSACONF 8 "February 23, 2003"

=2ESH NAME
alsaconf \- configuration tool for the Advanced Linux Sound Architecture

=2ESH SYNOPSIS
=2EB alsaconf
=2ERI [ options ]

=2ESH DESCRIPTION
This manual page documents briefly the
=2EB alsaconf
command.
This manual page was written for the Debian distribution because the
original program does not have a manual page.
=2EPP
\fBAlsaconf\fP is a simple shell script which tries to detect the sound car=
ds
on your system and writes a suitable configuration file for ALSA. It will t=
ry
to guess what GNU/Linux distribution you're running, and will act according=
ly
to the standards of that distribution, if specific support is available.
=2EPP
Alsaconf will write a modutils snippet which can be then used by modutils
to load the correct parameters for your sound card.

=2ESH OPTIONS
Alsaconf accepts the following options:
=2ETP
=2EB \-l, \-\-legacy
Check only for legacy non-isapnp cards
=2ETP
=2EB \-m, \-\-modinfo
Read module descriptions instead of reading a card database.
=2ETP
=2EB \-s, \-\-sound\-wav\-file
Use the specified wav file as a test sound
=2ETP
=2EB \-u, \-\-uid uid
Set the uid for the ALSA devices (default =3D 0)
=2ETP
=2EB \-g, \-\-gid gid
Set the gid for the ALSA devices (default =3D 0)
=2ETP
=2EB \-d, \-\-devmode mode
Set the device mode for the ALSA devices (default =3D 0666)
=2ETP
=2EB \-r, \-\-strict
Set strict device mode (equiv. with -g 17 -d 0660)
=2ETP
=2EB \-L, \-\-log
Logging on /tmp/alsaconf.log
=2ETP
=2EB \-p, \-\-probe card-name
Probe a legacy non-isapnp card and print module options
=2ETP
=2EB \-h, \-\-help
Displays this help text

=2ESH DEBIAN SPECIFIC
In Debian, the default gid of the device files is 29 (corresponding to the
audio group) and the default device mode is 0660.

=2ESH SEE ALSO
=2EI /usr/share/doc/alsa-base/

=2ESH HOMEPAGE
http://www.alsa-project.org/

=2ESH AUTHOR
This manual page was written by Jordi Mallach <jordi@debian.org>,
for the Debian system (but may be used by others).

--17pEHd4RhPHOinZp--

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+aJtEJYSUupF6Il4RAicEAKDqn211E5Abif5HoLWkNqDC2c8ANwCfalye
mti/bV+SQMmoZKH454OLE54=
=OcmM
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
