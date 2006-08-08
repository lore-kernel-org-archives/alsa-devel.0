From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH 1/2] Revolution 5.1 - add AK5365 ADC support
Date: Tue, 8 Aug 2006 19:59:15 +0100
Message-ID: <20060808185915.GB30577@tarte.seehuhn.de>
References: <20060808185758.GA30577@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0632240170=="
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


--===============0632240170==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add support for the AK5365 ADC.

Signed-off-by: Jochen Voss <voss@seehuhn.de>


diff -ur alsa-driver-1.0.12rc2.orig/alsa-kernel/i2c/other/ak4xxx-adda.c alsa-driver-1.0.12rc2/alsa-kernel/i2c/other/ak4xxx-adda.c
--- alsa-driver-1.0.12rc2.orig/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-08-04 13:41:21.000000000 +0100
+++ alsa-driver-1.0.12rc2/alsa-kernel/i2c/other/ak4xxx-adda.c	2006-08-08 19:44:20.000000000 +0100
@@ -598,6 +598,31 @@
 		if (err < 0)
 			goto __error;
 	}
+
+	if (ak->type == SND_AK5365) {
+		memset(ctl, 0, sizeof(*ctl));
+		if (ak->channel_names == NULL)
+			strcpy(ctl->id.name, "Capture Volume");
+		else
+			strcpy(ctl->id.name, ak->channel_names[0]);
+		ctl->id.index = ak->idx_offset * 2;
+		ctl->id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		ctl->count = 1;
+		ctl->info = snd_akm4xxx_stereo_volume_info;
+		ctl->get = snd_akm4xxx_stereo_volume_get;
+		ctl->put = snd_akm4xxx_stereo_volume_put;
+		/* Registers 4 & 5 (see AK5365 data sheet, pages 34 and 35):
+		 * valid values are from 0x00 (mute) to 0x98 (+12dB).  */
+		ctl->private_value =
+			AK_COMPOSE(0, 4, 0, 0x98);
+		ctl->private_data = ak;
+		err = snd_ctl_add(ak->card,
+				  snd_ctl_new(ctl, SNDRV_CTL_ELEM_ACCESS_READ|
+					      SNDRV_CTL_ELEM_ACCESS_WRITE));
+		if (err < 0)
+			goto __error;
+	}
+
 	if (ak->type == SND_AK4355 || ak->type == SND_AK4358)
 		num_emphs = 1;
 	else
diff -ur alsa-driver-1.0.12rc2.orig/alsa-kernel/include/ak4xxx-adda.h alsa-driver-1.0.12rc2/alsa-kernel/include/ak4xxx-adda.h
--- alsa-driver-1.0.12rc2.orig/alsa-kernel/include/ak4xxx-adda.h	2006-08-04 13:41:21.000000000 +0100
+++ alsa-driver-1.0.12rc2/alsa-kernel/include/ak4xxx-adda.h	2006-08-08 19:45:15.000000000 +0100
@@ -53,7 +53,8 @@
 	unsigned int idx_offset;		/* control index offset */
 	enum {
 		SND_AK4524, SND_AK4528, SND_AK4529,
-		SND_AK4355, SND_AK4358, SND_AK4381
+		SND_AK4355, SND_AK4358, SND_AK4381,
+		SND_AK5365
 	} type;
 	unsigned int *num_stereo;	/* array of combined counts
 					 * for the mixer


--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2N8Df+iD8yEbECURAoDRAKDA7Ycu8ic+jdBm1tRAb6PTQYAfNgCbBd+z
6cg+ILAHj92MMxOKSCXeTQw=
=2EfM
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--


--===============0632240170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0632240170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0632240170==--
