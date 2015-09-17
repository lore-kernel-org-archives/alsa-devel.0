From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: Fix sparse warning in
	be32_to_cpup() call" to the asoc tree
Date: Thu, 17 Sep 2015 18:36:45 +0100
Message-ID: <E1Zcd6z-0006LN-1a@finisterre>
References: <1442483290-30470-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60855261ADB
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 19:36:51 +0200 (CEST)
In-Reply-To: <1442483290-30470-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: Fix sparse warning in be32_to_cpup() call

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

>From 6c84e5917f83334f9196a50cfa31e72207b1a7f6 Mon Sep 17 00:00:00 2001
From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 17 Sep 2015 13:13:38 +0300
Subject: [PATCH] ASoC: soc-core: Fix sparse warning in be32_to_cpup() call

Store return value of of_get_property() to a pointer of __be32 type as
device tree has big endian type. This fixes a sparse warning couple of
lines later when be32_to_cpup() is used to convert from big endian to
cpu endian.

The whole conversion is not really necessary, as we are only checking
if the value is zero or not, but I wanted to add it to remind in the
future that the data has to be converted before use. Compiler should
optimize the unnecessary operations away.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c5e21ca..3b471f9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3296,7 +3296,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 				    unsigned int *mask)
 {
 	u32 val;
-	const u32 *of_slot_mask = of_get_property(np, prop_name, &val);
+	const __be32 *of_slot_mask = of_get_property(np, prop_name, &val);
 	int i;
 
 	if (!of_slot_mask)
-- 
2.5.0
