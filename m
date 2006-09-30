From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH] add a capture source select for Revolution 5.1
Date: Sat, 30 Sep 2006 20:29:32 +0100
Message-ID: <20060930192931.GA5732@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2091959537=="
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


--===============2091959537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add capture source selection for the M-Audio Revolution 5.1.

The AK5365 ADC, used for the Revolution 5.1 card, allows to choose
between different input sources.  This patch adds a new mixer element
to support this.

Signed-off-by: Jochen Voss <voss@seehuhn.de>

---

This addresses the first item in my recent "M-Audio Revolution 5.1 -
new hardware information" email.  Comments are very welcome.
Especially I am not sure whether I feed the list of mixer channel
names into 'ak4xxx_capture_source_info' the right way.

I tested the patch and it works for me.

diff -ur alsa-driver-hg20060929.orig/alsa-kernel/i2c/other/ak4xxx-adda.c al=
sa-driver-hg20060929/alsa-kernel/i2c/other/ak4xxx-adda.c
--- alsa-driver-hg20060929.orig/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-09=
-09 01:00:11.000000000 +0100
+++ alsa-driver-hg20060929/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-09-30 2=
0:06:33.896394618 +0100
@@ -513,6 +513,62 @@
 	return change;
 }
=20
+static int ak4xxx_capture_source_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	const char **input_names;
+	int  num_names, idx;
+
+	input_names =3D ak->adc_info[0].input_names;
+
+	num_names =3D 0;
+	while (num_names<8 && input_names[num_names])
+		++num_names;
+=09
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count =3D 1;
+	uinfo->value.enumerated.items =3D num_names;
+	idx =3D uinfo->value.enumerated.item;
+	if (idx >=3D num_names)
+		idx =3D num_names - 1;
+	strncpy(uinfo->value.enumerated.name, input_names[idx], 64);
+	return 0;
+}
+
+static int ak4xxx_capture_source_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int chip =3D AK_GET_CHIP(kcontrol->private_value);
+	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int shift =3D AK_GET_SHIFT(kcontrol->private_value);
+	int mask =3D AK_GET_MASK(kcontrol->private_value);
+	unsigned char val;
+
+	val =3D (snd_akm4xxx_get(ak, chip, addr)&mask) >> shift;
+        ucontrol->value.enumerated.item[0] =3D val;
+	return 0;
+}
+
+static int ak4xxx_capture_source_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int chip =3D AK_GET_CHIP(kcontrol->private_value);
+	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int shift =3D AK_GET_SHIFT(kcontrol->private_value);
+	int mask =3D AK_GET_MASK(kcontrol->private_value);
+	unsigned char oval, val;
+
+	oval =3D snd_akm4xxx_get(ak, chip, addr);
+	val =3D oval & ~mask;
+	val |=3D (ucontrol->value.enumerated.item[0] << shift)&mask;
+	if (val !=3D oval)
+		snd_akm4xxx_write(ak, chip, addr, val);
+	return 0;
+}
+
 /*
  * build AK4xxx controls
  */
@@ -662,6 +718,24 @@
 			err =3D snd_ctl_add(ak->card, snd_ctl_new1(&knew, ak));
 			if (err < 0)
 				return err;
+
+			memset(&knew, 0, sizeof(knew));
+			knew.name =3D ak->adc_info[mixer_ch].selector_name;
+			if (! knew.name)
+				knew.name =3D "Capture Source Select";
+		=09
+			knew.index =3D mixer_ch;
+			knew.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
+			knew.info =3D ak4xxx_capture_source_info;
+			knew.get =3D ak4xxx_capture_source_get;
+			knew.put =3D ak4xxx_capture_source_put;
+			knew.access =3D 0;
+			/* input selector control: reg. 1, bits 0-2 */
+			knew.private_value
+				=3D AK_COMPOSE(idx/2, 1, 0, 0x07);
+			err =3D snd_ctl_add(ak->card, snd_ctl_new1(&knew, ak));
+			if (err < 0)
+				return err;
 		}
=20
 		idx +=3D num_stereo;
diff -ur alsa-driver-hg20060929.orig/alsa-kernel/include/ak4xxx-adda.h alsa=
-driver-hg20060929/alsa-kernel/include/ak4xxx-adda.h
--- alsa-driver-hg20060929.orig/alsa-kernel/include/ak4xxx-adda.h	2006-09-0=
9 01:00:11.000000000 +0100
+++ alsa-driver-hg20060929/alsa-kernel/include/ak4xxx-adda.h	2006-09-30 20:=
04:16.412394092 +0100
@@ -50,6 +50,8 @@
 	char *name;		/* capture gain volume label */
 	char *switch_name;	/* capture switch */
 	unsigned int num_channels;
+	char *selector_name;	/* capture source select label */
+	const char **input_names; /* capture source names (NULL terminated) */
 };
=20
 struct snd_akm4xxx {
diff -ur alsa-driver-hg20060929.orig/alsa-kernel/pci/ice1712/revo.c alsa-dr=
iver-hg20060929/alsa-kernel/pci/ice1712/revo.c
--- alsa-driver-hg20060929.orig/alsa-kernel/pci/ice1712/revo.c	2006-09-09 0=
1:00:11.000000000 +0100
+++ alsa-driver-hg20060929/alsa-kernel/pci/ice1712/revo.c	2006-09-30 20:07:=
50.121335700 +0100
@@ -107,11 +107,19 @@
 	AK_DAC("PCM Rear Playback Volume", 2),
 };
=20
+const char *revo51_adc_input_names[] =3D {
+	"Mic",
+	"Line",
+	"CD",
+	NULL
+};
+
 static struct snd_akm4xxx_adc_channel revo51_adc[] =3D {
 	{
 		.name =3D "PCM Capture Volume",
 		.switch_name =3D "PCM Capture Switch",
-		.num_channels =3D 2
+		.num_channels =3D 2,
+		.input_names =3D revo51_adc_input_names
 	},
 };
=20

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHsWbf+iD8yEbECURAt6fAJ9P+u5LxFpxdkVIKKup6ZUPW+r6DACgi67P
H9BnixyZjjr09HGF9wt3dqI=
=7oZX
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


--===============2091959537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2091959537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2091959537==--
