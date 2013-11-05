From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: sparc/cs4231: Use WARN_ON() instead
	of BUG_ON()
Date: Tue,  5 Nov 2013 18:10:41 +0100
Message-ID: <1383671443-13707-4-git-send-email-tiwai@suse.de>
References: <1383671443-13707-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 150DD265074
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:47 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E1714A67EA
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:46 +0100 (CET)
In-Reply-To: <1383671443-13707-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sparc/cs4231.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 54aaad2a10f5..b47f6fe6277f 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -429,7 +429,8 @@ static void snd_cs4231_advance_dma(struct cs4231_dma_control *dma_cont,
 		unsigned int period_size = snd_pcm_lib_period_bytes(substream);
 		unsigned int offset = period_size * (*periods_sent);
 
-		BUG_ON(period_size >= (1 << 24));
+		if (WARN_ON(period_size >= (1 << 24)))
+			return;
 
 		if (dma_cont->request(dma_cont,
 				      runtime->dma_addr + offset, period_size))
@@ -912,7 +913,8 @@ static int snd_cs4231_playback_prepare(struct snd_pcm_substream *substream)
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
 					    CS4231_PLAYBACK_PIO);
 
-	BUG_ON(runtime->period_size > 0xffff + 1);
+	if (WARN_ON(runtime->period_size > 0xffff + 1))
+		return -EINVAL;
 
 	chip->p_periods_sent = 0;
 	spin_unlock_irqrestore(&chip->lock, flags);
-- 
1.8.4.2
