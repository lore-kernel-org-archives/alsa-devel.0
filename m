From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/2] ALSA: pcm: Forcibly stop at disconnect
	callback
Date: Wed, 11 Oct 2017 12:16:18 +0200
Message-ID: <20171011101618.8736-3-tiwai@suse.de>
References: <20171011101618.8736-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EBC41267348
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 12:16:26 +0200 (CEST)
In-Reply-To: <20171011101618.8736-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

So far we assumed that each driver implements the hotplug PCM handling
properly, e.g. dealing with the pending PCM stream at disconnect
callback.  But most codes don't care, and it eventually leaves the PCM
stream inconsistent state when an abrupt disconnection like sysfs
unbind happens.

This patch is simple but a big-hammer solution: invoke snd_pcm_stop()
at the common PCM disconnect callback always when the stream is
running.

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 7eadb7fd8074..054e47ad23ed 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1152,6 +1152,10 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next) {
 			snd_pcm_stream_lock_irq(substream);
 			if (substream->runtime) {
+				if (snd_pcm_running(substream))
+					snd_pcm_stop(substream,
+						     SNDRV_PCM_STATE_DISCONNECTED);
+				/* to be sure, set the state unconditionally */
 				substream->runtime->status->state = SNDRV_PCM_STATE_DISCONNECTED;
 				wake_up(&substream->runtime->sleep);
 				wake_up(&substream->runtime->tsleep);
-- 
2.14.2
