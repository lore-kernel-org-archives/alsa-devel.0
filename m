From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] pcm: route: Correctly close slave pcm when no
	matching chmap is found
Date: Tue, 27 May 2014 09:51:21 +0200
Message-ID: <1401177081-22204-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B7BA1265556
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 09:51:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: superquad.vortex2@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a bug where the slave pcm was not correctly closed
on some error conditions, such as not finding a matching chmap.

Reported-by: Raymond Yau <superquad.vortex2@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 49567ea..751e36f 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -1429,8 +1429,10 @@ int _snd_pcm_route_open(snd_pcm_t **pcmp, const char *name,
 	if (tt_chmap) {
 		err = find_matching_chmap(spcm, tt_chmap, &chmap, &schannels);
 		free(tt_chmap);
-		if (err < 0)
+		if (err < 0) {
+			snd_pcm_close(spcm);
 			return err;
+		}
 	}
 
 	err = _snd_pcm_route_determine_ttable(tt, &csize, &ssize, chmap);
-- 
1.9.1
