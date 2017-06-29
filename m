From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 05/12] pcm: hw: use helper function to
	query status/control data after PREPARE/RESET call
Date: Fri, 30 Jun 2017 08:58:21 +0900
Message-ID: <20170629235828.18076-6-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 784302673F9
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:35 +0200 (CEST)
In-Reply-To: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
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

In ALSA PCM core, calls of ioctl(2) with SNDRV_PCM_IOCTL_PREPARE and
SNDRV_PCM_IOCTL_RESET have effects to initialize appl_ptr to current
hw_ptr and shift state of runtime. On the other hand, avail_min of the
runtime is kept as is.

In a fallback mode of status data mapping, after executing the call,
applications should execute ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR to
query appl_ptr and the state, while don't need to issue avail_min.

This commit applies a minor optimization to the call.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index aa548529..6f20cbff 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -615,7 +615,7 @@ static int snd_pcm_hw_prepare(snd_pcm_t *pcm)
 		SYSMSG("SNDRV_PCM_IOCTL_PREPARE failed (%i)", err);
 		return err;
 	}
-	return sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	return query_state(hw);
 }
 
 static int snd_pcm_hw_reset(snd_pcm_t *pcm)
@@ -627,7 +627,7 @@ static int snd_pcm_hw_reset(snd_pcm_t *pcm)
 		SYSMSG("SNDRV_PCM_IOCTL_RESET failed (%i)", err);
 		return err;
 	}
-	return sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	return query_state(hw);
 }
 
 static int snd_pcm_hw_start(snd_pcm_t *pcm)
-- 
2.11.0
