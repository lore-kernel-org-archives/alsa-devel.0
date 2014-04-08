From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] sound: lx_core: Few misc cleanups
Date: Tue,  8 Apr 2014 16:15:33 +0200
Message-ID: <1396966533-505-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, iwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

This file had a few comments in french that are now in english, and too=
k the
opportunity to cleanup a bunch of #if 0 .. #endif and commented out cod=
e

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/pci/lx6464es/lx_core.c | 70 +++++++++++++++++-------------------=
--------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.=
c
index 626ecad4dae7..002049770ff7 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -22,8 +22,7 @@
  *
  */
=20
-/* #define RMH_DEBUG 1 */
-
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -496,15 +495,17 @@ int lx_dsp_es_check_pipeline(struct lx6464es *chi=
p)
 	int i;
=20
 	for (i =3D 0; i !=3D CSES_TIMEOUT; ++i) {
-		/*
-		 * le bit CSES_UPDATE_LDSV est =C3=83=C2=A0 1 d=C3=83=C2=A9s que le =
macprog
-		 * est pret. il re-passe =C3=83=C2=A0 0 lorsque le premier read a
-		 * =C3=83=C2=A9t=C3=83=C2=A9 fait. pour l'instant on retire le test =
car ce bit
-		 * passe a 1 environ 200 =C3=83=C2=A0 400 ms apr=C3=83=C2=A9s que le=
 registre
-		 * confES =C3=83=C2=A0 =C3=83=C2=A9t=C3=83=C2=A9 =C3=83=C2=A9crit (k=
ick du xilinx ES).
+		/*=20
+		 * The bit CSES_UPDATE_LDSV is set to 1 as soon as the
+		 * macprog is ready. He goes back to 0 whenever the
+		 * first read has been issued.
+		 *
+		 * For now, we don't bother testing this bit because
+		 * it's set to 1 between 200 to 400ms after the confES
+		 * register has been written to (xilinx ES kick).
 		 *
-		 * On ne teste que le bit CE.
-		 * */
+		 * We only test the CE bit.
+		 */
=20
 		u32 cses =3D lx_dsp_reg_read(chip, eReg_CSES);
=20
@@ -602,8 +603,7 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, =
int is_capture,
 				/* free */
 				*r_needed +=3D 1;
 		}
-
-#if 0
+#if DEBUG
 		snd_printdd(LXP "CMD_08_ASK_BUFFERS: needed %d, freed %d\n",
 			    *r_needed, *r_freed);
 		for (i =3D 0; i < MAX_STREAM_BUFFER; ++i) {
@@ -1049,9 +1049,9 @@ int lx_level_peaks(struct lx6464es *chip, int is_=
capture, int channels,
=20
 /* interrupt handling */
 #define PCX_IRQ_NONE 0
-#define IRQCS_ACTIVE_PCIDB  0x00002000L         /* Bit n=C3=83=C2=83=C3=
=82=C2=B8 13 */
-#define IRQCS_ENABLE_PCIIRQ 0x00000100L         /* Bit n=C3=83=C2=83=C3=
=82=C2=B8 08 */
-#define IRQCS_ENABLE_PCIDB  0x00000200L         /* Bit n=C3=83=C2=83=C3=
=82=C2=B8 09 */
+#define IRQCS_ACTIVE_PCIDB	BIT(13)
+#define IRQCS_ENABLE_PCIIRQ	BIT(8)
+#define IRQCS_ENABLE_PCIDB	BIT(9)
=20
 static u32 lx_interrupt_test_ack(struct lx6464es *chip)
 {
@@ -1108,25 +1108,21 @@ static int lx_interrupt_handle_async_events(str=
uct lx6464es *chip, u32 irqsrc,
 	int err;
 	u32 stat[9];		/* answer from CMD_04_GET_EVENT */
=20
-	/* On peut optimiser pour ne pas lire les evenements vides
-	 * les mots de r=C3=83=C2=83=C3=82=C2=A9ponse sont dans l'ordre suiva=
nt :
-	 * Stat[0]	mot de status g=C3=83=C2=83=C3=82=C2=A9n=C3=83=C2=83=C3=82=
=C2=A9ral
-	 * Stat[1]	fin de buffer OUT pF
-	 * Stat[2]	fin de buffer OUT pf
-	 * Stat[3]	fin de buffer IN pF
-	 * Stat[4]	fin de buffer IN pf
-	 * Stat[5]	underrun poid fort
-	 * Stat[6]	underrun poid faible
-	 * Stat[7]	overrun poid fort
-	 * Stat[8]	overrun poid faible
+	/* We can optimize this to not read dumb events.
+	 * Answer words are in the following order:
+	 * Stat[0]	general status
+	 * Stat[1]	end of buffer OUT pF
+	 * Stat[2]	end of buffer OUT pf
+	 * Stat[3]	end of buffer IN pF
+	 * Stat[4]	end of buffer IN pf
+	 * Stat[5]	MSB underrun
+	 * Stat[6]	LSB underrun
+	 * Stat[7]	MSB overrun
+	 * Stat[8]	LSB overrun
 	 * */
=20
 	u64 orun_mask;
 	u64 urun_mask;
-#if 0
-	int has_underrun   =3D (irqsrc & MASK_SYS_STATUS_URUN) ? 1 : 0;
-	int has_overrun    =3D (irqsrc & MASK_SYS_STATUS_ORUN) ? 1 : 0;
-#endif
 	int eb_pending_out =3D (irqsrc & MASK_SYS_STATUS_EOBO) ? 1 : 0;
 	int eb_pending_in  =3D (irqsrc & MASK_SYS_STATUS_EOBI) ? 1 : 0;
=20
@@ -1272,7 +1268,7 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 	if (irqsrc & MASK_SYS_STATUS_CMD_DONE)
 		goto exit;
=20
-#if 0
+#if DEBUG
 	if (irqsrc & MASK_SYS_STATUS_EOBI)
 		snd_printdd(LXP "interrupt: EOBI\n");
=20
@@ -1310,18 +1306,6 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 				   "error during audio transfer\n");
 	}
=20
-	if (async_escmd) {
-#if 0
-		/* backdoor for ethersound commands
-		 *
-		 * for now, we do not need this
-		 *
-		 * */
-
-		snd_printdd("lx6464es: interrupt requests escmd handling\n");
-#endif
-	}
-
 exit:
 	spin_unlock(&chip->lock);
 	return IRQ_HANDLED;	/* this device caused the interrupt */
--=20
1.9.1
