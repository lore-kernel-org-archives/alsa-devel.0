From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 5/9] pcm: add a helper function
	to query hwptr
Date: Thu, 22 Jun 2017 23:43:30 +0900
Message-ID: <20170622144334.1306-6-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4115D266D8D
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

Usual PCM drivers in kernel land can respond applications' request about
recent hardware-side position of data transmission. In most cases, the
request is issued by ioctl(2) with SNDRV_PCM_IOCTL_HWSYNC, then the
position is shared via mapped page frame. However, when failing the
mapping, applications use SNDRV_PCM_IOCTL_SYNC_PTR command to do the
same thing as a fallback.

This commit adds a helper function to unify the relevant codes for
readability. Original implementation has a side effect to issue current
application-side position and the size of avail_min, thus has a side
effect. This commit adds some flags to purge the effect.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 23211cba..e3a4ee7c 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -160,6 +160,17 @@ static int sync_applptr(snd_pcm_hw_t *hw)
 	return sync_ptr1(hw, &ptr, 0);
 }
 
+static int query_hwptr(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_status_fallbacked)
+		return 0;
+
+	return sync_ptr1(hw, hw->sync_ptr,
+			 SNDRV_PCM_SYNC_PTR_HWSYNC |
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int query_status(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_status_fallbacked)
@@ -585,8 +596,8 @@ static int snd_pcm_hw_hwsync(snd_pcm_t *pcm)
 	snd_pcm_hw_t *hw = pcm->private_data;
 	int fd = hw->fd, err;
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 3) <= hw->version) {
-		if (hw->sync_ptr) {
-			err = sync_ptr1(hw, hw->sync_ptr, SNDRV_PCM_SYNC_PTR_HWSYNC);
+		if (hw->mmap_status_fallbacked) {
+			err = query_hwptr(hw);
 			if (err < 0)
 				return err;
 		} else {
@@ -735,7 +746,7 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 	} else {
 		snd_pcm_sframes_t avail;
 
-		err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_HWSYNC);
+		err = query_hwptr(hw);
 		if (err < 0)
 			return err;
 		switch (FAST_PCM_STATE(hw)) {
-- 
2.11.0
