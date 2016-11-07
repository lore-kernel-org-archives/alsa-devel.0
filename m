From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: If a platform doesn't have an
	of_node use parent's node
Date: Mon, 7 Nov 2016 13:03:17 +0000
Message-ID: <1478523797-22060-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 73C0A265D2B
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 14:03:06 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Support was added to allow location of both CPU and CODEC components
of a DAI link from their parent's of_node if they did not have an
of_node themselves in this commit:

commit 3e0aa8d83bf8 ("ASoC: core: If component doesn't have of_node
                      use parent's node instead")

However this leaves platforms as something of a special case as the
major DAI component that doesn't do this. Since this is useful for MFD
devices which often utilise a single device tree entry for the whole
device, add support for looking up platforms from the parent's of_node
as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a7a1ca4..87c607b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1035,6 +1035,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_dai **codec_dais;
 	struct snd_soc_platform *platform;
+	struct device_node *platform_of_node;
 	const char *platform_name;
 	int i;
 
@@ -1084,9 +1085,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	/* find one from the set of registered platforms */
 	list_for_each_entry(platform, &platform_list, list) {
+		platform_of_node = platform->dev->of_node;
+		if (!platform_of_node && platform->dev->parent->of_node)
+			platform_of_node = platform->dev->parent->of_node;
+
 		if (dai_link->platform_of_node) {
-			if (platform->dev->of_node !=
-			    dai_link->platform_of_node)
+			if (platform_of_node != dai_link->platform_of_node)
 				continue;
 		} else {
 			if (strcmp(platform->component.name, platform_name))
-- 
2.1.4
