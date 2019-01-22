From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: pcm: Avoid confusing loop in
	snd_pcm_unlink()
Date: Tue, 22 Jan 2019 17:19:12 +0100
Message-ID: <20190122161915.8445-5-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 35DBE2674B9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:18 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 78CF6B080
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 16:19:18 +0000 (UTC)
In-Reply-To: <20190122161915.8445-1-tiwai@suse.de>
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

The snd_pcm_group_for_each_entry() loop found in snd_pcm_unlink() is
only for taking the first list entry.  Use list_first_entry() to make
clearer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1a56bb1ad780..fb45386270d5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2023,7 +2023,6 @@ static void relink_to_local(struct snd_pcm_substream *substream)
 
 static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_substream *s;
 	struct snd_pcm_group *group;
 	int res = 0;
 
@@ -2040,10 +2039,9 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 
 	/* detach the last stream, too */
 	if (list_is_singular(&group->substreams)) {
-		snd_pcm_group_for_each_entry(s, substream) {
-			relink_to_local(s);
-			break;
-		}
+		relink_to_local(list_first_entry(&group->substreams,
+						 struct snd_pcm_substream,
+						 link_list));
 		kfree(group);
 	}
 
-- 
2.16.4
