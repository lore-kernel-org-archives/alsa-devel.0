From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-lib)] pcm_hw: Fix buffer overflow in chmap
Date: Mon, 10 Jun 2013 16:42:47 +0200
Message-ID: <1370875368-2614-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F2846261664
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:42:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

We can't calculate memory storage in bytes, when we're supposed
to store ints in it!

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 196393d..9ff83a9 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1187,7 +1187,7 @@ static snd_pcm_chmap_t *snd_pcm_hw_get_chmap(snd_pcm_t *pcm)
 		       snd_pcm_state_name(FAST_PCM_STATE(hw)));
 		return NULL;
 	}
-	map = malloc(pcm->channels + 1);
+	map = malloc(pcm->channels * sizeof(map->pos[0]) + sizeof(*map));
 	if (!map)
 		return NULL;
 	map->channels = pcm->channels;
-- 
1.8.1.2
