From: =?utf-8?q?Ra=C3=BAl_S=C3=A1nchez_Siles?= <rss@barracuda.es>
Subject: [PATCH] fix typo/compilation error on soc-dapm and
	at91-i2s
Date: Thu, 28 Dec 2006 18:32:20 +0100
Message-ID: <200612281832.23268.rss@barracuda.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890297270=="
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0890297270==
Content-Type: multipart/signed; boundary="nextPart1588821.cdcJiWZr1a";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1588821.cdcJiWZr1a
Content-Type: multipart/mixed;
  boundary="Boundary-01=_k+/kFMSW0VGe0Au"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_k+/kFMSW0VGe0Au
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hello all:

  I'm trying to use asoc for an at91 custom board and I had some problem=20
compiling the kernel with the v1.0.14rc1 alsa patch. The problem were in th=
e=20
debug sections in two files.

  I attach a patch to correct this problems. I'm new sending patches to als=
a,=20
so if you think I did something wrong just let me know and I'll do my best.

  Note: please put me in CC since i'm not subscribed to the list.

  Thanks,
 =20
=2D-=20
Ra=C3=BAl S=C3=A1nchez Siles
Barracuda Systems S.L.
C/ Luxemburgo, 4 - Local
Pozuelo de Alarc=C3=B3n
28224 Madrid
Tlf.: +34 91 351 11 20
=46ax: +34 91 352 54 44

--Boundary-01=_k+/kFMSW0VGe0Au
Content-Type: text/x-diff;
  charset="utf-8";
  name="typos_asoc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="typos_asoc.patch"

# HG changeset patch
# User Ra=C3=BAl S=C3=A1nchez Siles <rss@barracuda.es>
# Date 1167325268 -3600
# Node ID 80537c953b2dc530cc7bfb6bad13f2abe956fcc4
# Parent  1c7129898e61d6dc47634cab28dd83d750e06176
Solve typos/compilation problems for debug functions in soc-dapm and at91-i=
2s.

soc-dapm
=C2=B7Fixed typo in soc-dapm.

at91-i2s
=C2=B7Fixed typo in dai modes definition.
=C2=B7Fixed struct member name in at91_ssc_info->ssc_state.
=C2=B7Fixed compilation problem, ssc_state is bundled in at91_ssc_info.

diff -r 1c7129898e61 -r 80537c953b2d soc/at91/at91-i2s.c
=2D-- a/soc/at91/at91-i2s.c	Thu Dec 28 15:40:47 2006 +0100
+++ b/soc/at91/at91-i2s.c	Thu Dec 28 18:01:08 2006 +0100
@@ -101,7 +101,7 @@ static struct snd_soc_dai_mode at91_i2s[
 		.pcmdir =3D AT91_I2S_DIR,
 		.flags =3D SND_SOC_DAI_BFS_DIV,
 		.fs =3D 250,
=2D		.bfs SND_SOC_FSBD(5),
+		.bfs =3D SND_SOC_FSBD(5),
 		.priv =3D (13 << 16 | 23),
 	},
 };
@@ -352,19 +352,19 @@ static int at91_i2s_suspend(struct platf
 	ssc_p =3D &ssc_info[dai->id];
=20
 	/* Save the status register before disabling transmit and receive. */
=2D	ssc_p->state->ssc_sr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR);
+	ssc_p->ssc_state.ssc_sr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR);
 	at91_ssc_write(ssc_p->ssc.base +
 		AT91_SSC_CR, AT91_SSC_TXDIS | AT91_SSC_RXDIS);
=20
 	/* Save the current interrupt mask, then disable unmasked interrupts. */
=2D	ssc_p->state->ssc_imr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR);
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->state->ssc_imr);
=2D
=2D	ssc_p->state->ssc_cmr  =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_CMR=
);
=2D	ssc_p->state->ssc_rcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
=2D	ssc_p->state->ssc_rfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
=2D	ssc_p->state->ssc_tcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
=2D	ssc_p->state->ssc_tfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
+	ssc_p->ssc_state.ssc_imr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR=
);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->ssc_state.ssc_imr);
+
+	ssc_p->ssc_state.ssc_cmr  =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_CM=
R);
+	ssc_p->ssc_state.ssc_rcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RC=
MR);
+	ssc_p->ssc_state.ssc_rfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RC=
MR);
+	ssc_p->ssc_state.ssc_tcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RC=
MR);
+	ssc_p->ssc_state.ssc_tfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RC=
MR);
=20
 	return 0;
 }
@@ -380,17 +380,17 @@ static int at91_i2s_resume(struct platfo
=20
 	ssc_p =3D &ssc_info[dai->id];
=20
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_tfmr);
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_tcmr);
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_rfmr);
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_rcmr);
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->state->ssc_cmr);
=2D
=2D	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->state->ssc_imr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_tfmr=
);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_tcmr=
);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rfmr=
);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rcmr=
);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->ssc_state.ssc_cmr);
+
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->ssc_state.ssc_imr);
=20
 	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
=2D		((ssc_p->state->ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
=2D		((ssc_p->state->ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
+		((ssc_p->ssc_state.ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
+		((ssc_p->ssc_state.ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
=20
 	return 0;
 }
diff -r 1c7129898e61 -r 80537c953b2d soc/soc-dapm.c
=2D-- a/soc/soc-dapm.c	Thu Dec 28 15:40:47 2006 +0100
+++ b/soc/soc-dapm.c	Thu Dec 28 18:01:08 2006 +0100
@@ -651,7 +651,7 @@ static void dbg_dump_dapm(struct snd_soc
 							p->source->name);
 				}
 				list_for_each_entry(p, &w->sinks, list_source) {
=2D					p =3D list_entry(lp, struct snd_soc_dapm_path, list_source);
+					p =3D list_entry(p, struct snd_soc_dapm_path, list_source);
 					if (p->connect)
 						printk(" out %s %s\n", p->name ? p->name : "static",
 							p->sink->name);

--Boundary-01=_k+/kFMSW0VGe0Au--

--nextPart1588821.cdcJiWZr1a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFk/+nvvLM0pAwfrkRAgxWAJ4xqx9FkGgviMCa8VJ+eiZ/YkpqdQCfU0Vd
KzI2wd5mih1ft1SpcAYZMTw=
=XUn3
-----END PGP SIGNATURE-----

--nextPart1588821.cdcJiWZr1a--


--===============0890297270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0890297270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0890297270==--
