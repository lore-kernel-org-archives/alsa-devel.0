From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 07/12] pcm: hw: use helper function to
	query status/control data for calculation of available space
	on PCM buffer
Date: Fri, 30 Jun 2017 08:58:23 +0900
Message-ID: <20170629235828.18076-8-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7D4B82673FB
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

When calculating available space on PCM buffer, positions of hw_ptr and
appl_ptr are required. When applications map staus and control data
successfully, they can calculate the space with architecture's support
for cache coherency. When failed, they should execute ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR command to query these positions to kernel
space.

This commit uses an added helper function for this purpose. For this call,
no need to update appl_ptr and avail_min in kernel space.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 59ba33b5..c6abf170 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1066,7 +1066,7 @@ static snd_pcm_sframes_t snd_pcm_hw_avail_update(snd_pcm_t *pcm)
 	snd_pcm_hw_t *hw = pcm->private_data;
 	snd_pcm_uframes_t avail;
 
-	sync_ptr(hw, 0);
+	query_state(hw);
 	avail = snd_pcm_mmap_avail(pcm);
 	switch (FAST_PCM_STATE(hw)) {
 	case SNDRV_PCM_STATE_RUNNING:
-- 
2.11.0
