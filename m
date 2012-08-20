From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] snd-als100: fix suspend/resume
Date: Mon, 20 Aug 2012 21:50:13 +0200
Message-ID: <201208202150.13593.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 26C02265E78
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 21:50:40 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Piccioni <dafastidio@libero.it>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_card_als100_probe() does not set pcm field in struct snd_sb.
As a result, PCM is not suspended and applications don't know that they need
to resume the playback.

Tested with Labway A381-F20 card (ALS120).

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -233,7 +233,7 @@ static int __devinit snd_card_als100_probe(int dev,
 			irq[dev], dma8[dev], dma16[dev]);
 	}
 
-	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
+	if ((error = snd_sb16dsp_pcm(chip, 0, &chip->pcm)) < 0) {
 		snd_card_free(card);
 		return error;
 	}




-- 
Ondrej Zary
