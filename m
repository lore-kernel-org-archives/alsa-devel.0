From: Stuffed Crust <pizza@shaftnet.org>
Subject: PATCH:  (updated) cs4205 sp/dif support
Date: Wed, 3 Apr 2002 12:16:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020403121654.A22768@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--4bRzO86E/ozDv8r1
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This has the more sane method of using a flag instead of hardcoding the
codec id.

It also fixes an additional bug in the spdif sample rate selection.

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cs4205.diff"
Content-Transfer-Encoding: quoted-printable

diff -aur --exclude=3D.depend /usr/src/alsa-driver-0.9.0beta12/alsa-kernel/=
include/ac97_codec.h ./alsa-kernel/include/ac97_codec.h
--- /usr/src/alsa-driver-0.9.0beta12/alsa-kernel/include/ac97_codec.h	Wed F=
eb 20 13:56:57 2002
+++ ./alsa-kernel/include/ac97_codec.h	Tue Apr  2 08:39:04 2002
@@ -125,6 +125,7 @@
 /* ac97->flags */
 #define AC97_HAS_PC_BEEP	(1<<0)
 #define AC97_AD_MULTI		(1<<1)	/* Analog Devices - multi codecs */
+#define AC97_CS_SPDIF		(1<<2)	/* Cirrus Logic uses funky SPDIF */
=20
 /*
=20
diff -aur --exclude=3D.depend /usr/src/alsa-driver-0.9.0beta12/alsa-kernel/=
pci/ac97/ac97_codec.c ./alsa-kernel/pci/ac97/ac97_codec.c
--- /usr/src/alsa-driver-0.9.0beta12/alsa-kernel/pci/ac97/ac97_codec.c	Sun =
Feb 24 15:45:11 2002
+++ ./alsa-kernel/pci/ac97/ac97_codec.c	Tue Apr  2 11:57:45 2002
@@ -35,7 +35,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Universal interface for Audio Codec '97");
 MODULE_LICENSE("GPL");
-
 static int enable_loopback =3D 0;
=20
 MODULE_PARM(enable_loopback, "i");
@@ -59,6 +58,7 @@
 static int patch_sigmatel_stac9744(ac97_t * ac97);
 static int patch_sigmatel_stac9756(ac97_t * ac97);
 static int patch_cirrus_cs4299(ac97_t * ac97);
+static int patch_cirrus_cs4205(ac97_t * ac97);
 static int patch_ad1819(ac97_t * ac97);
 static int patch_ad1881(ac97_t * ac97);
=20
@@ -111,7 +111,7 @@
 { 0x42525928, 0xfffffff8, "CS4294",		NULL },
 { 0x43525930, 0xfffffff8, "CS4299",		patch_cirrus_cs4299 },
 { 0x43525948, 0xfffffff8, "CS4201",		NULL },
-{ 0x43525958, 0xfffffff8, "CS4205",		NULL },
+{ 0x43525958, 0xfffffff8, "CS4205",		patch_cirrus_cs4205 },
 { 0x43525960, 0xfffffff8, "CS4291",		NULL },
 { 0x48525300, 0xffffff00, "HMP9701",		NULL },
 { 0x49434501, 0xffffffff, "ICE1230",		NULL },
@@ -156,6 +156,9 @@
 #define AC97_ID_STAC9744	0x83847644
 #define AC97_ID_STAC9756	0x83847656
=20
+#define SPDIF_CS4205            0x68
+#define MODE_CS4205            0x5e
+
 static const char *snd_ac97_stereo_enhancements[] =3D
 {
   /*   0 */ "No 3D Stereo Enhancement",
@@ -722,8 +728,8 @@
 		new |=3D ucontrol->value.iec958.status[0] & (IEC958_AES0_PRO_FS|IEC958_A=
ES0_PRO_EMPHASIS_5015);
 		switch (new & IEC958_AES0_PRO_FS) {
 		case IEC958_AES0_PRO_FS_44100: val |=3D 0<<12; break;
-		case IEC958_AES0_PRO_FS_32000: val |=3D 2<<12; break;
-		case IEC958_AES0_PRO_FS_48000: val |=3D 1<<12; break;
+		case IEC958_AES0_PRO_FS_48000: val |=3D 2<<12; break;
+		case IEC958_AES0_PRO_FS_32000: val |=3D 3<<12; break;
 		default:		       val |=3D 1<<12; break;
 		}
 		if ((new & IEC958_AES0_PRO_EMPHASIS) =3D=3D IEC958_AES0_PRO_EMPHASIS_501=
5)
@@ -731,7 +737,7 @@
 	} else {
 		new |=3D ucontrol->value.iec958.status[0] & (IEC958_AES0_CON_EMPHASIS_50=
15|IEC958_AES0_CON_NOT_COPYRIGHT);
 		new |=3D ((ucontrol->value.iec958.status[1] & (IEC958_AES1_CON_CATEGORY|=
IEC958_AES1_CON_ORIGINAL)) << 8);
-		new |=3D ((ucontrol->value.iec958.status[3] & IEC958_AES3_CON_FS) << 8);
+		new |=3D ((ucontrol->value.iec958.status[3] & IEC958_AES3_CON_FS) << 24);
 		if ((new & IEC958_AES0_CON_EMPHASIS) =3D=3D IEC958_AES0_CON_EMPHASIS_501=
5)
 			val |=3D 1<<3;
 		if (!(new & IEC958_AES0_CON_NOT_COPYRIGHT))
@@ -744,7 +750,21 @@
 		default:		       val |=3D 1<<12; break;
 		}
 	}
-	change =3D snd_ac97_update_bits(ac97, AC97_SPDIF, 0x3fff, val);
+
+=09
+
+	if (ac97->flags & AC97_CS_SPDIF) {
+		int x =3D (val >> 12) & 0x03;
+		switch (x) {
+		case 0: x =3D 1; break;  // 44.1
+		case 2: x =3D 0; break;  // 48.0
+		default: x =3D 0; break; // illegal.
+		}
+		change =3D snd_ac97_update_bits(ac97, SPDIF_CS4205, 0x3fff, ((val & 0xcf=
ff) | (x << 12)));
+	} else {
+		change =3D snd_ac97_update_bits(ac97, AC97_SPDIF, 0x3fff, val);
+	}
+
 	change |=3D ac97->spdif_status !=3D new;
 	ac97->spdif_status =3D new;
 	spin_unlock(&ac97->reg_lock);
@@ -773,10 +793,16 @@
 		get: snd_ac97_spdif_default_get,
 		put: snd_ac97_spdif_default_put,
 	},
+
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH),AC97_EXTENDED_STATU=
S, 2, 1, 0),
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "AC97-SPSA",AC97_EXTE=
NDED_STATUS, 4, 3, 0)
 };
=20
+static const snd_kcontrol_new_t snd_ac97_cs4205_controls_spdif[2] =3D {
+    AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH),SPDIF_CS4205, 15=
, 1, 0),
+    AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "AC97-SPSA",MODE_C=
S4205, 0, 3, 0)
+};
+
 #define AD18XX_PCM_BITS(xname, codec, shift, mask) \
 { iface: SNDRV_CTL_ELEM_IFACE_MIXER, name: xname, info: snd_ac97_ad18xx_pc=
m_info_bits, \
   get: snd_ac97_ad18xx_pcm_get_bits, put: snd_ac97_ad18xx_pcm_put_bits, \
@@ -1270,12 +1296,26 @@
 	}
 =09
 	/* build S/PDIF controls */
-	if (ac97->ext_id & 0x0004) {
-		for (idx =3D 0; idx < 5; idx++)
-			if ((err =3D snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_spdif[i=
dx], ac97))) < 0)
-				return err;
-		/* consumer,PCM audio,no copyright,no preemphasis,PCM coder,original */
-		snd_ac97_write_cache(ac97, AC97_SPDIF, 0x2a20);
+	if (ac97->ext_id & AC97_EA_SPDIF) {
+		if (ac97->flags & AC97_CS_SPDIF) {
+			for (idx =3D 0; idx < 3; idx++)
+				if ((err =3D snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_spdif[=
idx], ac97))) < 0)
+					return err;
+			for (idx =3D 0; idx < 2; idx++)
+				if ((err =3D snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_cs4205_controls=
_spdif[idx], ac97))) < 0)
+					return err;
+		} else {
+			for (idx =3D 0; idx < 5; idx++)
+				if ((err =3D snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_spdif[=
idx], ac97))) < 0)
+					return err;
+			/* consumer,PCM audio,no copyright,no preemphasis,PCM coder,original, 4=
8000 Hz */
+		}
+
+	        if (ac97->flags & AC97_CS_SPDIF)
+			snd_ac97_write_cache(ac97, SPDIF_CS4205, 0x0a20);
+		else=20
+			snd_ac97_write_cache(ac97, AC97_SPDIF, 0x2a20);
+
 		ac97->spdif_status =3D SNDRV_PCM_DEFAULT_CON_SPDIF;
 	}
 =09
@@ -1511,6 +1551,7 @@
 	unsigned short val, tmp, ext;
 	static const char *spdif_slots[4] =3D { " SPDIF=3D3/4", " SPDIF=3D7/8", "=
 SPDIF=3D6/9", " SPDIF=3Dres" };
 	static const char *spdif_rates[4] =3D { " Rate=3D44.1kHz", " Rate=3Dres",=
 " Rate=3D48kHz", " Rate=3D32kHz" };
+	static const char *spdif_rates_cs4205[4] =3D { " Rate=3D48kHz", " Rate=3D=
44.1kHz", " Rate=3Dres", " Rate=3Dres" };
=20
 	id =3D snd_ac97_read(ac97, AC97_VENDOR_ID1) << 16;
 	id |=3D snd_ac97_read(ac97, AC97_VENDOR_ID2);
@@ -1557,6 +1598,7 @@
 		    val & 0x0100 ? "Mic2" : "Mic1",
 		    val & 0x0080 ? "on" : "off");
 	ext =3D snd_ac97_read(ac97, AC97_EXTENDED_ID);
+
 	if (ext =3D=3D 0)
 		return;
 	snd_iprintf(buffer, "Extended ID      : codec=3D%i rev=3D%i%s%s%s%s DSA=
=3D%i%s%s%s%s\n",
@@ -1605,8 +1647,12 @@
 		val =3D snd_ac97_read(ac97, AC97_PCM_MIC_ADC_RATE);
 		snd_iprintf(buffer, "PCM MIC ADC      : %iHz\n", val);
 	}
-	if (ext & 0x0004) {
-		val =3D snd_ac97_read(ac97, AC97_SPDIF);
+	if ((ext & 0x0004) || (ac97->flags & AC97_CS_SPDIF)) {
+	        if (ac97->flags & AC97_CS_SPDIF)
+			val =3D snd_ac97_read(ac97, SPDIF_CS4205);
+		else
+			val =3D snd_ac97_read(ac97, AC97_SPDIF);
+
 		snd_iprintf(buffer, "SPDIF Control    :%s%s%s%s Category=3D0x%x Generati=
on=3D%i%s%s%s\n",
 			val & 0x0001 ? " PRO" : " Consumer",
 			val & 0x0002 ? " Non-audio" : " PCM",
@@ -1614,9 +1660,15 @@
 			val & 0x0008 ? " Preemph50/15" : "",
 			(val & 0x07f0) >> 4,
 			(val & 0x0800) >> 11,
-			spdif_rates[(val & 0x3000) >> 12],
-			val & 0x4000 ? " DRS" : "",
-			val & 0x8000 ? " Validity" : "");
+			(ac97->flags & AC97_CS_SPDIF) ?
+			    spdif_rates_cs4205[(val & 0x3000) >> 12] :
+			    spdif_rates[(val & 0x3000) >> 12],
+			(ac97->flags & AC97_CS_SPDIF) ?
+			    (val & 0x4000 ? " Validity" : "") :
+			    (val & 0x4000 ? " DRS" : ""),
+			(ac97->flags & AC97_CS_SPDIF) ?
+			    (val & 0x8000 ? " Enabled" : "") :
+			    (val & 0x8000 ? " Validity" : ""));
 	}
 }
=20
@@ -1668,6 +1720,7 @@
 	ac97_t *ac97 =3D snd_magic_cast(ac97_t, entry->private_data, return);
=20
 	if ((ac97->id & 0xffffff40) =3D=3D AC97_ID_AD1881) {	// Analog Devices AD=
1881/85/86
+
 		int idx;
 		down(&ac97->spec.ad18xx.mutex);
 		for (idx =3D 0; idx < 3; idx++)
@@ -1819,6 +1872,26 @@
 static int patch_cirrus_cs4299(ac97_t * ac97)
 {
 	ac97->flags |=3D AC97_HAS_PC_BEEP;	/* force the detection of PC Beep */
+=09
+	return 0;
+}
+
+static int patch_cirrus_cs4205(ac97_t * ac97)
+{
+  /* Basically, the cs4205 has non-standard sp/dif registers.
+     WHY CAN'T ANYONE FOLLOW THE BLOODY SPEC?  *sigh*
+      - sp/dif EA ID is not set, but sp/dif is always present.
+        - enable/disable is spdif register bit 15.
+      - sp/dif control register is 0x68.  differs from AC97:
+        - valid is bit 14 (vs 15)
+	- no DRS
+	- only 44.1/48k [00 =3D 48, 01=3D44,1] (AC97 is 00=3D44.1, 10=3D48)
+      - sp/dif ssource select is in 0x5e bits 0,1.
+  */
+
+	ac97->flags |=3D AC97_CS_SPDIF;=20
+        ac97->ext_id |=3D AC97_EA_SPDIF;	/* force the detection of spdif */
+	snd_ac97_write_cache(ac97, MODE_CS4205, 0x0080);
 	return 0;
 }
=20
@@ -1978,6 +2051,7 @@
 	} while (end_time - (signed long)jiffies >=3D 0);
 	snd_ac97_update(ac97, reg, tmp & 0xffff);
 	udelay(10);
+	// XXXX update spdif rate here too?
 	snd_ac97_update_bits(ac97, AC97_POWERDOWN, mask, 0);
 	end_time =3D jiffies + (HZ / 50);
 	do {

--C7zPtVaVf+AK4Oqc--

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8qzkGysXuytMhc5ERAt67AJwNWDxOEjh7AoHzNr6Wks3G5Ei71wCffi6L
dIHtGooPrpY3zl7L6dK/XQw=
=Cajm
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
