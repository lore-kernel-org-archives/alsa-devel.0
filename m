From: Martin Langer <martin-langer@gmx.de>
Subject: PATCH] 3/3 miro: set mixer values for aci on startup
Date: Fri, 24 Jun 2005 01:02:32 +0200
Message-ID: <20050623230232.GA3304@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id F312221E
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 01:00:08 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50)
	id 1DlaiO-0000s5-55
	for alsa-devel@alsa-project.org; Fri, 24 Jun 2005 01:02:32 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It's much better to start the PCM20 with known values in the aci regs. 
The patch sets a bunch of mixer regs during init now. We've had a few 
aci register inits before. Now they are all merged into one function.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miro_init.patch"

--- isa/opti9xx/miro.c.2_mpu401	Fri Jun 24 00:19:26 2005
+++ isa/opti9xx/miro.c	Fri Jun 24 00:20:26 2005
@@ -613,6 +613,68 @@
 	.put = snd_miro_put_capture,
 }};
 
+static unsigned char aci_init_values[][2] __initdata = {
+	{ ACI_SET_MUTE, 0x00 },
+	{ ACI_SET_POWERAMP, 0x00 },
+	{ ACI_SET_PREAMP, 0x00 },
+	{ ACI_SET_SOLOMODE, 0x00 },
+	{ ACI_SET_MIC + 0, 0x20 },
+	{ ACI_SET_MIC + 8, 0x20 },
+	{ ACI_SET_LINE + 0, 0x20 },
+	{ ACI_SET_LINE + 8, 0x20 },
+	{ ACI_SET_CD + 0, 0x20 },
+	{ ACI_SET_CD + 8, 0x20 },
+	{ ACI_SET_PCM + 0, 0x20 },
+	{ ACI_SET_PCM + 8, 0x20 },
+	{ ACI_SET_LINE1 + 0, 0x20 },
+	{ ACI_SET_LINE1 + 8, 0x20 },
+	{ ACI_SET_LINE2 + 0, 0x20 },
+	{ ACI_SET_LINE2 + 8, 0x20 },
+	{ ACI_SET_SYNTH + 0, 0x20 },
+	{ ACI_SET_SYNTH + 8, 0x20 },
+	{ ACI_SET_MASTER + 0, 0x20 },
+	{ ACI_SET_MASTER + 1, 0x20 },
+};
+
+static int __devinit snd_set_aci_init_values(miro_t *miro)
+{
+	int idx, error;
+
+	/* enable WSS on PCM1 */
+
+	if ((miro->aci_product == 'A') && wss) {
+		if ((error = aci_setvalue(miro, ACI_SET_WSS, wss)) < 0) {
+			snd_printk("enabling WSS mode failed\n");
+			return error;
+		}
+	}
+
+	/* enable IDE port */
+
+	if (ide) {
+		if ((error = aci_setvalue(miro, ACI_SET_IDE, ide)) < 0) {
+			snd_printk("enabling IDE port failed\n");
+			return error;
+		}
+	}
+
+	/* set common aci values */
+
+	for (idx = 0; idx < ARRAY_SIZE(aci_init_values); idx++)
+                if ((error = aci_setvalue(miro, aci_init_values[idx][0], 
+					  aci_init_values[idx][1])) < 0) {
+                        snd_printk("aci_setvalue(%d) failed: %d\n", 
+				   aci_init_values[idx][0], error);
+                        return error;
+                }
+
+	miro->aci_amp = 0;
+	miro->aci_preamp = 0;
+	miro->aci_solomode = 1;
+
+	return 0;
+}
+
 static int snd_miro_mixer(miro_t *miro)
 {
 	snd_card_t *card;
@@ -1332,60 +1394,9 @@
 				&rmidi)))
 			snd_printk("no MPU-401 device at 0x%lx?\n", miro->mpu_port);
 
-	/* the aci mixer is muted after reset */
-
-	if (aci_cmd(miro, ACI_SET_MUTE, 0x00, -1) < 0) {
-		snd_printk("unset aci muting failed\n");
+	if ((error = snd_set_aci_init_values(miro)) < 0) {
 		snd_card_free(card);
-		return -EBUSY;
-	}
-
-	/* enable WSS on PCM1 */
-
-	if ((miro->aci_product == 'A') && wss) {
-		if ((error = aci_cmd(miro, ACI_SET_WSS, wss, -1)) < 0) {
-			snd_printk("jumping into WSS mode failed\n");
-			snd_card_free(card);
-			return -EIO;
-		}
-	}
-
-	/* enable IDE port */
-
-	if (ide) {
-		if ((error = aci_cmd(miro, ACI_SET_IDE, ide, -1)) < 0) {
-			snd_printk("enabling IDE port failed\n");
-			snd_card_free(card);
-			return -EIO;
-		}
-	}
-
-	/* disable aci preamp and poweramp */
-
-	if ((error = aci_setvalue(miro, ACI_SET_POWERAMP, 0)) < 0) {
-		snd_printk("unset aci power-amp failed\n");
-		snd_card_free(card);
-		return -EIO;
-	} else {
-		miro->aci_amp = 0;
-	}
-
-	if ((error = aci_setvalue(miro, ACI_SET_PREAMP, 0)) < 0) {
-		snd_printk("unset aci pre-amp failed\n");
-		snd_card_free(card);
-		return -EIO;
-	} else {
-		miro->aci_preamp = 0;
-	}
-
-	/* solo mode init */
-
-	if ((error = aci_setvalue(miro, ACI_SET_SOLOMODE, 0)) < 0) {
-		snd_printk("unset solomode failed\n");
-		snd_card_free(card);
-		return -EIO;
-	} else {
-		miro->aci_solomode = 1;
+                return error;
 	}
 
 	if ((error = snd_card_register(card))) {

--17pEHd4RhPHOinZp--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
