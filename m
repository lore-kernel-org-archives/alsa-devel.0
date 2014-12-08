From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 6/9] ALSA: core: pass audio tstamp config
	from userspace
Date: Mon,  8 Dec 2014 16:23:43 -0600
Message-ID: <1418077426-8309-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DC9302605B7
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:41 +0100 (CET)
In-Reply-To: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Let userspace select audio timestamp config, ignore and zero all
other fields

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_native.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 37a7137..7dcd6bd 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -706,6 +706,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	snd_pcm_stream_lock_irq(substream);
+	memset(status, 0, sizeof(*status));
 	status->state = runtime->status->state;
 	status->suspended_state = runtime->status->suspended_state;
 	if (status->state == SNDRV_PCM_STATE_OPEN)
@@ -757,7 +758,8 @@ static int snd_pcm_status_user(struct snd_pcm_substream *substream,
 	struct snd_pcm_status status;
 	int res;
 	
-	memset(&status, 0, sizeof(status));
+	if (copy_from_user(&status, _status, sizeof(status)))
+		return -EFAULT;
 	res = snd_pcm_status(substream, &status);
 	if (res < 0)
 		return res;
-- 
2.1.0
