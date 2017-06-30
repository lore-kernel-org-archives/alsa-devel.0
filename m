From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib] pcm: hw: minor refactoring for
	initialization of control data
Date: Fri, 30 Jun 2017 20:00:26 +0900
Message-ID: <20170630110026.6721-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 39776266EB6
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:00:29 +0200 (CEST)
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

At failure of control data mapping, alsa-lib goes to fallback mode. In
this mode, a buffer is kept in user space and executes ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR for the buffer to synchronize the control data.

In current implementation, no helper function is used for initialize
the control data. This commit use an proper helper function instead of
a direct call of ioctl(2).

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index e0931577..f03bc589 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -957,11 +957,9 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
 			     SNDRV_PCM_MMAP_OFFSET_CONTROL);
 	if (hw->mmap_control_fallbacked) {
-		if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, hw->sync_ptr) < 0) {
-			err = -errno;
-			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
+		err = sync_ptr1(hw, 0);
+		if (err < 0)
 			return err;
-		}
 	}
 
 	return 0;
-- 
2.11.0
