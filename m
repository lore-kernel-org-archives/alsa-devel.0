From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix snd_soc_find_dai() matching
	component by name
Date: Wed, 29 Oct 2014 21:46:30 +0100
Message-ID: <1414615591-22125-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-207.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id EF8BB260517
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:46:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 14621c7e5e72 ("ASoC: Consolidate CPU and CODEC DAI lookup")
consolidated the lookup of CPU DAIs and CODEC DAIs into a single function.
When matching a component by name for CODEC DAIs the code previous to the
patch compared the name in the DAI link table with component->name. For CPU
DAIs the code compared to dev_name(component->dev). The newly introduced
function ended up using the later as well.

For most components dev_name(component->dev) and component->name are the
same. The main notable exception are I2C devices where the driver name and
the device name are concatenated to form the component name. By using
dev_name(component->dev) instead of component->name the patch broke the
matching of I2C CODECs by name.

This patch restores the original behavior by using component->name instead
of dev_name(component->dev). This will be safe even for CPU DAIs since for
CPU DAIs both are the same.

Fixes: 14621c7e5e72 ("ASoC: Consolidate CPU and CODEC DAI lookup")
Reported-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 62fbb63..b900f0d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -884,7 +884,7 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	list_for_each_entry(component, &component_list, list) {
 		if (dlc->of_node && component->dev->of_node != dlc->of_node)
 			continue;
-		if (dlc->name && strcmp(dev_name(component->dev), dlc->name))
+		if (dlc->name && strcmp(component->name, dlc->name))
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
 			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name))
-- 
1.8.0
