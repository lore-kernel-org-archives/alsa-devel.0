From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Use krealloc() for resizing the
	rules array
Date: Tue, 13 Mar 2018 12:42:10 +0100
Message-ID: <20180313114210.12434-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96FD02670F8
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 12:42:12 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3B91ACE9
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 11:42:11 +0000 (UTC)
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

Just a minor simplification.  Change from kcalloc() shouldn't matter
as each array element is fully initialized.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a83152e7d387..f4a19509cccf 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1129,16 +1129,12 @@ int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime, unsigned int cond,
 	if (constrs->rules_num >= constrs->rules_all) {
 		struct snd_pcm_hw_rule *new;
 		unsigned int new_rules = constrs->rules_all + 16;
-		new = kcalloc(new_rules, sizeof(*c), GFP_KERNEL);
+		new = krealloc(constrs->rules, new_rules * sizeof(*c),
+			       GFP_KERNEL);
 		if (!new) {
 			va_end(args);
 			return -ENOMEM;
 		}
-		if (constrs->rules) {
-			memcpy(new, constrs->rules,
-			       constrs->rules_num * sizeof(*c));
-			kfree(constrs->rules);
-		}
 		constrs->rules = new;
 		constrs->rules_all = new_rules;
 	}
-- 
2.16.2
