From: Jordi Mallach <jordi@debian.org>
Subject: Old Debian patches
Date: Sat, 21 Dec 2002 16:17:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021221151722.GA26363@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
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
Cc: stevenk@debian.org, madkiss@madkiss.org
List-Id: alsa-devel@alsa-project.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

As promised, we've been trying to track down some of the old patches
lying around in our package for quite soem time. We'd like you guys to
see if they are still needed so you can apply them upstream, or we can
get rid of them.

Bug#141114: improper call to snd_power_lock in ppc (reported against
            beta12).

Jack Howarth reported:

> On debian ppc sid, the new alsa-source 0.9beta12-1 doesn't build
> the powermac sound driver properly. The current source has an
> improper call to snd_power_lock which has changed its api. Also
> the powermac driver builds with unresolved symbols for udelay
> and mdelay. The attached patch needs to be added to the current
> alsa-source 0.9+beta12 debian sources to resolve these issues.
> With this patch the powermac sound module builds and operates fine
> under Linux 2.4.19pre5.


--- alsa-driver-0.9.0rc5.orig/alsa-kernel/ppc/keywest.c Mon Feb 25 20:50:13=
 2002
+++ alsa-driver-0.9.0rc5/alsa-kernel/ppc/keywest.c      Sun May 12 20:56:25=
 2002
@@ -21,6 +21,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <linux/slab.h>

-----
Bug#167633: usbaudio fails to build on 2.2 kernels (reported against
            rc5)

Aaron M. Ucko provided the following fix:


--- /usr/src/modules/alsa-driver/usb/usbaudio.c~        2002-10-10 08:25:03=
.0000
+++ /usr/src/modules/alsa-driver/usb/usbaudio.c 2002-11-03 19:43:22.0000000=
00 -0
@@ -171,6 +171,7 @@
=20
 void snd_compat_usb_driver_claim_interface(struct snd_compat_usb_driver *d=
river
 {
+       struct snd_usb_reg_table *tbl; =20
        if ((tbl =3D find_matchingUsb_driver(driver)) !=3D NULL)
                usb_driver_claim_interface(&tbl->driver, iface, ptr);
 }

-----
Bug#142693: depmod problem with provided isapnp (reported against
            beta12)

"K-Bay" reported:

> After initialisation of ALSA version 0.9b12 the depmod complains about
> problems in snd-isapnp module.
>=20
> The following patch should get rid of the problem:

--- isapnp.c    Sat Feb  9 19:30:13 2002
+++ isapnp.c.fix        Mon Apr  8 11:18:13 2002
@@ -2094,7 +2094,7 @@
 static void isapnp_release_resource(struct resource *res)
 {
        if (res) {
-               release_resource(res);
+               isapnp_release_resource(res);
                kfree(res);
        }
 }

We never got feedback from the user when we took over ALSA, so it was
never applied. I don't know if it's needed/valid.

That's all for the moment.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+BIYCJYSUupF6Il4RApCmAKCyhkly4JUWKjBxU0ynTSbnOWN13gCfbxTT
FQEFJoVDSnGjpGK7PztH74c=
=hOuV
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
