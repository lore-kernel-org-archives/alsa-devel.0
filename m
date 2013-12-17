From: JongHo Kim <furmuwon@gmail.com>
Subject: [PATCH][RESEND] ALSA: Add SNDRV_PCM_STATE_PAUSED case
 in wait_for_avail function
Date: Tue, 17 Dec 2013 23:02:24 +0900 (KST)
Message-ID: <alpine.DEB.2.02.1312172257380.4466@homeuser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 4243F261178
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 15:02:33 +0100 (CET)
Received: by mail-pb0-f53.google.com with SMTP id ma3so6978175pbc.40
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 06:02:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the process is sleeping at the SNDRV_PCM_STATE_PAUSED
state from the wait_for_avail function, the sleep process will be woken by
timeout(10 seconds). Even if the sleep process wake up by timeout, by this
patch, the process will continue with sleep and wait for the other state.

Signed-off-by: JongHo Kim <furmuwon@gmail.com>
---
  sound/core/pcm_lib.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6e03b46..a210467 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1937,6 +1937,8 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
  		case SNDRV_PCM_STATE_DISCONNECTED:
  			err = -EBADFD;
  			goto _endloop;
+		case SNDRV_PCM_STATE_PAUSED:
+			continue;
  		}
  		if (!tout) {
  			snd_printd("%s write error (DMA or IRQ trouble?)\n",
-- 
1.8.1.2
