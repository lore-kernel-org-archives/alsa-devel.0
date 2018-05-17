From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/3] ALSA: seq: Avoid open-code for getting
	timer resolution
Date: Thu, 17 May 2018 10:49:10 +0200
Message-ID: <20180517084911.11868-3-tiwai@suse.de>
References: <20180517084911.11868-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B09A1266DF0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 10:49:14 +0200 (CEST)
In-Reply-To: <20180517084911.11868-1-tiwai@suse.de>
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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

Instead of open-coding for getting the timer resolution, use the
standard snd_timer_resolution() helper.

The original code falls back to the callback function when the
resolution is zero, but it must be always so when the callback
function is defined.  So this should be no functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 23167578231f..f587d0e27476 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -371,9 +371,7 @@ static int initialize_timer(struct snd_seq_timer *tmr)
 
 	tmr->ticks = 1;
 	if (!(t->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
-		unsigned long r = t->hw.resolution;
-		if (! r && t->hw.c_resolution)
-			r = t->hw.c_resolution(t);
+		unsigned long r = snd_timer_resolution(tmr->timeri);
 		if (r) {
 			tmr->ticks = (unsigned int)(1000000000uL / (r * freq));
 			if (! tmr->ticks)
-- 
2.16.3
