From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: ppc: Fix of-node refcount unbalance
Date: Tue, 19 Feb 2019 16:31:24 +0100
Message-ID: <20190219153124.12595-4-tiwai@suse.de>
References: <20190219153124.12595-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E464026553F
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:31:29 +0100 (CET)
In-Reply-To: <20190219153124.12595-1-tiwai@suse.de>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

We forgot to unreference the node when aborting from the loop of
for_each_child_of_node() in snd_pmac_tumbler_init().  This leads to
unbalanced node refcount.  Fix it by adding the missing of_node_put()
call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/ppc/tumbler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 6d7ffffcce95..78e5798ae967 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1371,6 +1371,7 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
 				mix->anded_reset = 1;
 			if (of_get_property(np, "layout-id", NULL))
 				mix->reset_on_sleep = 0;
+			of_node_put(np);
 			break;
 		}
 	}
-- 
2.16.4
