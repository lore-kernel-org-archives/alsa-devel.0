From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: vx: Don't try to update capture
	stream before running
Date: Wed,  4 Jan 2017 18:01:15 +0100
Message-ID: <20170104170115.9830-2-tiwai@suse.de>
References: <20170104170115.9830-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D22E267099
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 18:01:18 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3A2C2ACD3
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 17:01:18 +0000 (UTC)
In-Reply-To: <20170104170115.9830-1-tiwai@suse.de>
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

The update of stream costs significantly, and we should avoid it
unless the stream really has started.  Check pipe->running flag
instead of pipe->prepared.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/vx/vx_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 41a617886cc7..ea7b377f0378 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1015,7 +1015,7 @@ static void vx_pcm_capture_update(struct vx_core *chip, struct snd_pcm_substream
 	int size, space, count;
 	struct snd_pcm_runtime *runtime = subs->runtime;
 
-	if (! pipe->prepared || (chip->chip_status & VX_STAT_IS_STALE))
+	if (!pipe->running || (chip->chip_status & VX_STAT_IS_STALE))
 		return;
 
 	size = runtime->buffer_size - snd_pcm_capture_avail(runtime);
-- 
2.11.0
