From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] ASoC: Allow 32bits registers
Date: Sun, 07 Jun 2009 02:49:11 -0300
Message-ID: <1244353751.9532.5.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3297608930607421337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id B06E3245AE
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Jun 2009 07:49:18 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3284389qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 06 Jun 2009 22:49:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: openezx-devel <openezx-devel@lists.openezx.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============3297608930607421337==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OVhKmfoo5PVlLprI1Oz0"


--=-OVhKmfoo5PVlLprI1Oz0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Replace the remaining unsigned shorts with unsigned ints.
Tested with pcap2 codec (25 bits registers).

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 include/sound/soc.h  |    4 ++--
 sound/soc/soc-core.c |   28 ++++++++++++++--------------
 sound/soc/soc-dapm.c |   16 ++++++++--------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a40bc6f..33b7de1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -212,9 +212,9 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack,=
 int count,
=20
 /* codec register bit access */
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value);
+				unsigned int mask, unsigned int value);
 int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value);
+				unsigned int mask, unsigned int value);
=20
 int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, int num);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1cd149b..c9f19d0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1262,10 +1262,10 @@ EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
  * Returns 1 for change else 0.
  */
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value)
+				unsigned int mask, unsigned int value)
 {
 	int change;
-	unsigned short old, new;
+	unsigned int old, new;
=20
 	mutex_lock(&io_mutex);
 	old =3D snd_soc_read(codec, reg);
@@ -1292,10 +1292,10 @@ EXPORT_SYMBOL_GPL(snd_soc_update_bits);
  * Returns 1 for change else 0.
  */
 int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned short mask, unsigned short value)
+				unsigned int mask, unsigned int value)
 {
 	int change;
-	unsigned short old, new;
+	unsigned int old, new;
=20
 	mutex_lock(&io_mutex);
 	old =3D snd_soc_read(codec, reg);
@@ -1580,7 +1580,7 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcon=
trol,
 {
 	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short val, bitmask;
+	unsigned int val, bitmask;
=20
 	for (bitmask =3D 1; bitmask < e->max; bitmask <<=3D 1)
 		;
@@ -1609,8 +1609,8 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcon=
trol,
 {
 	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short val;
-	unsigned short mask, bitmask;
+	unsigned int val;
+	unsigned int mask, bitmask;
=20
 	for (bitmask =3D 1; bitmask < e->max; bitmask <<=3D 1)
 		;
@@ -1646,7 +1646,7 @@ int snd_soc_get_value_enum_double(struct snd_kcontrol=
 *kcontrol,
 {
 	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short reg_val, val, mux;
+	unsigned int reg_val, val, mux;
=20
 	reg_val =3D snd_soc_read(codec, e->reg);
 	val =3D (reg_val >> e->shift_l) & e->mask;
@@ -1685,8 +1685,8 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol=
 *kcontrol,
 {
 	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short val;
-	unsigned short mask;
+	unsigned int val;
+	unsigned int mask;
=20
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -1846,7 +1846,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	int max =3D mc->max;
 	unsigned int mask =3D (1 << fls(max)) - 1;
 	unsigned int invert =3D mc->invert;
-	unsigned short val, val2, val_mask;
+	unsigned int val, val2, val_mask;
=20
 	val =3D (ucontrol->value.integer.value[0] & mask);
 	if (invert)
@@ -1912,7 +1912,7 @@ int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontro=
l,
 	unsigned int reg2 =3D mc->rreg;
 	unsigned int shift =3D mc->shift;
 	int max =3D mc->max;
-	unsigned int mask =3D (1<<fls(max))-1;
+	unsigned int mask =3D (1 << fls(max)) - 1;
 	unsigned int invert =3D mc->invert;
=20
 	ucontrol->value.integer.value[0] =3D
@@ -1952,7 +1952,7 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontro=
l,
 	unsigned int mask =3D (1 << fls(max)) - 1;
 	unsigned int invert =3D mc->invert;
 	int err;
-	unsigned short val, val2, val_mask;
+	unsigned int val, val2, val_mask;
=20
 	val_mask =3D mask << shift;
 	val =3D (ucontrol->value.integer.value[0] & mask);
@@ -2044,7 +2044,7 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontro=
l,
 	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
 	unsigned int reg =3D mc->reg;
 	int min =3D mc->min;
-	unsigned short val;
+	unsigned int val;
=20
 	val =3D (ucontrol->value.integer.value[0]+min) & 0xff;
 	val |=3D ((ucontrol->value.integer.value[1]+min) & 0xff) << 8;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 735903a..75c372f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -227,7 +227,7 @@ static int dapm_connect_mixer(struct snd_soc_codec *cod=
ec,
 static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 {
 	int change, power;
-	unsigned short old, new;
+	unsigned int old, new;
 	struct snd_soc_codec *codec =3D widget->codec;
=20
 	/* check for valid widgets */
@@ -1205,7 +1205,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcont=
rol,
 	int max =3D mc->max;
 	unsigned int mask =3D (1 << fls(max)) - 1;
 	unsigned int invert =3D mc->invert;
-	unsigned short val, val2, val_mask;
+	unsigned int val, val2, val_mask;
 	int ret;
=20
 	val =3D (ucontrol->value.integer.value[0] & mask);
@@ -1269,7 +1269,7 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol =
*kcontrol,
 {
 	struct snd_soc_dapm_widget *widget =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short val, bitmask;
+	unsigned int val, bitmask;
=20
 	for (bitmask =3D 1; bitmask < e->max; bitmask <<=3D 1)
 		;
@@ -1297,8 +1297,8 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol =
*kcontrol,
 {
 	struct snd_soc_dapm_widget *widget =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short val, mux;
-	unsigned short mask, bitmask;
+	unsigned int val, mux;
+	unsigned int mask, bitmask;
 	int ret =3D 0;
=20
 	for (bitmask =3D 1; bitmask < e->max; bitmask <<=3D 1)
@@ -1356,7 +1356,7 @@ int snd_soc_dapm_get_value_enum_double(struct snd_kco=
ntrol *kcontrol,
 {
 	struct snd_soc_dapm_widget *widget =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short reg_val, val, mux;
+	unsigned int reg_val, val, mux;
=20
 	reg_val =3D snd_soc_read(widget->codec, e->reg);
 	val =3D (reg_val >> e->shift_l) & e->mask;
@@ -1396,8 +1396,8 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kco=
ntrol *kcontrol,
 {
 	struct snd_soc_dapm_widget *widget =3D snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
-	unsigned short val, mux;
-	unsigned short mask;
+	unsigned int val, mux;
+	unsigned int mask;
 	int ret =3D 0;
=20
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
--=20
tg: (81ee1ba..) asoc/allow-32bits-registers (depends on: master)

--=20
Daniel Ribeiro

--=-OVhKmfoo5PVlLprI1Oz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkorVMsACgkQw3OYl0G0liRDWQCeLvxv5IOzstP0hFe3JykDNWO2
xWIAnjgmbqm4jIz2DkphWwR5O/xBSmIj
=fcj5
-----END PGP SIGNATURE-----

--=-OVhKmfoo5PVlLprI1Oz0--


--===============3297608930607421337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3297608930607421337==--
