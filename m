From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] ALSA: fireworks: change the range of
	critical section for stream data in PCM.hw_free callback
Date: Sat, 15 Jun 2019 18:11:00 +0900
Message-ID: <20190615091101.7515-6-o-takashi@sakamocchi.jp>
References: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56350F89712
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 11:11:18 +0200 (CEST)
In-Reply-To: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The operation of duplex streams should be in critical section.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_pcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 287fc05d5917..8dc34249a1b0 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -247,14 +247,15 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
-		mutex_lock(&efw->mutex);
+	mutex_lock(&efw->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
 		--efw->substreams_counter;
-		mutex_unlock(&efw->mutex);
-	}
 
 	snd_efw_stream_stop_duplex(efw);
 
+	mutex_unlock(&efw->mutex);
+
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
-- 
2.20.1
