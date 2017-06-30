From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib v2 6/6] pcm: hw: remove superfluous
	code to call of SNDRV_PCM_IOCTL_SYNC_PTR in snd_pcm_hw_forward()
Date: Fri, 30 Jun 2017 20:37:29 +0900
Message-ID: <20170630113729.13656-7-o-takashi@sakamocchi.jp>
References: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7AF192674A3
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:37:36 +0200 (CEST)
In-Reply-To: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
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

SNDRV_PCM_IOCTL_SYNC_PTR command was introduced to PCM protocol/interface
in its version 2.0.7, however this command is used in a branch for the
newer version protocol/interface in snd_pcm_hw_forward().

This commit removes the superfluous code as a part of work for code
refactoring.

Fixes: eafb4925124b ("- added SYNC_PTR ioctl support for pcm_hw plugin")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 9c8fc3f6..16d45e74 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -144,13 +144,6 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
-static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
-{
-	if (hw->mmap_status_fallbacked || hw->mmap_control_fallbacked)
-		return sync_ptr1(hw, flags);
-	return 0;
-}
-
 static int issue_avail_min(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_control_fallbacked)
@@ -777,9 +770,6 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 	} else {
 		snd_pcm_sframes_t avail;
 
-		err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_HWSYNC);
-		if (err < 0)
-			return err;
 		switch (FAST_PCM_STATE(hw)) {
 		case SNDRV_PCM_STATE_RUNNING:
 		case SNDRV_PCM_STATE_DRAINING:
@@ -797,9 +787,6 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 		if (frames > (snd_pcm_uframes_t)avail)
 			frames = avail;
 		snd_pcm_mmap_appl_forward(pcm, frames);
-		err = sync_ptr(hw, 0);
-		if (err < 0)
-			return err;
 		return frames;
 	}
 }
-- 
2.11.0
