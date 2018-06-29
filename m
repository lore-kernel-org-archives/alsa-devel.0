From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ALSA: snd-aoa: add of_node_put() in error path
Date: Fri, 29 Jun 2018 19:07:42 +0200
Message-ID: <1530292062-31567-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 by alsa0.perex.cz (Postfix) with ESMTP id E30082675C8
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 19:08:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Nicholas Mc Guire <hofrat@osadl.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

 Both calls to of_find_node_by_name() and of_get_next_child() return a
node pointer with refcount incremented thus it must be explicidly
decremented here after the last usage. As we are assured to have a
refcounted  np  either from the initial
of_find_node_by_name(NULL, name); or from the of_get_next_child(gpio, np)
in the while loop if we reached the error code path below, an
x of_node_put(np) is needed.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
---

Problem located by an experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies CONFIG_SND_AOA=m)

Patch is against 4.18-rc2 (localversion-next is next-20180629)

 sound/aoa/core/gpio-feature.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 7196008..6555742 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -88,8 +88,10 @@ static struct device_node *get_gpio(char *name,
 	}
 
 	reg = of_get_property(np, "reg", NULL);
-	if (!reg)
+	if (!reg) {
+		of_node_put(np);
 		return NULL;
+	}
 
 	*gpioptr = *reg;
 
-- 
2.1.4
