From: libin.yang@intel.com
Subject: [PATCH 1/2] [ALSA] add SNDRV_PCM_TRIGGER_DRAIN trigger
Date: Thu, 18 Dec 2014 15:36:03 +0800
Message-ID: <1418888164-41117-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CC992604BC
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 08:40:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Add SNDRV_PCM_TRIGGER_DRAIN trigger for pcm drain.

Some audio devices require notification of drain events
in order to properly drain and shutdown an audio stream.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 include/sound/pcm.h     | 1 +
 sound/core/pcm_native.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 8bb00a2..bb77aa3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -109,6 +109,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_TRIGGER_PAUSE_RELEASE	4
 #define SNDRV_PCM_TRIGGER_SUSPEND	5
 #define SNDRV_PCM_TRIGGER_RESUME	6
+#define SNDRV_PCM_TRIGGER_DRAIN		7
 
 #define SNDRV_PCM_POS_XRUN		((snd_pcm_uframes_t)-1)
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 166d59c..15fe682 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1517,6 +1517,11 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, int state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+
+		if (substream->runtime->trigger_master == substream)
+			substream->ops->trigger(substream,
+					SNDRV_PCM_TRIGGER_DRAIN);
+
 		switch (runtime->status->state) {
 		case SNDRV_PCM_STATE_PREPARED:
 			/* start playback stream if possible */
-- 
1.9.1
