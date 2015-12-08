From: Gabriele Martino <g.martino@gmx.com>
Subject: Intel HDA / ca0132: quirk for Alienware 17 2015
Date: Tue, 8 Dec 2015 17:53:04 +0100
Message-ID: <56670AF0.2090306@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000603040502090508080408"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CCF4B260522
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:51:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000603040502090508080408
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The Alienware 17 (2015) has the same card and pin configuration of the
Alienware 15, so the same quirks must be applied.

Signed-off-by: Gabriele Martino <g.martino@gmx.com>


--------------000603040502090508080408
Content-Type: text/x-patch;
 name="ca0132-quirk-alienware17.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ca0132-quirk-alienware17.patch"

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index f8a12ca..41e8848 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -760,7 +760,8 @@ struct ca0132_spec {
  */
 enum {
 	QUIRK_NONE,
-	QUIRK_ALIENWARE,
+	QUIRK_ALIENWARE_15,
+	QUIRK_ALIENWARE_17,
 };
=20
 static const struct hda_pintbl alienware_pincfgs[] =3D {
@@ -778,7 +779,8 @@ static const struct hda_pintbl alienware_pincfgs[] =3D=
 {
 };
=20
 static const struct snd_pci_quirk ca0132_quirks[] =3D {
-	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
+	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE_15),=

+	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE_17),=

 	{}
 };
=20
@@ -4631,8 +4633,8 @@ static void ca0132_config(struct hda_codec *codec)
 	spec->multiout.num_dacs =3D 3;
 	spec->multiout.max_channels =3D 2;
=20
-	if (spec->quirk =3D=3D QUIRK_ALIENWARE) {
-		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
+	if (spec->quirk =3D=3D QUIRK_ALIENWARE_15 || spec->quirk =3D=3D QUIRK_A=
LIENWARE_17) {
+		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE_* applied.\n");
 		snd_hda_apply_pincfgs(codec, alienware_pincfgs);
=20
 		spec->num_outputs =3D 2;

--------------000603040502090508080408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000603040502090508080408--
