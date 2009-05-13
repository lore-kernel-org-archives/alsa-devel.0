From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] riptide: postfix increment and off by one
Date: Wed, 13 May 2009 20:44:07 +0200
Message-ID: <4A0B14F7.20905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id BED1C1038CA
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:44:10 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1024894ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 11:44:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

With a postfix increment these variables are incremented beyond
CMDIF_TIMEOUT / MAX_WRITE_RETRY.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 6f10344..e51a5ef 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -889,7 +889,7 @@ static int sendcmd(struct cmdif *cif, u32 flags, u32 cmd, u32 parm,
 	spin_lock_irqsave(&cif->lock, irqflags);
 	while (i++ < CMDIF_TIMEOUT && !IS_READY(cif->hwport))
 		udelay(10);
-	if (i >= CMDIF_TIMEOUT) {
+	if (i > CMDIF_TIMEOUT) {
 		err = -EBUSY;
 		goto errout;
 	}
@@ -907,8 +907,10 @@ static int sendcmd(struct cmdif *cif, u32 flags, u32 cmd, u32 parm,
 			WRITE_PORT_ULONG(cmdport->data1, cmd);	/* write cmd */
 			if ((flags & RESP) && ret) {
 				while (!IS_DATF(cmdport) &&
-				       time++ < CMDIF_TIMEOUT)
+				       time < CMDIF_TIMEOUT) {
 					udelay(10);
+					time++;
+				}
 				if (time < CMDIF_TIMEOUT) {	/* read response */
 					ret->retlongs[0] =
 					    READ_PORT_ULONG(cmdport->data1);
@@ -1454,7 +1456,7 @@ static int snd_riptide_trigger(struct snd_pcm_substream *substream, int cmd)
 			SEND_GPOS(cif, 0, data->id, &rptr);
 			udelay(1);
 		} while (i != rptr.retlongs[1] && j++ < MAX_WRITE_RETRY);
-		if (j >= MAX_WRITE_RETRY)
+		if (j > MAX_WRITE_RETRY)
 			snd_printk(KERN_ERR "Riptide: Could not stop stream!");
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -1783,7 +1785,7 @@ snd_riptide_codec_write(struct snd_ac97 *ac97, unsigned short reg,
 		SEND_SACR(cif, val, reg);
 		SEND_RACR(cif, reg, &rptr);
 	} while (rptr.retwords[1] != val && i++ < MAX_WRITE_RETRY);
-	if (i == MAX_WRITE_RETRY)
+	if (i > MAX_WRITE_RETRY)
 		snd_printdd("Write AC97 reg failed\n");
 }
