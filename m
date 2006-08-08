From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH] complete the AK5365 support
Date: Tue, 8 Aug 2006 23:59:09 +0100
Message-ID: <20060808225908.GA22724@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1669476636=="
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


--===============1669476636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Complete the AK5365 support.

This adds a boolean control to toggle the soft mute feature of the
AK5365 chip.

Signed-off-by: Jochen Voss <voss@seehuhn.de>


diff -ur alsa-driver-1.0.12rc2.orig/alsa-kernel/i2c/other/ak4xxx-adda.c als=
a-driver-1.0.12rc2/alsa-kernel/i2c/other/ak4xxx-adda.c
--- alsa-driver-1.0.12rc2.orig/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-08-=
08 21:54:30.000000000 +0100
+++ alsa-driver-1.0.12rc2/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-08-08 23=
:51:31.000000000 +0100
@@ -472,6 +472,57 @@
 	return change;
 }
=20
+static int ak4xxx_switch_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 1;
+	return 0;
+}
+
+static int ak4xxx_switch_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int chip =3D AK_GET_CHIP(kcontrol->private_value);
+	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int shift =3D AK_GET_SHIFT(kcontrol->private_value);
+	int invert =3D AK_GET_INVERT(kcontrol->private_value);
+	unsigned char val =3D snd_akm4xxx_get(ak, chip, addr);
+
+	if (invert)
+		val =3D ! val;
+	ucontrol->value.integer.value[0] =3D (val & (1<<shift)) !=3D 0;
+	return 0;
+}
+
+static int ak4xxx_switch_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int chip =3D AK_GET_CHIP(kcontrol->private_value);
+	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int shift =3D AK_GET_SHIFT(kcontrol->private_value);
+	int invert =3D AK_GET_INVERT(kcontrol->private_value);
+	long flag =3D ucontrol->value.integer.value[0];
+	unsigned char val, oval;
+	int change;
+
+	if (invert)
+		flag =3D ! flag;
+	oval =3D snd_akm4xxx_get(ak, chip, addr);
+	if (flag)
+		val =3D oval | (1<<shift);
+	else
+		val =3D oval & ~(1<<shift);
+	change =3D (oval !=3D val);
+	if (change)
+		snd_akm4xxx_write(ak, chip, addr, val);
+	return change;
+}
+
 /*
  * build AK4xxx controls
  */
@@ -621,6 +672,27 @@
 					      SNDRV_CTL_ELEM_ACCESS_WRITE));
 		if (err < 0)
 			goto __error;
+
+		memset(ctl, 0, sizeof(*ctl));
+		if (ak->channel_names =3D=3D NULL)
+			strcpy(ctl->id.name, "Capture Switch");
+		else
+			strcpy(ctl->id.name, ak->channel_names[1]);
+		ctl->id.index =3D ak->idx_offset * 2;
+		ctl->id.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
+		ctl->count =3D 1;
+		ctl->info =3D ak4xxx_switch_info;
+		ctl->get =3D ak4xxx_switch_get;
+		ctl->put =3D ak4xxx_switch_put;
+		/* register 2, bit 0 (SMUTE): 0 =3D normal operation, 1 =3D mute */
+		ctl->private_value =3D
+			AK_COMPOSE(0, 2, 0, 0) | AK_INVERT;
+		ctl->private_data =3D ak;
+		err =3D snd_ctl_add(ak->card,
+				  snd_ctl_new(ctl, SNDRV_CTL_ELEM_ACCESS_READ|
+					      SNDRV_CTL_ELEM_ACCESS_WRITE));
+		if (err < 0)
+			goto __error;
 	}
=20
 	if (ak->type =3D=3D SND_AK4355 || ak->type =3D=3D SND_AK4358)
diff -ur alsa-driver-1.0.12rc2.orig/alsa-kernel/pci/ice1712/revo.c alsa-dri=
ver-1.0.12rc2/alsa-kernel/pci/ice1712/revo.c
--- alsa-driver-1.0.12rc2.orig/alsa-kernel/pci/ice1712/revo.c	2006-08-08 21=
:54:31.000000000 +0100
+++ alsa-driver-1.0.12rc2/alsa-kernel/pci/ice1712/revo.c	2006-08-08 23:37:2=
6.000000000 +0100
@@ -99,7 +99,7 @@
 					"PCM LFE Playback Volume", "PCM Rear Playback Volume"};
=20
 static unsigned int revo51_adc_num_stereo[] =3D {2};
-static char *revo51_adc_channel_names[] =3D {"PCM Capture Volume"};
+static char *revo51_adc_channel_names[] =3D {"PCM Capture Volume","PCM Cap=
ture Switch"};
=20
 static struct snd_akm4xxx akm_revo_front __devinitdata =3D {
 	.type =3D SND_AK4381,

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2Rc8f+iD8yEbECURAvt+AKCa/VqTANqDAWnuvaZgnBpOD1AxOwCgsV9F
rfSWqQaGSQP+GOezhKlyMx8=
=kXJq
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


--===============1669476636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1669476636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1669476636==--
