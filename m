From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Allow soc_find_component lookups
	to match parent of_node" to the asoc tree
Date: Fri, 25 Jan 2019 18:11:18 +0000 (GMT)
Message-ID: <20190125181118.35E661126FC0@debutante.sirena.org.uk>
References: <20190125160406.28339-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C2A267969
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 19:11:21 +0100 (CET)
In-Reply-To: <20190125160406.28339-1-ckeepax@opensource.cirrus.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, ajitp@codeaurora.org, hias@horus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Allow soc_find_component lookups to match parent of_node

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

>From d0b95e6cd298a785c126e75a085af6dd7b7b1f60 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 25 Jan 2019 16:04:06 +0000
Subject: [PATCH] ASoC: core: Allow soc_find_component lookups to match parent
 of_node

For devices implemented as a MFD it is common to only have a single node
in devicetree representing the whole device. As such when looking up
components in soc_find_components we should match against both the devices
of_node and the devices parent's of_node, as is already done in the rest
of the ASoC core.

This causes regressions for some DAI links at the moment as
soc_find_component was recently added as a check in soc_init_dai_link.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aae450ba4f08..ea16c2b199ce 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -735,12 +735,17 @@ static struct snd_soc_component *soc_find_component(
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
2.20.1
