From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Use ERESTARTSYS instead of EINTR in
	OSS emulation
Date: Tue,  9 Jan 2018 08:55:19 +0100
Message-ID: <20180109075519.18152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 54C272674CE
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 08:55:22 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 73981AF79
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 07:55:21 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Fix the last standing EINTR in the whole subsystem.  Use more correct
ERESTARTSYS for pending signals.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index c7d8489d39c8..e8b19876c420 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -842,7 +842,7 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
 		if (!(mutex_trylock(&runtime->oss.params_lock)))
 			return -EAGAIN;
 	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -EINTR;
+		return -ERESTARTSYS;
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
-- 
2.15.1
