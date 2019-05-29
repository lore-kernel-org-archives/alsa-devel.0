From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: use component driver name as
	component name" to the asoc tree
Date: Wed, 29 May 2019 16:45:26 +0100 (BST)
Message-ID: <20190529154526.C1CE5440046@finisterre.sirena.org.uk>
References: <20190529062214.225874-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FBBEF8072E
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 17:45:33 +0200 (CEST)
In-Reply-To: <20190529062214.225874-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: use component driver name as component name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From b19671d6caf1ac393681864d5d85dda9fa99a448 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 29 May 2019 14:22:14 +0800
Subject: [PATCH] ASoC: core: use component driver name as component name

fmt_single_name() uses device name to determine component name.  If
multiple components bind to the same device, the debugfs creation in
soc_init_component_debugfs() would fail due to duplicated entity
names.

Name provided by component driver is unique enough to represent each
component.  Use component driver name as the component name to avoid
name duplication.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ce8c057bcd5b..5f83e2f19801 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3106,7 +3106,10 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 {
 	struct snd_soc_dapm_context *dapm;
 
-	component->name = fmt_single_name(dev, &component->id);
+	if (driver->name)
+		component->name = kstrdup(driver->name, GFP_KERNEL);
+	else
+		component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.20.1
