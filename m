From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: core: Allow codec_conf DT lookups to
	match parent of_node
Date: Fri, 27 Apr 2018 13:54:36 +0100
Message-ID: <20180427125436.11892-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 976D426728A
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 14:54:39 +0200 (CEST)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

For devices implemented as a MFD it is common to only have a single node
in devicetree representing the whole device. As such when looking up
codec_conf mappings we should match against both the devices of_node and
the devices parent's of_node, as is already done for DAIs and platform
components.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 052089f16ea02..4b068ccf4e13a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1383,7 +1383,12 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 
 	for (i = 0; i < card->num_configs; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
-		if (map->of_node && component->dev->of_node != map->of_node)
+		struct device_node *component_of_node = component->dev->of_node;
+
+		if (!component_of_node && component->dev->parent)
+			component_of_node = component->dev->parent->of_node;
+
+		if (map->of_node && component_of_node != map->of_node)
 			continue;
 		if (map->dev_name && strcmp(component->name, map->dev_name))
 			continue;
-- 
2.11.0
