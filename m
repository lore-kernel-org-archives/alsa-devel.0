From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 04/12] pcm: hw: use helper function to
	query status/control data after HW_PARAMS call
Date: Fri, 30 Jun 2017 08:58:20 +0900
Message-ID: <20170629235828.18076-5-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 180782673F5
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:32 +0200 (CEST)
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

When executing ioctl(2) with SNDRV_PCM_IOCTL_HW_PARAMS, applications
request ALSA PCM core to decide configurations of runtime of PCM
substream. This operation shifts state of the runtime after the decision.
Additionally, avail_min of the runtime is reset to the size of one period
of PCM buffer.

When alsa-lib applications run with fallback mode from failure of page
mapping of status/control data, the data in user space should be updated.
On the other hand, they don't need to change/update control data. Current
implementation of alsa-lib satisfies this principle with sub-effect to
the control data. For this purpose, an added helper function can be
available.

This commit replaces with the function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 50619fe9..aa548529 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -349,7 +349,7 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	params->info &= ~0xf0000000;
 	if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
 		params->info |= SND_PCM_INFO_MONOTONIC;
-	return sync_ptr(hw, 0);
+	return query_state(hw);
 }
 
 static void snd_pcm_hw_close_timer(snd_pcm_hw_t *hw)
-- 
2.11.0
