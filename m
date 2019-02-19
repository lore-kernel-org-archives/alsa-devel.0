From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: ac97: Fix of-node refcount unbalance
Date: Tue, 19 Feb 2019 16:31:22 +0100
Message-ID: <20190219153124.12595-2-tiwai@suse.de>
References: <20190219153124.12595-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E147226552B
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

ac97_of_get_child_device() take the refcount of the node explicitly
via of_node_get(), but this leads to an unbalance.  The
for_each_child_of_node() loop itself takes the refcount for each
iteration node, hence you don't need to take the extra refcount
again.

Fixes: 2225a3e6af78 ("ALSA: ac97: add codecs devicetree binding")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/ac97/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 9f0c480489ef..9cbf6927abe9 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -84,7 +84,7 @@ ac97_of_get_child_device(struct ac97_controller *ac97_ctrl, int idx,
 		if ((idx != of_property_read_u32(node, "reg", &reg)) ||
 		    !of_device_is_compatible(node, compat))
 			continue;
-		return of_node_get(node);
+		return node;
 	}
 
 	return NULL;
-- 
2.16.4
