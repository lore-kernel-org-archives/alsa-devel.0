From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: core: Allow soc_find_component lookups
	to match parent of_node
Date: Fri, 25 Jan 2019 16:04:06 +0000
Message-ID: <20190125160406.28339-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DF0DC2673DD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 17:04:10 +0100 (CET)
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
Cc: hias@horus.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, ajitp@codeaurora.org
List-Id: alsa-devel@alsa-project.org

For devices implemented as a MFD it is common to only have a single node
in devicetree representing the whole device. As such when looking up
components in soc_find_components we should match against both the devices
of_node and the devices parent's of_node, as is already done in the rest
of the ASoC core.

This causes regressions for some DAI links at the moment as
soc_find_component was recently added as a check in soc_init_dai_link.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8a58fa86675ac..7f5e8abd5cb78 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -742,12 +742,17 @@ static struct snd_soc_component *soc_find_component(
 	const struct device_node *of_node, const char *name)
 {
 	struct snd_soc_component *component;
+	struct device_node *component_of_node;
 
 	lockdep_assert_held(&client_mutex);
 
 	for_each_component(component) {
 		if (of_node) {
-			if (component->dev->of_node == of_node)
+			component_of_node = component->dev->of_node;
+			if (!component_of_node && component->dev->parent)
+				component_of_node = component->dev->parent->of_node;
+
+			if (component_of_node == of_node)
 				return component;
 		} else if (name && strcmp(component->name, name) == 0) {
 			return component;
-- 
2.11.0
