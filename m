From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: core: Don't break component searching if
	both id and num_dai are 0
Date: Mon, 21 Apr 2014 19:14:46 +0800
Message-ID: <1398078886-31505-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 by alsa0.perex.cz (Postfix) with ESMTP id CF3622617B8
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 13:13:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The commit e41975ed (ASoC: core: Fix the DAI name getting) added a break
within the "if (id < 0 || id >= pos->num_dai)" while the original design
of the search didn't break the loop if that condition contented but only
mark the ret error and let it go on to search the next component.

In a case like dmaengine which's not a dai but as a component sharing an
identical name with a dai, both the id and pos->num_dai here could be 0.
If we break the search, we may never find the dai we want as it might be
placed behind its dmaengine in the component list.

So this patch fixes the issue above by following the original design to
let the search carry on.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a17c047..82e9fdf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4591,7 +4591,7 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 
 			if (id < 0 || id >= pos->num_dai) {
 				ret = -EINVAL;
-				break;
+				continue;
 			}
 
 			ret = 0;
-- 
1.8.4
