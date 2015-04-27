From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] sound: Close holes in struct
	snd_pcm_hw_rule
Date: Mon, 27 Apr 2015 12:20:28 +0200
Message-ID: <1430130030-17895-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A3DE2605EF
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 12:20:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On a 64-bit system there are two 32-bit holes due to the alignment of 64-bit
fields. Reordering things slightly gets rid of those holes, reducing the
size of the struct by 17% percent of its original size.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0cb7f3f..d632809 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -224,9 +224,10 @@ typedef int (*snd_pcm_hw_rule_func_t)(struct snd_pcm_hw_params *params,
 
 struct snd_pcm_hw_rule {
 	unsigned int cond;
-	snd_pcm_hw_rule_func_t func;
 	int var;
 	int deps[4];
+
+	snd_pcm_hw_rule_func_t func;
 	void *private;
 };
 
-- 
1.8.0
