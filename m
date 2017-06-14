From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: pcm: remove SNDRV_PCM_IOCTL1_GSTATE
	internal command
Date: Wed, 14 Jun 2017 19:30:04 +0900
Message-ID: <20170614103004.6205-3-o-takashi@sakamocchi.jp>
References: <20170614103004.6205-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 38D2C26720D
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 12:30:09 +0200 (CEST)
In-Reply-To: <20170614103004.6205-1-o-takashi@sakamocchi.jp>
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

SNDRV_PCM_IOCTL1_GSTATE was firstly introduced in v0.9.0, however never
be used and the purpose is missing.

This commit removes the long-abandoned command, bye.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 48e3eecac86d..5a22075c5fcf 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -104,7 +104,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_IOCTL1_RESET		0
 /* 1 is absent slot. */
 #define SNDRV_PCM_IOCTL1_CHANNEL_INFO	2
-#define SNDRV_PCM_IOCTL1_GSTATE		3
+/* 3 is absent slot. */
 #define SNDRV_PCM_IOCTL1_FIFO_SIZE	4
 
 #define SNDRV_PCM_TRIGGER_STOP		0
-- 
2.11.0
