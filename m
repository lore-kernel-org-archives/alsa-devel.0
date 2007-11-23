From: Heikki O Lindholm <holindho@cs.helsinki.fi>
Subject: [PATCH] add number of periods constraint to snd-aoa
Date: Fri, 23 Nov 2007 11:43:31 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0711231124500.26092@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A161244B7
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 10:43:32 +0100 (CET)
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
Cc: tiwai@suse.de, johannes@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

From: Heikki Lindholm <holindho@cs.helsinki.fi>

The aoa driver is not specifying constraints on number of periods, and, it 
seems, it might end with a non-integer number, which it cannot deal with. 
Fix by adding a proper constraint.

Signed-off-by: Heikki Lindholm  <holindho@cs.helsinki.fi>
---
diff -r 1b54a8725ded aoa/soundbus/i2sbus/i2sbus-pcm.c
--- a/aoa/soundbus/i2sbus/i2sbus-pcm.c	Wed Nov 14 17:07:17 2007 +0100
+++ b/aoa/soundbus/i2sbus/i2sbus-pcm.c	Fri Nov 23 11:35:17 2007 +0200
@@ -196,7 +196,10 @@ static int i2sbus_pcm_open(struct i2sbus
 	hw->periods_max = MAX_DBDMA_COMMANDS;
 	list_for_each_entry(cii, &sdev->codec_list, list) {
 		if (cii->codec->open) {
-			err = cii->codec->open(cii, pi->substream);
+			if ((err = cii->codec->open(cii, pi->substream)) == 0)
+				err = snd_pcm_hw_constraint_integer(
+					pi->substream->runtime,
+					SNDRV_PCM_HW_PARAM_PERIODS);
 			if (err) {
 				result = err;
 				/* unwind */
