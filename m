From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: pcm: Fix referred substream in
	snd_pcm_action_group() unlock loop
Date: Tue, 14 Oct 2014 10:50:16 +0200
Message-ID: <1413276617-24401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0BED2604E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 10:50:20 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34AD1AB07
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 08:50:20 +0000 (UTC)
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

In the unlock loop of snd_pcm_action_group(), the object "s" is used
as the check of nonatomic PCM, but it should be rather "s1", which is
the iterator of the loop.  This supposedly causes a kernel panic when
the substreams in operatino are linked.

Fixes: 257f8cce5d40 ('ALSA: pcm: Allow nonatomic trigger operations')
Reported-and-tested-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 85fe1a216225..bfe1cf6b492f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -818,7 +818,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
 		/* unlock streams */
 		snd_pcm_group_for_each_entry(s1, substream) {
 			if (s1 != substream) {
-				if (s->pcm->nonatomic)
+				if (s1->pcm->nonatomic)
 					mutex_unlock(&s1->self_group.mutex);
 				else
 					spin_unlock(&s1->self_group.lock);
-- 
2.1.2
