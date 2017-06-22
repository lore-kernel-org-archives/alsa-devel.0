From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 6/9] pcm: add a helper function
	to query applptr
Date: Thu, 22 Jun 2017 23:43:31 +0900
Message-ID: <20170622144334.1306-7-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 46BC2266D9D
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 16:43:46 +0200 (CEST)
In-Reply-To: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
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

In some operations, application-side position for data transmission is
moved by ALSA PCM core. In this case, applications need to query the
position. Usually, this is done via mapped page frame. However, in
some cases, this is done by ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR.

This commit adds a helper function to unify the relevant codes for
readability. Additionally, to purge side effects, this commit adds
a flag.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index e3a4ee7c..a5cc5e46 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -160,6 +160,16 @@ static int sync_applptr(snd_pcm_hw_t *hw)
 	return sync_ptr1(hw, &ptr, 0);
 }
 
+static int query_applptr(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_control_fallbacked)
+		return 0;
+
+	return sync_ptr1(hw, hw->sync_ptr,
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int query_hwptr(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_status_fallbacked)
@@ -644,7 +654,7 @@ static int snd_pcm_hw_reset(snd_pcm_t *pcm)
 		SYSMSG("SNDRV_PCM_IOCTL_RESET failed (%i)", err);
 		return err;
 	}
-	return sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	return query_applptr(hw);
 }
 
 static int snd_pcm_hw_start(snd_pcm_t *pcm)
@@ -718,7 +728,7 @@ static snd_pcm_sframes_t snd_pcm_hw_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t fra
 		SYSMSG("SNDRV_PCM_IOCTL_REWIND failed (%i)", err);
 		return err;
 	}
-	err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	err = query_applptr(hw);
 	if (err < 0)
 		return err;
 	return frames;
@@ -739,7 +749,7 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 			SYSMSG("SNDRV_PCM_IOCTL_FORWARD failed (%i)", err);
 			return err;
 		}
-		err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+		err = query_applptr(hw);
 		if (err < 0)
 			return err;
 		return frames;
@@ -766,7 +776,7 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 		if (frames > (snd_pcm_uframes_t)avail)
 			frames = avail;
 		snd_pcm_mmap_appl_forward(pcm, frames);
-		err = sync_ptr(hw, 0);
+		err = issue_applptr(hw);
 		if (err < 0)
 			return err;
 		return frames;
-- 
2.11.0
