From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 1/3] pcm: Remove superfluous rmb()
	from PCM meter plugin
Date: Thu,  7 Jul 2016 16:30:07 +0200
Message-ID: <20160707143009.23550-2-tiwai@suse.de>
References: <20160707143009.23550-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 925C6266528
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:30:11 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5D479AC6C
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 14:30:11 +0000 (UTC)
In-Reply-To: <20160707143009.23550-1-tiwai@suse.de>
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

rmb() is still left in the code without any actual meaning there just
before the atomic operation.  Let's clean it up.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_meter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index 1b0ccb40b3dd..d71af7a683e0 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -136,7 +136,6 @@ static int snd_pcm_meter_update_scope(snd_pcm_t *pcm)
  _again:
 	rptr = *pcm->hw.ptr;
 	old_rptr = meter->rptr;
-	rmb();
 	if (atomic_read(&meter->reset)) {
 		reset = 1;
 		atomic_dec(&meter->reset);
-- 
2.9.0
