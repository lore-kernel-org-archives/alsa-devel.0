From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Fix typo roup->group" to the asoc
	tree
Date: Fri, 09 Mar 2018 18:04:29 +0000
Message-ID: <E1euMNZ-000247-Mh@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 585E1267617
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 19:04:30 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Fix typo roup->group

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

>From f7e73b26aea58003931e2f3925d9c01f6b6c4c4d Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 9 Mar 2018 12:46:27 +0000
Subject: [PATCH] ASoC: core: Fix typo roup->group

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e1f047de599e..4cd32f1bceb4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -221,14 +221,14 @@ static const struct attribute_group soc_dapm_dev_group = {
 	.is_visible = soc_dev_attr_is_visible,
 };
 
-static const struct attribute_group soc_dev_roup = {
+static const struct attribute_group soc_dev_group = {
 	.attrs = soc_dev_attrs,
 	.is_visible = soc_dev_attr_is_visible,
 };
 
 static const struct attribute_group *soc_dev_attr_groups[] = {
 	&soc_dapm_dev_group,
-	&soc_dev_roup,
+	&soc_dev_group,
 	NULL
 };
 
-- 
2.16.2
