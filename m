From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib v2 3/6] pcm: hw: add a helper function
	to request hwsync without side-effects
Date: Fri, 30 Jun 2017 20:37:26 +0900
Message-ID: <20170630113729.13656-4-o-takashi@sakamocchi.jp>
References: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id F153126749F
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:37:33 +0200 (CEST)
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

SNDRV_PCM_IOCTL_SYNC_PTR command for ioctl(2) with
SNDRV_PCM_SYNC_PTR_HWSYNC flag has an effect to update hw_ptr.
This is an alternative of SNDRV_PCM_IOCTL_HWSYNC but caller can get
current status simultaneously.

This commit adds a helper function just to issue hwsync. To avoid
side-effect to change appl_ptr and avail_min, this commit uses
SNDRV_PCM_SYNC_PTR_APPL and SNDRV_PCM_SYNC_PTR_AVAIL_MIN flags.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 38d975af..8455baaf 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -151,6 +151,21 @@ static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
+static int request_hwsync(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_status_fallbacked)
+		return 0;
+
+	/*
+	 * Query both of control/status data to avoid unexpected change of
+	 * control data in kernel space.
+	 */
+	return sync_ptr1(hw,
+			 SNDRV_PCM_SYNC_PTR_HWSYNC |
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int query_status_and_control_data(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_control_fallbacked)
@@ -593,8 +608,8 @@ static int snd_pcm_hw_hwsync(snd_pcm_t *pcm)
 	snd_pcm_hw_t *hw = pcm->private_data;
 	int fd = hw->fd, err;
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 3) <= hw->version) {
-		if (hw->sync_ptr) {
-			err = sync_ptr1(hw, SNDRV_PCM_SYNC_PTR_HWSYNC);
+		if (hw->mmap_status_fallbacked) {
+			err = request_hwsync(hw);
 			if (err < 0)
 				return err;
 		} else {
-- 
2.11.0
