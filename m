From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH 2/2] Revolution 5.1 - register the AK5365
	ADC with ALSA
Date: Tue, 8 Aug 2006 20:00:15 +0100
Message-ID: <20060808190010.GC30577@tarte.seehuhn.de>
References: <20060808185758.GA30577@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0018611067=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060808185758.GA30577@tarte.seehuhn.de>
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


--===============0018611067==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enable capture support for the M-Audio Revolution 5.1 card,
by registering the ADC with ALSA.

Signed-off-by: Jochen Voss <voss@seehuhn.de>


diff -ur alsa-driver-1.0.12rc2.orig/alsa-kernel/pci/ice1712/revo.c alsa-dri=
ver-1.0.12rc2/alsa-kernel/pci/ice1712/revo.c
--- alsa-driver-1.0.12rc2.orig/alsa-kernel/pci/ice1712/revo.c	2006-08-04 13=
:41:25.000000000 +0100
+++ alsa-driver-1.0.12rc2/alsa-kernel/pci/ice1712/revo.c	2006-08-08 19:41:0=
0.000000000 +0100
@@ -98,6 +98,9 @@
 static char *revo51_channel_names[] =3D {"PCM Playback Volume", "PCM Cente=
r Playback Volume",
 					"PCM LFE Playback Volume", "PCM Rear Playback Volume"};
=20
+static unsigned int revo51_adc_num_stereo[] =3D {2};
+static char *revo51_adc_channel_names[] =3D {"PCM Capture Volume"};
+
 static struct snd_akm4xxx akm_revo_front __devinitdata =3D {
 	.type =3D SND_AK4381,
 	.num_dacs =3D 2,
@@ -159,7 +162,26 @@
 	.data_mask =3D VT1724_REVO_CDOUT,
 	.clk_mask =3D VT1724_REVO_CCLK,
 	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
-	.cs_addr =3D 0,
+	.cs_addr =3D VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.add_flags =3D VT1724_REVO_CCLK, /* high at init */
+	.mask_flags =3D 0,
+};
+
+static struct snd_akm4xxx akm_revo51_adc __devinitdata =3D {
+	.type =3D SND_AK5365,
+	.num_adcs =3D 2,
+	.num_stereo =3D revo51_adc_num_stereo,
+	.channel_names =3D revo51_adc_channel_names
+};
+
+static struct snd_ak4xxx_private akm_revo51_adc_priv __devinitdata =3D {
+	.caddr =3D 2,
+	.cif =3D 0,
+	.data_mask =3D VT1724_REVO_CDOUT,
+	.clk_mask =3D VT1724_REVO_CCLK,
+	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.cs_addr =3D VT1724_REVO_CS0 | VT1724_REVO_CS2,
 	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
 	.add_flags =3D VT1724_REVO_CCLK, /* high at init */
 	.mask_flags =3D 0,
@@ -202,9 +224,13 @@
 		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
 		break;
 	case VT1724_SUBDEVICE_REVOLUTION51:
-		ice->akm_codecs =3D 1;
+		ice->akm_codecs =3D 2;
 		if ((err =3D snd_ice1712_akm4xxx_init(ak, &akm_revo51, &akm_revo51_priv,=
 ice)) < 0)
 			return err;
+		err =3D snd_ice1712_akm4xxx_init(ak + 1, &akm_revo51_adc,
+					       &akm_revo51_adc_priv, ice);
+		if (err < 0)
+			return err;
 		/* unmute all codecs - needed! */
 		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
 		break;
diff -ur alsa-driver-1.0.12rc2.orig/alsa-kernel/pci/ice1712/revo.h alsa-dri=
ver-1.0.12rc2/alsa-kernel/pci/ice1712/revo.h
--- alsa-driver-1.0.12rc2.orig/alsa-kernel/pci/ice1712/revo.h	2006-08-04 13=
:41:25.000000000 +0100
+++ alsa-driver-1.0.12rc2/alsa-kernel/pci/ice1712/revo.h	2006-08-08 19:39:5=
9.000000000 +0100
@@ -42,7 +42,7 @@
 #define VT1724_REVO_CCLK	0x02
 #define VT1724_REVO_CDIN	0x04	/* not used */
 #define VT1724_REVO_CDOUT	0x08
-#define VT1724_REVO_CS0		0x10	/* not used */
+#define VT1724_REVO_CS0		0x10	/* AK5365 chipselect for Rev. 5.1 */
 #define VT1724_REVO_CS1		0x20	/* front AKM4381 chipselect */
 #define VT1724_REVO_CS2		0x40	/* surround AKM4355 chipselect */
 #define VT1724_REVO_MUTE	(1<<22)	/* 0 =3D all mute, 1 =3D normal operation=
 */

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2N86f+iD8yEbECURAtxXAJ9I4YNgvj63r4yCr7rRFZ3kuvCnGACgxIyd
fhvOJV6Uk0IyNzMZbEno6vk=
=+uas
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--


--===============0018611067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0018611067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0018611067==--
