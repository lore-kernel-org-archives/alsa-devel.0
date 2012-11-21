From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] ALSA: PCM: Remove redundant null check
	before kfree
Date: Wed, 21 Nov 2012 14:36:54 +0530
Message-ID: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 35801265369
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:13:13 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so2642606pbb.38
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:13:12 -0800 (PST)
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
Cc: patches@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

kfree on a null pointer is a no-op.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested and based on linux-next 20121115.
---
 sound/core/pcm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 030102c..61798f8 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -981,8 +981,7 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
 	kfree(runtime->hw_constraints.rules);
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	if (runtime->hwptr_log)
-		kfree(runtime->hwptr_log);
+	kfree(runtime->hwptr_log);
 #endif
 	kfree(runtime);
 	substream->runtime = NULL;
-- 
1.7.4.1
