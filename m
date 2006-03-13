From: Florian Schlichting <Florian.Schlichting@gmx.de>
Subject: Re: debugging nm256: some results, many questions
Date: Mon, 13 Mar 2006 14:46:28 +0800
Message-ID: <20060313064627.GA3864@tigerbay>
References: <20060223185253.GA7954@tigerbay> <s5hfym8vd0k.wl%tiwai@suse.de> <20060311174421.GB7775@tigerbay>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060311174421.GB7775@tigerbay>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--TakKZr9L6Hm6aLOc
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I went ahead implementing caching of reads to the ac97 mixer registers
inside the nm256 driver, and also included "preloading" of the cache,
just as the OSS driver does. And it works like a charm: no reads to the
mixers, no crashes any more!

Alas, this improvement has taught me what some of the reads were for -
detection of volume resolution, for example: I suddenly had two maxima
on the PCM mixer. As all my mixers have a resolution of 31, I customized
the values being written to the cache so that the ac97_codec would
"detect" the correct value. Now the only difference to the non-patched
state (according to alsactl) is that a few mixers are stereo instead of
mono - but up to now this doesn't seem to have any effect on anything I
do, everything works fine...

The question is: how portable is this to other users of nm256? Will we
need a detect for this workaround?

I've attached a patch against 1.0.10rc3 - I just saw that in 1.0.11rc3
there has been a cleanup in nm256, and my patch doesn't apply cleanly
any more... although I don't think it will need to be changed. Perhaps I
could have some feedback first?

Florian


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=nm256-patch
Content-Transfer-Encoding: quoted-printable

--- /usr/src/linux/sound/pci/nm256/nm256.c.orig	2006-03-13 13:46:23.0000000=
00 +0800
+++ /usr/src/linux/sound/pci/nm256/nm256.c.cleaned_up	2006-03-13 14:13:28.0=
00000000 +0800
@@ -1152,22 +1152,33 @@
 }
=20
 /*
+ * some nm256 easily crash when reading from mixer registers
+ * thus we're caching both read and written values for reading
  */
 static unsigned short
 snd_nm256_ac97_read(ac97_t *ac97, unsigned short reg)
 {
 	nm256_t *chip =3D ac97->private_data;
-	int res;
=20
 	if (reg >=3D 128)
 		return 0;
=20
 	if (! snd_nm256_ac97_ready(chip))
 		return 0;
-	res =3D snd_nm256_readw(chip, chip->mixer_base + reg);
+
+	if (! test_bit(reg, ac97->reg_accessed)) { /* ! read_workaround && */
+		/* we should never get here, really, as all regs have been=20
+		 * loaded into the cache, and the cached-flags in reg_accessed
+		 * are never cleared. Thus we could also test for=20
+		 * ! read_workaround (once introduced and properly set)	=09
+		 */
+ 		ac97->regs[reg] =3D snd_nm256_readw(chip, chip->mixer_base + reg);
+		set_bit(reg, ac97->reg_accessed);
+	}
+
 	/* Magic delay.  Bleah yucky.  */
 	msleep(1);
-	return res;
+	return ac97->regs[reg];
 }
=20
 /*=20
@@ -1188,17 +1199,62 @@
 	while (tries-- > 0) {
 		snd_nm256_writew(chip, base + reg, val);
 		msleep(1);  /* a little delay here seems better.. */
-		if (snd_nm256_ac97_ready(chip))
+		if (snd_nm256_ac97_ready(chip)) {
+			/* successful write: set cache */
+			ac97->regs[reg] =3D (val & 0xdfdf); /* we don't do this volume resoluti=
on */
+			set_bit(reg, ac97->reg_accessed);
 			return;
+		}
 	}
 	snd_printd("nm256: ac97 codec not ready..\n");
 }
=20
+/*=20
+ * below copied from OSS driver
+ * this list could perhaps be fused with mixer_regs[] ??
+ *=20
+ * Initial register values to be written to the AC97 mixer.
+ * While most of these are identical to the reset values, we do this
+ * so that we have most of the register contents cached--this avoids
+ * reading from the mixer directly (which seems to be problematic,
+ * probably due to ignorance).
+ */
+
+struct initialValues
+{
+	unsigned int reg;
+	unsigned short value;
+};
+
+static struct initialValues nm256_ac97_initial_values[] =3D
+{
+	{ AC97_MASTER, 		0x8000 },
+	{ AC97_HEADPHONE,	0x8000 },
+	{ AC97_MASTER_MONO,	0x0000 },
+	{ AC97_PC_BEEP,		0x0000 },
+	{ AC97_PHONE,		0x0008 },
+	{ AC97_MIC,		0x8000 },
+	{ AC97_LINE,		0x8808 },
+	{ AC97_CD,		0x8808 },
+	{ AC97_VIDEO,		0x8808 },
+	{ AC97_AUX,		0x8808 },
+	{ AC97_PCM,		0x0808 },
+	{ AC97_REC_SEL,		0x0000 },
+	{ AC97_REC_GAIN,	0x0B0B },
+	{ AC97_GENERAL_PURPOSE,	0x0000 },
+	{ AC97_3D_CONTROL,	0x8000 },=20
+	{ AC97_VENDOR_ID1, 	0x8384 },
+	{ AC97_VENDOR_ID2,	0x7609 },
+	{ 0xffff, 0xffff }
+};
+
+
 /* initialize the ac97 into a known state */
 static void
 snd_nm256_ac97_reset(ac97_t *ac97)
 {
 	nm256_t *chip =3D ac97->private_data;
+	int x;=20
=20
 	/* Reset the mixer.  'Tis magic!  */
 	snd_nm256_writeb(chip, 0x6c0, 1);
@@ -1211,6 +1267,12 @@
 		snd_nm256_writeb(chip, 0x6cc, 0x80);
 		snd_nm256_writeb(chip, 0x6cc, 0x0);
 	}
+	for (x =3D 0; nm256_ac97_initial_values[x].reg !=3D 0xffff; x++) {
+		/* preload the cache, so as to avoid even a single read of the mixer reg=
s */
+		snd_ac97_write_cache(ac97,
+				nm256_ac97_initial_values[x].reg,
+				nm256_ac97_initial_values[x].value);
+	}
 }
=20
 /* create an ac97 mixer interface */

--d6Gm4EdcadzBjdND--

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEFRVD/R0+cAphf/kRAgpjAKDVkTOllKRl5EgyAQZ5jvplOrFsHACfc0g5
SxwSFqma+McyUAA5Eh7aYAc=
=Ngvv
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
