From: =?ISO-8859-15?Q?Ra=FAl_S=E1nchez_Siles?= <rss@barracuda.es>
Subject: Re: [PATCH] fix typo/compilation error on	soc-dapm	and
	at91-i2s
Date: Fri, 05 Jan 2007 12:41:53 +0100
Message-ID: <enldi2$2k0$1@sea.gmane.org>
References: <200612281832.23268.rss@barracuda.es>
	<1167396924.11374.52.camel@localhost.localdomain>
	<1167401770.11374.67.camel@localhost.localdomain>
Reply-To: rss@barracuda.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2356954.cFIYLeoVNL"
Content-Transfer-Encoding: 7Bit
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

--nextPart2356954.cFIYLeoVNL
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Liam Girdwood wrote:

> On Fri, 2006-12-29 at 12:55 +0000, Liam Girdwood wrote:
>> On Thu, 2006-12-28 at 18:32 +0100, Ra=FAl S=E1nchez Siles wrote:
>> >   Hello all:
>> >=20
>> >   I'm trying to use asoc for an at91 custom board and I had some
>> >   problem
>> > compiling the kernel with the v1.0.14rc1 alsa patch. The problem wer=
e
>> > in the debug sections in two files.
>> >=20
>>=20
>> Thanks, this looks fine. Applied to my tree.
>=20
> I've made the following attached alteration the the DAPM debug section
> as the list_entry() is not needed. Can you re submit ?
>=20
> Thanks
>=20
> Liam

  After some newbie fights with mercurial I get to do it. Find it attache=
d.
Please, let me know if you need anything else.

  Regards,

--=20
Ra=FAl S=E1nchez Siles
--nextPart2356954.cFIYLeoVNL
Content-Type: text/x-diff; name="typos_asoc_b.patch"
Content-Disposition: attachment; filename="typos_asoc_b.patch"
Content-Transfer-Encoding: quoted-printable

# HG changeset patch
# User Ra=C3=BAl S=C3=A1nchez Siles <rss@barracuda.es>
# Date 1167996612 -3600
# Node ID 589751eead4cd109a78bd9f0ffc85d0b95d2e03c
# Parent  1c7129898e61d6dc47634cab28dd83d750e06176
Solve typos/compilation problems for debug functions in soc-dapm and at91=
-i2s.

soc-dapm
=C2=B7Removed list_for_each since the loop is list_for_each_entry() and
 not list_for_each(). Thanks to Liam Girdwood and Seth Forshee.

at91-i2s
=C2=B7Fixed typo in dai modes definition.
=C2=B7Fixed struct member name in at91_ssc_info->ssc_state.
=C2=B7Fixed compilation problem, ssc_state is bundled in at91_ssc_info.

diff -r 1c7129898e61 -r 589751eead4c soc/at91/at91-i2s.c
--- a/soc/at91/at91-i2s.c	Thu Dec 28 15:40:47 2006 +0100
+++ b/soc/at91/at91-i2s.c	Fri Jan 05 12:30:12 2007 +0100
@@ -101,7 +101,7 @@ static struct snd_soc_dai_mode at91_i2s[
 		.pcmdir =3D AT91_I2S_DIR,
 		.flags =3D SND_SOC_DAI_BFS_DIV,
 		.fs =3D 250,
-		.bfs SND_SOC_FSBD(5),
+		.bfs =3D SND_SOC_FSBD(5),
 		.priv =3D (13 << 16 | 23),
 	},
 };
@@ -352,19 +352,19 @@ static int at91_i2s_suspend(struct platf
 	ssc_p =3D &ssc_info[dai->id];
=20
 	/* Save the status register before disabling transmit and receive. */
-	ssc_p->state->ssc_sr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR);
+	ssc_p->ssc_state.ssc_sr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR=
);
 	at91_ssc_write(ssc_p->ssc.base +
 		AT91_SSC_CR, AT91_SSC_TXDIS | AT91_SSC_RXDIS);
=20
 	/* Save the current interrupt mask, then disable unmasked interrupts. *=
/
-	ssc_p->state->ssc_imr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR)=
;
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->state->ssc_imr);
-
-	ssc_p->state->ssc_cmr  =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_CMR=
);
-	ssc_p->state->ssc_rcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
-	ssc_p->state->ssc_rfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
-	ssc_p->state->ssc_tcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
-	ssc_p->state->ssc_tfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCM=
R);
+	ssc_p->ssc_state.ssc_imr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_I=
MR);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->ssc_state.ssc_imr=
);
+
+	ssc_p->ssc_state.ssc_cmr  =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_=
CMR);
+	ssc_p->ssc_state.ssc_rcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_=
RCMR);
+	ssc_p->ssc_state.ssc_rfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_=
RCMR);
+	ssc_p->ssc_state.ssc_tcmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_=
RCMR);
+	ssc_p->ssc_state.ssc_tfmr =3D at91_ssc_read(ssc_p->ssc.base + AT91_SSC_=
RCMR);
=20
 	return 0;
 }
@@ -380,17 +380,17 @@ static int at91_i2s_resume(struct platfo
=20
 	ssc_p =3D &ssc_info[dai->id];
=20
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_tfmr)=
;
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_tcmr)=
;
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_rfmr)=
;
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->state->ssc_rcmr)=
;
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->state->ssc_cmr);
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->state->ssc_imr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_tf=
mr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_tc=
mr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rf=
mr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rc=
mr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->ssc_state.ssc_cm=
r);
+
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->ssc_state.ssc_im=
r);
=20
 	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
-		((ssc_p->state->ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
-		((ssc_p->state->ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
+		((ssc_p->ssc_state.ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
+		((ssc_p->ssc_state.ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
=20
 	return 0;
 }
diff -r 1c7129898e61 -r 589751eead4c soc/soc-dapm.c
--- a/soc/soc-dapm.c	Thu Dec 28 15:40:47 2006 +0100
+++ b/soc/soc-dapm.c	Fri Jan 05 12:30:12 2007 +0100
@@ -651,7 +651,6 @@ static void dbg_dump_dapm(struct snd_soc
 							p->source->name);
 				}
 				list_for_each_entry(p, &w->sinks, list_source) {
-					p =3D list_entry(lp, struct snd_soc_dapm_path, list_source);
 					if (p->connect)
 						printk(" out %s %s\n", p->name ? p->name : "static",
 							p->sink->name);

--nextPart2356954.cFIYLeoVNL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--nextPart2356954.cFIYLeoVNL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart2356954.cFIYLeoVNL--
