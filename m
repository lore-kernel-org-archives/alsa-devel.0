From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH alsa-python] alsamixer: Fix bad
 PyArg_ParseTuple format strings
Date: Mon, 28 Mar 2011 13:46:33 -0400
Message-ID: <20110328174633.GI29800@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2070922829270352080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 519FF1037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 19:46:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2070922829270352080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A number of calls to PyArg_ParseTuple use "I" for ints and "L" for
long ints.  Fix these to be "i" and "l" respectively.

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 pyalsa/alsamixer.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/pyalsa/alsamixer.c b/pyalsa/alsamixer.c
index 81719a7..d686f16 100644
--- a/pyalsa/alsamixer.c
+++ b/pyalsa/alsamixer.c
@@ -372,7 +372,7 @@ pyalsamixerelement_ismono(struct pyalsamixerelement *py=
elem, PyObject *args)
 {
 	int res, dir =3D 0;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -393,7 +393,7 @@ pyalsamixerelement_haschannel(struct pyalsamixerelement=
 *pyelem, PyObject *args)
 {
 	int res, dir =3D 0, chn =3D SND_MIXER_SCHN_MONO;
=20
-	if (!PyArg_ParseTuple(args, "|II", &chn, &dir))
+	if (!PyArg_ParseTuple(args, "|ii", &chn, &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -415,7 +415,7 @@ pyalsamixerelement_hasvolume(struct pyalsamixerelement =
*pyelem, PyObject *args)
 {
 	int res, dir =3D 0;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -444,7 +444,7 @@ pyalsamixerelement_hasswitch(struct pyalsamixerelement =
*pyelem, PyObject *args)
 {
 	int res, dir =3D 0;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -473,7 +473,7 @@ pyalsamixerelement_askvoldB(struct pyalsamixerelement *=
pyelem, PyObject *args)
 	int res, dir =3D 0;
 	long volume, val;
=20
-	if (!PyArg_ParseTuple(args, "|LI", &volume, &dir))
+	if (!PyArg_ParseTuple(args, "|li", &volume, &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -496,7 +496,7 @@ pyalsamixerelement_askdBvol(struct pyalsamixerelement *=
pyelem, PyObject *args)
 	int res, xdir =3D -1, dir =3D 0;
 	long dBvolume, val;
=20
-	if (!PyArg_ParseTuple(args, "|LII", &dBvolume, &xdir, &dir))
+	if (!PyArg_ParseTuple(args, "|lii", &dBvolume, &xdir, &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -519,7 +519,7 @@ pyalsamixerelement_getvolume(struct pyalsamixerelement =
*pyelem, PyObject *args)
 	int res, dir =3D 0, chn =3D SND_MIXER_SCHN_MONO;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "|II", &chn, &dir))
+	if (!PyArg_ParseTuple(args, "|ii", &chn, &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -543,7 +543,7 @@ pyalsamixerelement_getvolumetuple(struct pyalsamixerele=
ment *pyelem, PyObject *a
 	long val;
 	PyObject *t;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0) {
@@ -617,7 +617,7 @@ pyalsamixerelement_getvolumearray(struct pyalsamixerele=
ment *pyelem, PyObject *a
 	long val;
 	PyObject *t, *l;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0) {
@@ -694,7 +694,7 @@ pyalsamixerelement_setvolume(struct pyalsamixerelement =
*pyelem, PyObject *args)
 	int res, dir =3D 0, chn =3D SND_MIXER_SCHN_MONO;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "L|II", &val, &chn, &dir))
+	if (!PyArg_ParseTuple(args, "l|ii", &val, &chn, &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_volume(pyelem->elem, chn, val);
@@ -718,7 +718,7 @@ pyalsamixerelement_setvolumetuple(struct pyalsamixerele=
ment *pyelem, PyObject *a
 	int i, res, dir =3D 0;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "O|I", &t, &dir))
+	if (!PyArg_ParseTuple(args, "O|i", &t, &dir))
 		return NULL;
 	if (!PyTuple_Check(t) && !PyList_Check(t))
 		return PyErr_Format(PyExc_RuntimeError, "Volume values in tuple are expe=
cted!");
@@ -770,7 +770,7 @@ pyalsamixerelement_setvolumeall(struct pyalsamixereleme=
nt *pyelem, PyObject *arg
 	int res, dir =3D 0;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "L|I", &val, &dir))
+	if (!PyArg_ParseTuple(args, "l|i", &val, &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_volume_all(pyelem->elem, val);
@@ -791,7 +791,7 @@ pyalsamixerelement_getrange(struct pyalsamixerelement *=
pyelem, PyObject *args)
 	long min, max;
 	PyObject *t;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_get_playback_volume_range(pyelem->elem, &min, &m=
ax);
@@ -816,7 +816,7 @@ pyalsamixerelement_setrange(struct pyalsamixerelement *=
pyelem, PyObject *args)
 	int dir =3D 0, res;
 	long min, max;
=20
-	if (!PyArg_ParseTuple(args, "LL|I", &min, &max, &dir))
+	if (!PyArg_ParseTuple(args, "ll|i", &min, &max, &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_volume_range(pyelem->elem, min, max=
);
@@ -835,7 +835,7 @@ pyalsamixerelement_getswitch(struct pyalsamixerelement =
*pyelem, PyObject *args)
 {
 	int res, dir =3D 0, chn =3D SND_MIXER_SCHN_MONO, val;
=20
-	if (!PyArg_ParseTuple(args, "|II", &chn, &dir))
+	if (!PyArg_ParseTuple(args, "|ii", &chn, &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -862,7 +862,7 @@ pyalsamixerelement_getswitchtuple(struct pyalsamixerele=
ment *pyelem, PyObject *a
 	int res, dir =3D 0, i, last, val;
 	PyObject *t;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0) {
@@ -934,7 +934,7 @@ pyalsamixerelement_setswitch(struct pyalsamixerelement =
*pyelem, PyObject *args)
 {
 	int res, dir =3D 0, chn =3D SND_MIXER_SCHN_MONO, val;
=20
-	if (!PyArg_ParseTuple(args, "I|II", &val, &chn, &dir))
+	if (!PyArg_ParseTuple(args, "i|ii", &val, &chn, &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_switch(pyelem->elem, chn, val);
@@ -954,7 +954,7 @@ pyalsamixerelement_setswitchtuple(struct pyalsamixerele=
ment *pyelem, PyObject *a
 	PyObject *t, *o;
 	int i, res, dir =3D 0, val;
=20
-	if (!PyArg_ParseTuple(args, "O|I", &t, &dir))
+	if (!PyArg_ParseTuple(args, "O|i", &t, &dir))
 		return NULL;
 	if (!PyTuple_Check(t))
 		return PyErr_Format(PyExc_RuntimeError, "Switch state values in tuple ar=
e expected!");
@@ -982,7 +982,7 @@ pyalsamixerelement_setswitchall(struct pyalsamixereleme=
nt *pyelem, PyObject *arg
 {
 	int res, dir =3D 0, val;
=20
-	if (!PyArg_ParseTuple(args, "I|I", &val, &dir))
+	if (!PyArg_ParseTuple(args, "i|i", &val, &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_switch_all(pyelem->elem, val);
@@ -1002,7 +1002,7 @@ pyalsamixerelement_getvolumedb(struct pyalsamixerelem=
ent *pyelem, PyObject *args
 	int res, dir =3D 0, chn =3D SND_MIXER_SCHN_MONO;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "|II", &chn, &dir))
+	if (!PyArg_ParseTuple(args, "|ii", &chn, &dir))
 		return NULL;
=20
 	if (dir =3D=3D 0)
@@ -1025,7 +1025,7 @@ pyalsamixerelement_setvolumedb(struct pyalsamixerelem=
ent *pyelem, PyObject *args
 	int res, dir =3D 0, dir1 =3D 0, chn =3D SND_MIXER_SCHN_MONO;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "L|III", &val, &chn, &dir, &dir1))
+	if (!PyArg_ParseTuple(args, "l|iii", &val, &chn, &dir, &dir1))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_dB(pyelem->elem, chn, val, dir1);
@@ -1045,7 +1045,7 @@ pyalsamixerelement_setvolumealldb(struct pyalsamixere=
lement *pyelem, PyObject *a
 	int res, dir =3D 0, dir1 =3D 0;
 	long val;
=20
-	if (!PyArg_ParseTuple(args, "L|II", &val, &dir, &dir1))
+	if (!PyArg_ParseTuple(args, "l|ii", &val, &dir, &dir1))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_set_playback_dB_all(pyelem->elem, val, dir1);
@@ -1066,7 +1066,7 @@ pyalsamixerelement_getrangedb(struct pyalsamixereleme=
nt *pyelem, PyObject *args)
 	long min, max;
 	PyObject *t;
=20
-	if (!PyArg_ParseTuple(args, "|I", &dir))
+	if (!PyArg_ParseTuple(args, "|i", &dir))
 		return NULL;
 	if (dir =3D=3D 0)
 		res =3D snd_mixer_selem_get_playback_dB_range(pyelem->elem, &min, &max);
--=20
1.7.0.4

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2QyXkACgkQRO4fQQdv5Az/kwCgzyyOFo1nnGYGuRJ1gQRzD4Vs
gP0Aniq8e1v0lzGwuFhxWlZbxtzvMboC
=CkwC
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--

--===============2070922829270352080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2070922829270352080==--
