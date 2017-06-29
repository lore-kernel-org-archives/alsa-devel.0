From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 02/12] pcm: hw: add a helper function
	just to query status/control data of PCM substream
Date: Fri, 30 Jun 2017 08:58:18 +0900
Message-ID: <20170629235828.18076-3-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0D3062673ED
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

When failing to map status data, applications can query status of runtime
of PCM substream by executing ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR. This
operation is available for several purposes; e.g. to update control data
in kernel space.

When querying status, the applications don't need to update control data
in kernel space. This commit adds a helper function to query status/control
data without issuing the control just in fallback from failure of status
mmap.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index e0931577..2b5f08be 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -151,6 +151,20 @@ static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
+static int query_state(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_status_fallbacked)
+		return 0;
+
+	/*
+	 * Query both of control/status data to avoid unexpected change of
+	 * control data in kernel space.
+	 */
+	return sync_ptr1(hw,
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
 {
 	if (hw->period_timer_need_poll) {
@@ -542,7 +556,7 @@ static int snd_pcm_hw_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_hw_state(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	int err = sync_ptr(hw, 0);
+	int err = query_state(hw);
 	if (err < 0)
 		return err;
 	return (snd_pcm_state_t) hw->mmap_status->state;
-- 
2.11.0
