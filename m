From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: aoa: Fix of-node refcount unbalance
Date: Tue, 19 Feb 2019 16:31:23 +0100
Message-ID: <20190219153124.12595-3-tiwai@suse.de>
References: <20190219153124.12595-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E367A265538
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

We forgot to unreference a node obtained via of_find_node_by_name()
after its usage.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/aoa/core/gpio-feature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 65557421fe0b..c3ff721e4660 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -82,6 +82,7 @@ static struct device_node *get_gpio(char *name,
 			if (altname && (strcmp(audio_gpio, altname) == 0))
 				break;
 		}
+		of_node_put(gpio);
 		/* still not found, assume not there */
 		if (!np)
 			return NULL;
-- 
2.16.4
