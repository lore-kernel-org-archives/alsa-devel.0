From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: pcm: Refactoring snd_pcm_action()
Date: Tue,  4 Nov 2014 14:28:13 +0100
Message-ID: <1415107696-17123-3-git-send-email-tiwai@suse.de>
References: <1415107696-17123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F18252614FB
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:28:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6005EAC66
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:28:19 +0000 (UTC)
In-Reply-To: <1415107696-17123-1-git-send-email-tiwai@suse.de>
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

Just a small code refactoring to reduce more lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b92b605fc784..ca224fa2a33a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -900,14 +900,19 @@ static int snd_pcm_action_single(struct action_ops *ops,
 	return res;
 }
 
-/* call in mutex-protected context */
-static int snd_pcm_action_mutex(struct action_ops *ops,
-				struct snd_pcm_substream *substream,
-				int state)
+/*
+ *  Note: call with stream lock
+ */
+static int snd_pcm_action(struct action_ops *ops,
+			  struct snd_pcm_substream *substream,
+			  int state)
 {
 	int res;
 
-	if (snd_pcm_stream_linked(substream)) {
+	if (!snd_pcm_stream_linked(substream))
+		return snd_pcm_action_single(ops, substream, state);
+
+	if (substream->pcm->nonatomic) {
 		if (!mutex_trylock(&substream->group->mutex)) {
 			mutex_unlock(&substream->self_group.mutex);
 			mutex_lock(&substream->group->mutex);
@@ -916,24 +921,6 @@ static int snd_pcm_action_mutex(struct action_ops *ops,
 		res = snd_pcm_action_group(ops, substream, state, 1);
 		mutex_unlock(&substream->group->mutex);
 	} else {
-		res = snd_pcm_action_single(ops, substream, state);
-	}
-	return res;
-}
-
-/*
- *  Note: call with stream lock
- */
-static int snd_pcm_action(struct action_ops *ops,
-			  struct snd_pcm_substream *substream,
-			  int state)
-{
-	int res;
-
-	if (substream->pcm->nonatomic)
-		return snd_pcm_action_mutex(ops, substream, state);
-
-	if (snd_pcm_stream_linked(substream)) {
 		if (!spin_trylock(&substream->group->lock)) {
 			spin_unlock(&substream->self_group.lock);
 			spin_lock(&substream->group->lock);
@@ -941,8 +928,6 @@ static int snd_pcm_action(struct action_ops *ops,
 		}
 		res = snd_pcm_action_group(ops, substream, state, 1);
 		spin_unlock(&substream->group->lock);
-	} else {
-		res = snd_pcm_action_single(ops, substream, state);
 	}
 	return res;
 }
-- 
2.1.3
