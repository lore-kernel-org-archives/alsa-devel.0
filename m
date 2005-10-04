From: Eric Shattow <lucent@gmail.com>
Subject: [patch] Add ID for Hercules PC DJ Console (Windows Edition)
Date: Tue, 4 Oct 2005 04:52:57 -0500
Message-ID: <2c746f620510040252o4f7eb7d6s2a28a3b99a0e0ce8@mail.gmail.com>
Reply-To: Eric Shattow <lucent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

The following patch is against today's CVS code.

jnc@baker:~/buildage/alsadriver/cvsish$ diff -burNw
alsa-kernel/usb/usbmixer_maps.c~orig alsa-kernel/usb/usbmixer_maps.c
--- alsa-kernel/usb/usbmixer_maps.c~orig        2005-09-16
10:56:01.000000000 -0500
+++ alsa-kernel/usb/usbmixer_maps.c     2005-10-04 04:03:26.000000000 -0500
@@ -238,11 +238,16 @@
                .selector_map =3D audigy2nx_selectors,
        },
        {
-               /* Hercules DJ Console */
+               /* Hercules DJ Console (Macintosh Edition) */
                .id =3D USB_ID(0x06f8, 0xd002),
                .ignore_ctl_error =3D 1,
        },
        {
+               /* Hercules DJ Console (Windows Edition) */
+               .id =3D USB_ID(0x06f8, 0xb000),
+               .ignore_ctl_error =3D 1,
+       },
+       {
                .id =3D USB_ID(0x08bb, 0x2702),
                .map =3D linex_map,
                .ignore_ctl_error =3D 1,


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
