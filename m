From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH try2 1/2] enable capture from line-in and CD on
	Revolution 5.1
Date: Wed, 4 Oct 2006 12:18:47 +0100
Message-ID: <20061004111847.GA2395@tarte.seehuhn.de>
References: <20061003232655.GA1871@tarte.seehuhn.de>
	<20061003232755.GB1871@tarte.seehuhn.de>
	<s5h8xjwl5u2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2143295966=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xjwl5u2.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============2143295966==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enable capture from line-in and CD on the Revolution 5.1 card.

This patch adds support for switching between the 5 input channels of
the AK5365 ADC and modifies the Revolution 5.1 driver to make use of
this facility.  Previously the capture channel was fixed to channel 0
(microphone on the Revolution 5.1 card).

Signed-off-by: Jochen Voss <voss@seehuhn.de>
---

Hi Takashi,

thanks for reviewing.  A fixed patch is below.

On Wed, Oct 04, 2006 at 12:43:01PM +0200, Takashi Iwai wrote:
> > +	while (num_names<5 && input_names[num_names])
>=20
> White space around '<', and define a constant for 5, please.

fixed

> > +	if (idx >=3D num_names) return -1;
>=20
> Break a line, and return a meaningful error code, e.g. -EINVAL.

ok

> > +	val =3D snd_akm4xxx_get(ak, chip, addr)&mask;
>=20
> Put spaces around '&'.

fixed in two places

> > +        ucontrol->value.enumerated.item[0] =3D val;
>=20
> Indentation?

changed eight spaces into a tab

> > +	if (val !=3D oval)
> > +		snd_akm4xxx_write(ak, chip, addr, val);
> > +	return 0;
>=20
> The put callback should return 1 if the value is changed and 0 if the
> value is unchanged.  That is, such as:
>=20
> 	if (val !=3D oval) {
> 		snd_akm4xxx_write(ak, chip, addr, val);
> 		return 1;
> 	}
> 	return 0;

fixed

> >  		if (ak->type =3D=3D SND_AK5365 && (idx % 2) =3D=3D 0) {
> >  			if (! ak->adc_info ||=20
> > -			    ! ak->adc_info[mixer_ch].switch_name)
> > +			    ! ak->adc_info[mixer_ch].switch_name) {
> >  				knew.name =3D "Capture Switch";
> > -			else
> > +				knew.index =3D mixer_ch + ak->idx_offset * 2;
> > +			} else {
> >  				knew.name =3D ak->adc_info[mixer_ch].switch_name;
> > +			}
>=20
> Don't put braces around a single-line if.

I found it ugly to have braces around the two line if branch but no
braces around the one line else branch.  But I fixed it anyway.

---

diff -ur alsa-driver-hg20060929.orig/alsa-kernel/i2c/other/ak4xxx-adda.c al=
sa-driver-hg20060929.p1/alsa-kernel/i2c/other/ak4xxx-adda.c
--- alsa-driver-hg20060929.orig/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-09=
-09 01:00:11.000000000 +0100
+++ alsa-driver-hg20060929.p1/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-10-0=
4 12:04:49.189233848 +0100
@@ -513,6 +513,66 @@
 	return change;
 }
=20
+#define AK5365_NUM_INPUTS 5
+
+static int ak4xxx_capture_source_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int mixer_ch =3D AK_GET_SHIFT(kcontrol->private_value);
+	const char **input_names;
+	int  num_names, idx;
+
+	input_names =3D ak->adc_info[mixer_ch].input_names;
+
+	num_names =3D 0;
+	while (num_names < AK5365_NUM_INPUTS && input_names[num_names])
+		++num_names;
+=09
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count =3D 1;
+	uinfo->value.enumerated.items =3D num_names;
+	idx =3D uinfo->value.enumerated.item;
+	if (idx >=3D num_names)
+		return -EINVAL;
+	strncpy(uinfo->value.enumerated.name, input_names[idx],
+		sizeof(uinfo->value.enumerated.name));
+	return 0;
+}
+
+static int ak4xxx_capture_source_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int chip =3D AK_GET_CHIP(kcontrol->private_value);
+	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int mask =3D AK_GET_MASK(kcontrol->private_value);
+	unsigned char val;
+
+	val =3D snd_akm4xxx_get(ak, chip, addr) & mask;
+	ucontrol->value.enumerated.item[0] =3D val;
+	return 0;
+}
+
+static int ak4xxx_capture_source_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_akm4xxx *ak =3D snd_kcontrol_chip(kcontrol);
+	int chip =3D AK_GET_CHIP(kcontrol->private_value);
+	int addr =3D AK_GET_ADDR(kcontrol->private_value);
+	int mask =3D AK_GET_MASK(kcontrol->private_value);
+	unsigned char oval, val;
+
+	oval =3D snd_akm4xxx_get(ak, chip, addr);
+	val =3D oval & ~mask;
+	val |=3D ucontrol->value.enumerated.item[0] & mask;
+	if (val !=3D oval) {
+		snd_akm4xxx_write(ak, chip, addr, val);
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * build AK4xxx controls
  */
@@ -647,9 +707,10 @@
=20
 		if (ak->type =3D=3D SND_AK5365 && (idx % 2) =3D=3D 0) {
 			if (! ak->adc_info ||=20
-			    ! ak->adc_info[mixer_ch].switch_name)
+			    ! ak->adc_info[mixer_ch].switch_name) {
 				knew.name =3D "Capture Switch";
-			else
+				knew.index =3D mixer_ch + ak->idx_offset * 2;
+			} else
 				knew.name =3D ak->adc_info[mixer_ch].switch_name;
 			knew.info =3D ak4xxx_switch_info;
 			knew.get =3D ak4xxx_switch_get;
@@ -662,6 +723,26 @@
 			err =3D snd_ctl_add(ak->card, snd_ctl_new1(&knew, ak));
 			if (err < 0)
 				return err;
+
+			memset(&knew, 0, sizeof(knew));
+			knew.name =3D ak->adc_info[mixer_ch].selector_name;
+			if (! knew.name) {
+				knew.name =3D "Capture Channel";
+				knew.index =3D mixer_ch + ak->idx_offset * 2;
+			}
+
+			knew.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
+			knew.info =3D ak4xxx_capture_source_info;
+			knew.get =3D ak4xxx_capture_source_get;
+			knew.put =3D ak4xxx_capture_source_put;
+			knew.access =3D 0;
+			/* input selector control: reg. 1, bits 0-2.
+			 * mis-use 'shift' to pass mixer_ch */
+			knew.private_value
+				=3D AK_COMPOSE(idx/2, 1, mixer_ch, 0x07);
+			err =3D snd_ctl_add(ak->card, snd_ctl_new1(&knew, ak));
+			if (err < 0)
+				return err;
 		}
=20
 		idx +=3D num_stereo;
diff -ur alsa-driver-hg20060929.orig/alsa-kernel/include/ak4xxx-adda.h alsa=
-driver-hg20060929.p1/alsa-kernel/include/ak4xxx-adda.h
--- alsa-driver-hg20060929.orig/alsa-kernel/include/ak4xxx-adda.h	2006-09-0=
9 01:00:11.000000000 +0100
+++ alsa-driver-hg20060929.p1/alsa-kernel/include/ak4xxx-adda.h	2006-10-03 =
20:37:46.940264000 +0100
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
iver-hg20060929.p1/alsa-kernel/pci/ice1712/revo.c
--- alsa-driver-hg20060929.orig/alsa-kernel/pci/ice1712/revo.c	2006-09-09 0=
1:00:11.000000000 +0100
+++ alsa-driver-hg20060929.p1/alsa-kernel/pci/ice1712/revo.c	2006-10-03 20:=
37:46.944264000 +0100
@@ -107,11 +107,19 @@
 	AK_DAC("PCM Rear Playback Volume", 2),
 };
=20
+static const char *revo51_adc_input_names[] =3D {
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

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFI5iXf+iD8yEbECURAr/VAJ9a5Rq0hFUWkY/XzWvYdMVq1i5ncwCfan6F
mpJsxfJlYYco/0yPVdF+sOo=
=89Rp
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--


--===============2143295966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2143295966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2143295966==--
