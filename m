From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] vwsnd: Fix setting of cfgval and ctlval in
	li_setup_dma()
Date: Wed, 26 Aug 2009 12:01:20 +0200
Message-ID: <4A9507F0.3070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 61F8D2457F
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Aug 2009 11:56:43 +0200 (CEST)
Received: by ewy19 with SMTP id 19so4222158ewy.44
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2009 02:56:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Since !LI_CCFG_* evaluates to 0, this did not change anything to
cfgval and ctlval.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
// vi sound/oss/vwsnd.c +392
# define LI_CCTL_RESET		 0x80000000
...
# define LI_CCTL_DMA_ENABLE	 0x08000000
...
# define LI_CCFG_LOCK		 0x00008000

I am not sure this is what was intended, does anyone have the
specs?

diff --git a/sound/oss/vwsnd.c b/sound/oss/vwsnd.c
index 187f727..6713110 100644
--- a/sound/oss/vwsnd.c
+++ b/sound/oss/vwsnd.c
@@ -628,7 +628,7 @@ static void li_setup_dma(dma_chan_t *chan,
 	ASSERT(!(buffer_paddr & 0xFF));
 	chan->baseval = (buffer_paddr >> 8) | 1 << (37 - 8);
 
-	chan->cfgval = (!LI_CCFG_LOCK |
+	chan->cfgval = ((chan->cfgval & ~LI_CCFG_LOCK) |
 			SHIFT_FIELD(desc->ad1843_slot, LI_CCFG_SLOT) |
 			desc->direction |
 			mode |
@@ -638,9 +638,9 @@ static void li_setup_dma(dma_chan_t *chan,
 	tmask = 13 - fragshift;		/* See Lithium DMA Notes above. */
 	ASSERT(size >= 2 && size <= 7);
 	ASSERT(tmask >= 1 && tmask <= 7);
-	chan->ctlval = (!LI_CCTL_RESET |
+	chan->ctlval = ((chan->ctlval & ~LI_CCTL_RESET) |
 			SHIFT_FIELD(size, LI_CCTL_SIZE) |
-			!LI_CCTL_DMA_ENABLE |
+			(chan->ctlval & ~LI_CCTL_DMA_ENABLE) |
 			SHIFT_FIELD(tmask, LI_CCTL_TMASK) |
 			SHIFT_FIELD(0, LI_CCTL_TPTR));
