From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 2/2] pcm: minor code cleanup for ioctl
	call
Date: Fri, 23 Jun 2017 22:09:24 +0900
Message-ID: <20170623130924.19620-3-o-takashi@sakamocchi.jp>
References: <20170623130924.19620-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 27069266CE6
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 15:09:29 +0200 (CEST)
In-Reply-To: <20170623130924.19620-1-o-takashi@sakamocchi.jp>
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

When error occurs, return value from ioctl(2) is -1 and error code can
be got thread local variable, errno. It's OK just to check the return
value without any assignment.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index f0efcde3..de6fd1af 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -132,8 +132,7 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
 {
 	int err;
 	hw->sync_ptr->flags = flags;
-	err = ioctl((hw)->fd, SNDRV_PCM_IOCTL_SYNC_PTR, (hw)->sync_ptr);
-	if (err < 0) {
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, hw->sync_ptr) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
 		return err;
-- 
2.11.0
