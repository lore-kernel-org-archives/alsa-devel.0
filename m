From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 07/21] ALSA: pcm: remove function local
	variable with alternative evaluation
Date: Sun, 14 May 2017 17:57:42 +0900
Message-ID: <20170514085756.22382-8-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 7A128266947
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:04 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A local variable is used to judge whether a parameter should be handled
due to reverse dependency of the other rules. However, this can be
obsoleted by check of a sentinel in dependency array.

This commit removes the local variable and check the sentinel to reduce
stack usage.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4de9498..39ead67 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -351,16 +351,13 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 	for (k = 0; k < constrs->rules_num; k++) {
 		struct snd_pcm_hw_rule *r = &constrs->rules[k];
 		unsigned int d;
-		int doit = 0;
 		if (r->cond && !(r->cond & params->flags))
 			continue;
 		for (d = 0; r->deps[d] >= 0; d++) {
-			if (vstamps[r->deps[d]] > rstamps[k]) {
-				doit = 1;
+			if (vstamps[r->deps[d]] > rstamps[k])
 				break;
-			}
 		}
-		if (!doit)
+		if (r->deps[d] < 0)
 			continue;
 
 		/* Keep old parameter to trace. */
-- 
2.9.3
