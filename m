From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: sb: Fix a typo
Date: Thu,  2 Aug 2018 07:44:46 +0200
Message-ID: <20180802054446.2996-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2983B2676E2
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 07:44:49 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EDAE9ACCA
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 05:44:48 +0000 (UTC)
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

There was a typo of COPY_USER in the dead code (that is disabled
as default).

Fixes: 4b83eff81c81 ("ALSA: sb: Convert to the new PCM ops")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sb/emu8000_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index bc5af71d3bdb..f46f6ec3ea0c 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -470,7 +470,7 @@ static int emu8k_pcm_copy(struct snd_pcm_substream *subs,
 	/* convert to word unit */
 	pos = (pos << 1) + rec->loop_start[voice];
 	count <<= 1;
-	LOOP_WRITE(rec, pos, src, count, COPY_UESR);
+	LOOP_WRITE(rec, pos, src, count, COPY_USER);
 	return 0;
 }
 
-- 
2.18.0
