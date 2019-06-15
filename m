From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] ALSA: bebob: change the range of critical
	section for stream data in PCM.hw_free callback
Date: Sat, 15 Jun 2019 18:10:58 +0900
Message-ID: <20190615091101.7515-4-o-takashi@sakamocchi.jp>
References: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C55F8F89711
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 11:11:15 +0200 (CEST)
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
 sound/firewire/bebob/bebob_pcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 530db7a7844c..e21de44deaa9 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -213,14 +213,15 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
 
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN) {
-		mutex_lock(&bebob->mutex);
+	mutex_lock(&bebob->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
 		bebob->substreams_counter--;
-		mutex_unlock(&bebob->mutex);
-	}
 
 	snd_bebob_stream_stop_duplex(bebob);
 
+	mutex_unlock(&bebob->mutex);
+
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
-- 
2.20.1
