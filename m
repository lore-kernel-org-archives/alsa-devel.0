From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: route: Don't handle no matching chmap as
	a serious error
Date: Tue, 18 Mar 2014 15:27:56 +0100
Message-ID: <1395152876-28480-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA522619F4
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 15:27:57 +0100 (CET)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When find_matching_chmap() returns an error for the non-matching
chmap, the caller, snd_pcm_route_open(), also returns an error
although it shouldn't be handled as the fatal error.  This results in
the probe error with PulseAudio and it gives no real output in the
end.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_route.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index ab17fa78be2c..ac11bdc8adfd 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -940,10 +940,8 @@ static int find_matching_chmap(snd_pcm_t *spcm, snd_pcm_chmap_t *tt_chmap,
 
 	snd_pcm_free_chmaps(chmaps);
 
-	if (*found_chmap == NULL) {
+	if (*found_chmap == NULL)
 		SNDERR("Found no matching channel map");
-		return -EINVAL;
-	}
 	return 0;
 }
 
-- 
1.9.0
