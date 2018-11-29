From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix interval evaluation with
	openmin/max
Date: Thu, 29 Nov 2018 19:56:45 +0100
Message-ID: <20181129185645.15299-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A38F5267B74
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 19:56:48 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 87FA7AE30
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 18:56:48 +0000 (UTC)
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

As addressed in alsa-lib (commit b420056604f0), we need to fix the
case where the evaluation of PCM interval "(x x+1]" leading to
-EINVAL.  After applying rules, such an interval may be translated as
"(x x+1)".

Fixes: ff2d6acdf6f1 ("ALSA: pcm: Fix snd_interval_refine first/last with open min/max")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm_params.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 2dd37cada7c0..888a833d3b00 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -254,11 +254,13 @@ static inline int snd_interval_empty(const struct snd_interval *i)
 static inline int snd_interval_single(const struct snd_interval *i)
 {
 	return (i->min == i->max || 
-		(i->min + 1 == i->max && i->openmax));
+		(i->min + 1 == i->max && (i->openmin || i->openmax)));
 }
 
 static inline int snd_interval_value(const struct snd_interval *i)
 {
+	if (i->openmin && !i->openmax)
+		return i->max;
 	return i->min;
 }
 
-- 
2.19.1
