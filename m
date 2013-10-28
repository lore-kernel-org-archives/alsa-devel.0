From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: Optimize module name check
Date: Mon, 28 Oct 2013 14:14:10 +0100
Message-ID: <1382966050-12752-7-git-send-email-tiwai@suse.de>
References: <1382966050-12752-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 516BC261609
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5B5AA5AA4
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:31 +0100 (CET)
In-Reply-To: <1382966050-12752-1-git-send-email-tiwai@suse.de>
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

module->name is a fixed array, so we can check the empty contents
straightforwardly in module_slot_match().

Spotted by coverity CID 1056786.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 6b90871..01a8938 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -66,7 +66,7 @@ static int module_slot_match(struct module *module, int idx)
 #ifdef MODULE
 	const char *s1, *s2;
 
-	if (!module || !module->name || !slots[idx])
+	if (!module || !*module->name || !slots[idx])
 		return 0;
 
 	s1 = module->name;
-- 
1.8.4.1
