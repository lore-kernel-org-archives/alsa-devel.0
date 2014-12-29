From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/9] ALSA: pcm: Remove unused
	SNDRV_PCM_IOCTL1_{FALSE, TRUE} defines
Date: Mon, 29 Dec 2014 19:41:39 +0100
Message-ID: <1419878506-28684-2-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C272605C0
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:50 +0100 (CET)
In-Reply-To: <1419878506-28684-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Both SNDRV_PCM_IOCTL1_FALSE and SNDRV_PCM_IOCTL1_TRUE are unused and have in
fact never been used (at least as far as the git history goes).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e7f74a..dbf2f7f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -94,9 +94,6 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_DEVICES	8
 #endif
 
-#define SNDRV_PCM_IOCTL1_FALSE		((void *)0)
-#define SNDRV_PCM_IOCTL1_TRUE		((void *)1)
-
 #define SNDRV_PCM_IOCTL1_RESET		0
 #define SNDRV_PCM_IOCTL1_INFO		1
 #define SNDRV_PCM_IOCTL1_CHANNEL_INFO	2
-- 
1.8.0
