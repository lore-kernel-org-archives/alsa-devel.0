From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix lockdep warning with nonatomic
	PCM ops
Date: Fri, 17 Jul 2015 15:37:36 +0200
Message-ID: <1437140256-11466-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43927266858
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 15:37:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja Kp <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

With the nonatomic PCM ops, the system may spew lockdep warnings like:

 =============================================
 [ INFO: possible recursive locking detected ]
 4.2.0-rc1-jeejaval3 #12 Not tainted
 ---------------------------------------------
 aplay/4029 is trying to acquire lock:
  (snd_pcm_link_rwsem){.+.+.+}, at: [<ffffffff816fd473>] snd_pcm_stream_lock+0x43/0x60

 but task is already holding lock:
  (snd_pcm_link_rwsem){.+.+.+}, at: [<ffffffff816fcf29>] snd_pcm_action_nonatomic+0x29/0x80

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(snd_pcm_link_rwsem);
   lock(snd_pcm_link_rwsem);

Although this is false-positive as the rwsem is taken always as
read-only for these code paths, it's certainly annoying to see this at
any occasion.  A simple fix is to use down_read_nested() in
snd_pcm_stream_lock() that can be called inside another lock.

Reported-by: Vinod Koul <vinod.koul@intel.com>
Reported-by: Jeeja Kp <jeeja.kp@intel.com>
Tested-by: Jeeja Kp <jeeja.kp@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d126c03361ae..75888dd38a7f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -85,7 +85,7 @@ static DECLARE_RWSEM(snd_pcm_link_rwsem);
 void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 {
 	if (substream->pcm->nonatomic) {
-		down_read(&snd_pcm_link_rwsem);
+		down_read_nested(&snd_pcm_link_rwsem, SINGLE_DEPTH_NESTING);
 		mutex_lock(&substream->self_group.mutex);
 	} else {
 		read_lock(&snd_pcm_link_rwlock);
-- 
2.4.5
