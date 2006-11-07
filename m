From: "Andrew L. Neporada" <nepal@asplinux.ru>
Subject: Re: [PATCH] Clevo M540JE,
	M550JE laptops (Nvidia	MCP51 chipset, ALC883	codec)
Date: Tue, 07 Nov 2006 11:52:33 +0300
Message-ID: <1162889554.16251.13.camel@leeloo.asplinux.ru>
References: <1162561676.22293.16.camel@leeloo.asplinux.ru>
	<s5hr6wgsufy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-jIJWZzQJWvY5+uut6dBv"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6wgsufy.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-jIJWZzQJWvY5+uut6dBv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by relay.sw.ru id
	kA78rCfn006088

=D0=92 =D0=9F=D0=BD=D0=B4, 06/11/2006 =D0=B2 12:09 +0100, Takashi Iwai =D0=
=BF=D0=B8=D1=88=D0=B5=D1=82:
> At Fri, 03 Nov 2006 16:47:56 +0300,
> Andrew L. Neporada wrote:
> >=20
> > Hi!
> >=20
> > We need to enable External Amplifier on this laptops. This patch basi=
cly
> > adds laptop-eapd model to ALC883 codec.
>=20
> Thanks for the patch.
> Unfortunately it isn't applicable to HG repo since more other changes
> have been done to ALC883 code.  Could you try HG version with the
> patch below I fixed?
>=20
> Also, please give a sign-off to commit the patch.
>=20
>=20

Sorry, but your patch does not work because of change in
alc882_eapd_verbs[] in changeset 20ccacc019b7
(http://hg-mirror.alsa-project.org/alsa-kernel?cs=3D20ccacc019b7)

I believe this change is wrong because ALC882_ARIMA also depends on
alc882_eapd_verbs[]. Please consider commiting updated patch.

Signed-off-by: Andrew L. Neporada <nepal@asplinux.ru>



--=-jIJWZzQJWvY5+uut6dBv
Content-Disposition: attachment; filename=alsa-driver-clevo.patch
Content-Type: text/x-patch; name=alsa-driver-clevo.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- Documentation/ALSA-Configuration.txt.orig	2006-10-23 17:00:06.000000000 +0400
+++ Documentation/ALSA-Configuration.txt	2006-11-07 11:28:36.000000000 +0300
@@ -827,6 +827,7 @@ Prior to version 0.9.0rc4 options had a 
 	  medion	Medion Laptops
 	  targa-dig	Targa/MSI
 	  targa-2ch-dig	Targs/MSI with 2-channel
+	  laptop-eapd   3-jack with SPDIF I/O and EAPD (Clevo M540JE, M550JE)
 	  auto		auto-config reading BIOS (default)
 
 	ALC861/660
--- pci/hda/patch_realtek.c.orig	2006-11-06 17:00:04.000000000 +0300
+++ pci/hda/patch_realtek.c	2006-11-07 11:33:26.000000000 +0300
@@ -125,6 +125,7 @@ enum {
 	ALC888_DEMO_BOARD,
 	ALC883_ACER,
 	ALC883_MEDION,
+	ALC883_LAPTOP_EAPD,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -4540,7 +4541,7 @@ static struct hda_verb alc882_init_verbs
 static struct hda_verb alc882_eapd_verbs[] = {
 	/* change to EAPD mode */
 	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
-	{0x20, AC_VERB_SET_PROC_COEF, 0x3070},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x3060},
 	{ } 
 };
 
@@ -4998,6 +4999,13 @@ static struct hda_channel_mode alc883_si
 	{ 8, alc883_sixstack_ch8_init },
 };
 
+static struct hda_verb alc883_medion_eapd_verbs[] = {
+        /* eanable EAPD on medion laptop */
+	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x3070},
+	{ }
+};
+
 /* Pin assignment: Front=0x14, Rear=0x15, CLFE=0x16, Side=0x17
  *                 Mic=0x18, Front Mic=0x19, Line-In=0x1a, HP=0x1b
  */
@@ -5469,6 +5477,9 @@ static struct hda_board_config alc883_cf
 	  .config = ALC883_ACER },
 	{ .pci_subvendor = 0x161f, .pci_subdevice = 0x2054,
 	  .modelname = "medion", .config = ALC883_MEDION },
+	{ .modelname = "laptop-eapd", .config = ALC883_LAPTOP_EAPD },
+	{ .pci_subvendor = 0x1558, .pci_subdevice = 0,
+	  .config = ALC883_LAPTOP_EAPD }, /* Clevo */
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };
@@ -5589,7 +5600,7 @@ static struct alc_config_preset alc883_p
 		.mixers = { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs,
-				alc882_eapd_verbs },
+				alc883_medion_eapd_verbs },
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
 		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
@@ -5597,8 +5608,19 @@ static struct alc_config_preset alc883_p
 		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
 		.channel_mode = alc883_sixstack_modes,
 		.input_mux = &alc883_capture_source,
-	}
-
+	},
+	[ALC883_LAPTOP_EAPD] = {
+		.mixers = { alc883_base_mixer,
+			    alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs, alc882_eapd_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_capture_source,
+	},
 };
 
 

--=-jIJWZzQJWvY5+uut6dBv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-jIJWZzQJWvY5+uut6dBv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-jIJWZzQJWvY5+uut6dBv--
