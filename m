From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Don't defer probe on optional,
	NULL components" to the asoc tree
Date: Tue, 15 Jan 2019 19:08:26 +0000 (GMT)
Message-ID: <20190115190826.48D6C1127848@debutante.sirena.org.uk>
References: <20190115165107.5551-1-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 295E926746C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 20:08:27 +0100 (CET)
In-Reply-To: <20190115165107.5551-1-hias@horus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Don't defer probe on optional, NULL components

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

>From 2833548ecbb385a289124077ab4d812258a867d5 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Tue, 15 Jan 2019 17:51:07 +0100
Subject: [PATCH] ASoC: core: Don't defer probe on optional, NULL components

cpu and platform are optional components in DAI links. For example
codec-codec links usually have no platform set.

Call snd_soc_find_component only if the name or of_node of
a cpu or platform is set. Otherwise it will return NULL and
soc_init_dai_link bails out immediately with -EPROBE_DEFER,
meaning registering a card with NULL cpu or platform in DAI links
can never succeed.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b680c673c553..aae450ba4f08 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1135,7 +1135,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if platform dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->platform->of_node, link->platform->name))
+	if ((link->platform->of_node || link->platform->name) &&
+	    !soc_find_component(link->platform->of_node, link->platform->name))
 		return -EPROBE_DEFER;
 
 	/*
@@ -1154,7 +1155,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if cpu dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+	if ((link->cpu_of_node || link->cpu_name) &&
+	    !soc_find_component(link->cpu_of_node, link->cpu_name))
 		return -EPROBE_DEFER;
 
 	/*
-- 
2.20.1
