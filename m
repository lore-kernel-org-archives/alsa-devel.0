From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH] fix volume control for the AK4358 DAC
Date: Tue, 22 Aug 2006 21:00:10 +0100
Message-ID: <20060822200009.GC3025@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1110721605=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1110721605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix volume control for the AK4358 DAC.

The attenuation control registers of the AK4358 use only 7bit for the
volume, the msb is used to enable attenuation output.  Without this
patch there are 256 volume levels the lower 128 of which are mute.

Signed-off-by: Jochen Voss <voss@seehuhn.de>


diff -ur alsa-driver-1.0.12rc3.orig/alsa-kernel/i2c/other/ak4xxx-adda.c als=
a-driver-1.0.12rc3/alsa-kernel/i2c/other/ak4xxx-adda.c
--- alsa-driver-1.0.12rc3.orig/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-08-=
14 11:55:24.000000000 +0100
+++ alsa-driver-1.0.12rc3/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-08-22 20=
:46:42.000000000 +0100
@@ -285,10 +285,12 @@
 #define AK_GET_CHIP(val)		(((val) >> 8) & 0xff)
 #define AK_GET_ADDR(val)		((val) & 0xff)
 #define AK_GET_SHIFT(val)		(((val) >> 16) & 0x7f)
+#define AK_GET_NEEDSMSB(val)		(((val) >> 22) & 1)
 #define AK_GET_INVERT(val)		(((val) >> 23) & 1)
 #define AK_GET_MASK(val)		(((val) >> 24) & 0xff)
 #define AK_COMPOSE(chip,addr,shift,mask) \
 	(((chip) << 8) | (addr) | ((shift) << 16) | ((mask) << 24))
+#define AK_NEEDSMSB 			(1<<22)
 #define AK_INVERT 			(1<<23)
=20
 static int snd_akm4xxx_volume_info(struct snd_kcontrol *kcontrol,
@@ -309,10 +311,13 @@
 	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
 	int chip =3D AK_GET_CHIP(kcontrol->private_value);
 	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int needsmsb =3D AK_GET_NEEDSMSB(kcontrol->private_value);
 	int invert =3D AK_GET_INVERT(kcontrol->private_value);
 	unsigned int mask =3D AK_GET_MASK(kcontrol->private_value);
 	unsigned char val =3D snd_akm4xxx_get(ak, chip, addr);
-=09
+
+	if (needsmsb)
+		val &=3D 0x7f;
 	ucontrol->value.integer.value[0] =3D invert ? mask - val : val;
 	return 0;
 }
@@ -323,6 +328,7 @@
 	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
 	int chip =3D AK_GET_CHIP(kcontrol->private_value);
 	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int needsmsb =3D AK_GET_NEEDSMSB(kcontrol->private_value);
 	int invert =3D AK_GET_INVERT(kcontrol->private_value);
 	unsigned int mask =3D AK_GET_MASK(kcontrol->private_value);
 	unsigned char nval =3D ucontrol->value.integer.value[0] % (mask+1);
@@ -330,6 +336,8 @@
=20
 	if (invert)
 		nval =3D mask - nval;
+	if (needsmsb)
+		nval |=3D 0x80;
 	change =3D snd_akm4xxx_get(ak, chip, addr) !=3D nval;
 	if (change)
 		snd_akm4xxx_write(ak, chip, addr, nval);
@@ -354,13 +362,19 @@
 	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
 	int chip =3D AK_GET_CHIP(kcontrol->private_value);
 	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int needsmsb =3D AK_GET_NEEDSMSB(kcontrol->private_value);
 	int invert =3D AK_GET_INVERT(kcontrol->private_value);
 	unsigned int mask =3D AK_GET_MASK(kcontrol->private_value);
-	unsigned char val =3D snd_akm4xxx_get(ak, chip, addr);
-=09
+	unsigned char val;
+
+	val =3D snd_akm4xxx_get(ak, chip, addr);
+	if (needsmsb)
+		val &=3D 0x7f;
 	ucontrol->value.integer.value[0] =3D invert ? mask - val : val;
=20
 	val =3D snd_akm4xxx_get(ak, chip, addr+1);
+	if (needsmsb)
+		val &=3D 0x7f;
 	ucontrol->value.integer.value[1] =3D invert ? mask - val : val;
=20
 	return 0;
@@ -372,6 +386,7 @@
 	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
 	int chip =3D AK_GET_CHIP(kcontrol->private_value);
 	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int needsmsb =3D AK_GET_NEEDSMSB(kcontrol->private_value);
 	int invert =3D AK_GET_INVERT(kcontrol->private_value);
 	unsigned int mask =3D AK_GET_MASK(kcontrol->private_value);
 	unsigned char nval =3D ucontrol->value.integer.value[0] % (mask+1);
@@ -379,6 +394,8 @@
=20
 	if (invert)
 		nval =3D mask - nval;
+	if (needsmsb)
+		nval |=3D 0x80;
 	change0 =3D snd_akm4xxx_get(ak, chip, addr) !=3D nval;
 	if (change0)
 		snd_akm4xxx_write(ak, chip, addr, nval);
@@ -386,6 +403,8 @@
 	nval =3D ucontrol->value.integer.value[1] % (mask+1);
 	if (invert)
 		nval =3D mask - nval;
+	if (needsmsb)
+		nval |=3D 0x80;
 	change1 =3D snd_akm4xxx_get(ak, chip, addr+1) !=3D nval;
 	if (change1)
 		snd_akm4xxx_write(ak, chip, addr+1, nval);
@@ -585,16 +604,13 @@
 			/* register 4-9, chip #0 only */
 			ctl->private_value =3D AK_COMPOSE(0, idx + 4, 0, 255);
 			break;
-		case SND_AK4358:
-			if (idx >=3D 6)
-				/* register 4-9, chip #0 only */
-				ctl->private_value =3D
-					AK_COMPOSE(0, idx + 5, 0, 255);
-			else
-				/* register 4-9, chip #0 only */
-				ctl->private_value =3D
-					AK_COMPOSE(0, idx + 4, 0, 255);
+		case SND_AK4358: {
+			/* register 4-9 and 11-12, chip #0 only */
+			int  addr =3D idx < 6 ? idx + 4 : idx + 5;
+			ctl->private_value =3D
+				AK_COMPOSE(0, addr, 0, 127) | AK_NEEDSMSB;
 			break;
+		}
 		case SND_AK4381:
 			/* register 3 & 4 */
 			ctl->private_value =3D

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE62JJf+iD8yEbECURAs9hAJ4wZRI1q98EjmjV9LaHJshGFOJ1TwCfQaF5
jG2tcGWJiayE3eFaGqM6loM=
=MxsK
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--


--===============1110721605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1110721605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1110721605==--
