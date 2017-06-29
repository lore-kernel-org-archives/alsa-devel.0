From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 12/12] pcm: hw: minor refactoring for
	initialization of control data
Date: Fri, 30 Jun 2017 08:58:28 +0900
Message-ID: <20170629235828.18076-13-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7E6112673FC
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

At failure of control data mapping, alsa-lib goes to fallback mode. In this
mode, it keeps a buffer in user space and executes ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR to issue/query control data as necessary. The
effect of this operation can be managed by passing corresponding flags.
When 0 is passing as the flag, all members in the control data are
updated in kernel space. This is used when control data is initialized.

This commit adds a minor code refactoring for the initialization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index a849c644..9608e89d 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -999,11 +999,9 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
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
