From: Ted.Wen@ite.com.tw
Subject: [PATCH] IT2646 AC97 codec
Date: Fri, 24 Oct 2003 14:31:15 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <884B07FD576C3F49938D233F0E0A2B0059D72D@itemail1.internal.ite.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

diff -ur alsa-driver-0.9.7/alsa-kernel/pci/ac97/ac97_codec.c =
/alsa/patch/0.9.7/ac97_codec.c
--- alsa-driver-0.9.7/alsa-kernel/pci/ac97/ac97_codec.c	2003-08-28 =
23:36:44.000000000 +0800
+++ /alsa/patch/0.9.7/ac97_codec.c	2003-10-13 19:45:39.000000000 +0800
@@ -139,6 +139,7 @@
 { 0x49434551, 0xffffffff, "VT1616", 		patch_vt1616,	NULL },=20
 { 0x49434552, 0xffffffff, "VT1616i",		patch_vt1616,	NULL }, // VT1616 =
compatible (chipset integrated)
 { 0x49544520, 0xffffffff, "IT2226E",		NULL,		NULL },
+{ 0x49544561, 0xffffffff, "IT2646E",		patch_it2646,		NULL },
 { 0x4e534300, 0xffffffff, "LM4540/43/45/46/48",	NULL,		NULL }, // only =
guess --jk
 { 0x4e534331, 0xffffffff, "LM4549",		NULL,		NULL },
 { 0x4e534350, 0xffffffff, "LM4550",		NULL,		NULL },
Only in alsa-driver-0.9.7/alsa-kernel/pci/ac97: ac97_id.h
Only in alsa-driver-0.9.7/alsa-kernel/pci/ac97: ac97_local.h
diff -ur alsa-driver-0.9.7/alsa-kernel/pci/ac97/ac97_patch.c =
/alsa/patch/0.9.7/ac97_patch.c
--- alsa-driver-0.9.7/alsa-kernel/pci/ac97/ac97_patch.c	2003-09-23 =
22:31:44.000000000 +0800
+++ /alsa/patch/0.9.7/ac97_patch.c	2003-10-13 19:45:39.000000000 +0800
@@ -1099,3 +1099,37 @@
 	ac97->build_ops =3D &patch_vt1616_ops;
 	return 0;
 }
+


+static const snd_kcontrol_new_t snd_ac97_controls_it2646[] =3D {
+	AC97_SINGLE("Line-In As Surround", 0x76, 9, 1, 0),
+	AC97_SINGLE("Mic As Center/LFE", 0x76, 10, 1, 0),
+};
+
+static const snd_kcontrol_new_t snd_ac97_spdif_controls_it2646[] =3D {
+        AC97_SINGLE("IEC958 Capture Switch", 0x76, 11, 1, 0),
+        AC97_SINGLE("Analog to IEC958 Output", 0x76, 12, 1, 0),
+        AC97_SINGLE("IEC958 Input Monitor", 0x76, 13, 1, 0),
+};
+
+static int patch_it2646_specific(ac97_t * ac97)
+{
+	int err;
+	if ((err =3D patch_build_controls(ac97, snd_ac97_controls_it2646, =
ARRAY_SIZE(snd_ac97_controls_it2646))) < 0)
+		return err;
+	if ((err =3D patch_build_controls(ac97, =
snd_ac97_spdif_controls_it2646, =
ARRAY_SIZE(snd_ac97_spdif_controls_it2646))) < 0)
+		return err;
+	return 0;
+}
+
+static struct snd_ac97_build_ops patch_it2646_ops =3D {
+	.build_specific	=3D patch_it2646_specific
+};
+
+int patch_it2646(ac97_t * ac97)
+{
+	ac97->build_ops =3D &patch_it2646_ops;
+	/* full DAC volume */
+	snd_ac97_write_cache(ac97, 0x5E, 0x0808);
+	snd_ac97_write_cache(ac97, 0x7A, 0x0808);
+	return 0;
+}
Only in alsa-driver-0.9.7/alsa-kernel/pci/ac97: ac97_proc.c
Only in alsa-driver-0.9.7/alsa-kernel/pci/ac97: ak4531_codec.c
Only in alsa-driver-0.9.7/alsa-kernel/pci/ac97: Makefile



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
