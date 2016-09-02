From: jeeja.kp@intel.com
Subject: [PATCH] ALSA: pcm: Fix avail to return error if stream
	is suspended
Date: Fri,  2 Sep 2016 21:49:44 +0530
Message-ID: <1472833184-14226-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BE8F5267AAE
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 18:11:40 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When the stream is in suspended state some applications wait
on "Stream Pipe Error" in response to snd_pcm_avail call to
resume the stream.

In the current implementation snd_pcm_avail() returns zero
when the stream is in suspended state. This causes application
to enter in infinite loop for frames to be available.

"Stream pipe Error" code is getting returned for read/write
call when the stream is in suspended state. Similarly update
snd_pcm_avail to return -ESTRPIPE.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/core/pcm_native.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c61fd50..9d33c1e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2637,9 +2637,11 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 			break;
 		/* Fall through */
 	case SNDRV_PCM_STATE_PREPARED:
-	case SNDRV_PCM_STATE_SUSPENDED:
 		err = 0;
 		break;
+	case SNDRV_PCM_STATE_SUSPENDED:
+		err = -ESTRPIPE;
+		break;
 	case SNDRV_PCM_STATE_XRUN:
 		err = -EPIPE;
 		break;
-- 
2.5.0
