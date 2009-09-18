From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] ALSA: lx6464es - cleanup of rmh message bus
	function
Date: Fri, 18 Sep 2009 22:59:02 +0200
Message-ID: <4AB3F496.4000609@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3674788432121571123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E78B244A6
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 22:59:05 +0200 (CEST)
Received: from [192.168.178.3] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-9) with ESMTP id n8IKx4C5007876
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2009 22:59:04 +0200
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3674788432121571123==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig90B37533611364C807D3C170"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90B37533611364C807D3C170
Content-Type: multipart/mixed;
 boundary="------------040208010206010607000006"

This is a multi-part message in MIME format.
--------------040208010206010607000006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


the rmh bus is not used asynchronously, so it is safe to remove the
specific code pieces.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.h |    1 -
 sound/pci/lx6464es/lx_core.c  |   98 +----------------------------------=
------
 2 files changed, 1 insertions(+), 98 deletions(-)

--------------040208010206010607000006
Content-Type: text/x-patch;
 name="0001-ALSA-lx6464es-cleanup-of-rmh-message-bus-function.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-ALSA-lx6464es-cleanup-of-rmh-message-bus-function.patch"

diff --git a/sound/pci/lx6464es/lx6464es.h b/sound/pci/lx6464es/lx6464es.=
h
index 012c010..16442da 100644
--- a/sound/pci/lx6464es/lx6464es.h
+++ b/sound/pci/lx6464es/lx6464es.h
@@ -86,7 +86,6 @@ struct lx6464es {
=20
 	/* messaging */
 	spinlock_t		msg_lock;          /* message spinlock */
-	atomic_t	        send_message_locked;
 	struct lx_rmh           rmh;
=20
 	/* configuration */
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 5812780..3086b75 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -314,98 +314,6 @@ static inline void lx_message_dump(struct lx_rmh *rm=
h)
 #define XILINX_POLL_NO_SLEEP    100
 #define XILINX_POLL_ITERATIONS  150
=20
-#if 0 /* not used now */
-static int lx_message_send(struct lx6464es *chip, struct lx_rmh *rmh)
-{
-	u32 reg =3D ED_DSP_TIMED_OUT;
-	int dwloop;
-	int answer_received;
-
-	if (lx_dsp_reg_read(chip, eReg_CSM) & (Reg_CSM_MC | Reg_CSM_MR)) {
-		snd_printk(KERN_ERR LXP "PIOSendMessage eReg_CSM %x\n", reg);
-		return -EBUSY;
-	}
-
-	/* write command */
-	lx_dsp_reg_writebuf(chip, eReg_CRM1, rmh->cmd, rmh->cmd_len);
-
-	snd_BUG_ON(atomic_read(&chip->send_message_locked) !=3D 0);
-	atomic_set(&chip->send_message_locked, 1);
-
-	/* MicoBlaze gogogo */
-	lx_dsp_reg_write(chip, eReg_CSM, Reg_CSM_MC);
-
-	/* wait for interrupt to answer */
-	for (dwloop =3D 0; dwloop !=3D XILINX_TIMEOUT_MS; ++dwloop) {
-		answer_received =3D atomic_read(&chip->send_message_locked);
-		if (answer_received =3D=3D 0)
-			break;
-		msleep(1);
-	}
-
-	if (answer_received =3D=3D 0) {
-		/* in Debug mode verify Reg_CSM_MR */
-		snd_BUG_ON(!(lx_dsp_reg_read(chip, eReg_CSM) & Reg_CSM_MR));
-
-		/* command finished, read status */
-		if (rmh->dsp_stat =3D=3D 0)
-			reg =3D lx_dsp_reg_read(chip, eReg_CRM1);
-		else
-			reg =3D 0;
-	} else {
-		int i;
-		snd_printk(KERN_WARNING LXP "TIMEOUT lx_message_send! "
-			   "Interrupts disabled?\n");
-
-		/* attente bit Reg_CSM_MR */
-		for (i =3D 0; i !=3D XILINX_POLL_ITERATIONS; i++) {
-			if ((lx_dsp_reg_read(chip, eReg_CSM) & Reg_CSM_MR)) {
-				if (rmh->dsp_stat =3D=3D 0)
-					reg =3D lx_dsp_reg_read(chip, eReg_CRM1);
-				else
-					reg =3D 0;
-				goto polling_successful;
-			}
-
-			if (i > XILINX_POLL_NO_SLEEP)
-				msleep(1);
-		}
-		snd_printk(KERN_WARNING LXP "TIMEOUT lx_message_send! "
-			   "polling failed\n");
-
-polling_successful:
-		atomic_set(&chip->send_message_locked, 0);
-	}
-
-	if ((reg & ERROR_VALUE) =3D=3D 0) {
-		/* read response */
-		if (rmh->stat_len) {
-			snd_BUG_ON(rmh->stat_len >=3D (REG_CRM_NUMBER-1));
-
-			lx_dsp_reg_readbuf(chip, eReg_CRM2, rmh->stat,
-					   rmh->stat_len);
-		}
-	} else
-		snd_printk(KERN_WARNING LXP "lx_message_send: error_value %x\n",
-			   reg);
-
-	/* clear Reg_CSM_MR */
-	lx_dsp_reg_write(chip, eReg_CSM, 0);
-
-	switch (reg) {
-	case ED_DSP_TIMED_OUT:
-		snd_printk(KERN_WARNING LXP "lx_message_send: dsp timeout\n");
-		return -ETIMEDOUT;
-
-	case ED_DSP_CRASHED:
-		snd_printk(KERN_WARNING LXP "lx_message_send: dsp crashed\n");
-		return -EAGAIN;
-	}
-
-	lx_message_dump(rmh);
-	return 0;
-}
-#endif /* not used now */
=20
 static int lx_message_send_atomic(struct lx6464es *chip, struct lx_rmh *=
rmh)
 {
@@ -423,7 +331,7 @@ static int lx_message_send_atomic(struct lx6464es *ch=
ip, struct lx_rmh *rmh)
 	/* MicoBlaze gogogo */
 	lx_dsp_reg_write(chip, eReg_CSM, Reg_CSM_MC);
=20
-	/* wait for interrupt to answer */
+	/* wait for device to answer */
 	for (dwloop =3D 0; dwloop !=3D XILINX_TIMEOUT_MS * 1000; ++dwloop) {
 		if (lx_dsp_reg_read(chip, eReg_CSM) & Reg_CSM_MR) {
 			if (rmh->dsp_stat =3D=3D 0)
@@ -1175,10 +1083,6 @@ static int lx_interrupt_ack(struct lx6464es *chip,=
 u32 *r_irqsrc,
 		*r_async_escmd =3D 1;
 	}
=20
-	if (irqsrc & MASK_SYS_STATUS_CMD_DONE)
-		/* xilinx command notification */
-		atomic_set(&chip->send_message_locked, 0);
-
 	if (irq_async) {
 		/* snd_printd("interrupt: async event pending\n"); */
 		*r_async_pending =3D 1;


--------------040208010206010607000006--

--------------enig90B37533611364C807D3C170
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqz9JYACgkQdL+4qsZfVsv/ZwCeLSWhbbGjYJl7zOXuYDSCdJtK
Hs8An0G8IaXvqo2oA+Jl5CFNKkkjF6xn
=Efop
-----END PGP SIGNATURE-----

--------------enig90B37533611364C807D3C170--

--===============3674788432121571123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3674788432121571123==--
