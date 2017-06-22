From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 2/9] pcm: minor code refactoring
	for ioctl call
Date: Thu, 22 Jun 2017 23:43:27 +0900
Message-ID: <20170622144334.1306-3-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D3508266D8C
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 16:43:43 +0200 (CEST)
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

When error occurs, return value from ioctl(2) is -1 and error code can
be got thread local variable, errno. It's OK just to check the return
value without any assignment.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index f74bd0d7..cf143f2f 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -135,12 +135,12 @@ static int sync_ptr1(snd_pcm_hw_t *hw, struct snd_pcm_sync_ptr *ptr,
 	int err;
 
 	ptr->flags = flags;
-	err = ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, ptr);
-	if (err < 0) {
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, ptr) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
 		return err;
 	}
+
 	return 0;
 }
 
-- 
2.11.0
