From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Allow codec_conf DT lookups to
	match parent of_node" to the asoc tree
Date: Fri, 27 Apr 2018 19:24:43 +0100
Message-ID: <E1fC831-0004KN-1w@debutante>
References: <20180427125436.11892-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 945422675DB
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 20:24:46 +0200 (CEST)
In-Reply-To: <20180427125436.11892-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Allow codec_conf DT lookups to match parent of_node

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b24c539b4dc58f7d6283b8d06e240ac87d4966d7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 27 Apr 2018 13:54:36 +0100
Subject: [PATCH] ASoC: core: Allow codec_conf DT lookups to match parent
 of_node

For devices implemented as a MFD it is common to only have a single node
in devicetree representing the whole device. As such when looking up
codec_conf mappings we should match against both the devices of_node and
the devices parent's of_node, as is already done for DAIs and platform
components.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 052089f16ea0..4b068ccf4e13 100644
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
2.17.0
