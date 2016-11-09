From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: If a platform doesn't have an
	of_node use parent's node" to the asoc tree
Date: Wed, 09 Nov 2016 14:59:25 +0000
Message-ID: <E1c4ULV-0002eq-6H@finisterre>
References: <1478523797-22060-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DBFF9267097
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:59:42 +0100 (CET)
In-Reply-To: <1478523797-22060-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: If a platform doesn't have an of_node use parent's node

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 06859fca4368c407d4acccf3948b8b825db5e569 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 7 Nov 2016 13:03:17 +0000
Subject: [PATCH] ASoC: core: If a platform doesn't have an of_node use
 parent's node

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd903261..26da0466126d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -993,6 +993,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_dai **codec_dais;
 	struct snd_soc_platform *platform;
+	struct device_node *platform_of_node;
 	const char *platform_name;
 	int i;
 
@@ -1042,9 +1043,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
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
2.10.2
