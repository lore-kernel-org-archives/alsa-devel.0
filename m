From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniperf: Add missing __iomem
	annotation" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:06 +0100
Message-ID: <E1ZKS6U-0004YN-CU@finisterre>
References: <1437987388-9706-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F05512658FA
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:20 +0200 (CEST)
In-Reply-To: <1437987388-9706-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uniperf: Add missing __iomem annotation

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

>From b917abb4064b38b0613e953b09213e788ad94ad0 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 27 Jul 2015 10:56:26 +0200
Subject: [PATCH] ASoC: uniperf: Add missing __iomem annotation

base referes to a iomem region, so it should have the __iomem annotation.
Fixes the following warnings from sparse:

	sound/soc/sti/sti_uniperif.c:169:19: warning: incorrect type in
		assignment (different address spaces)
	sound/soc/sti/sti_uniperif.c:169:19:    expected void *base
	sound/soc/sti/sti_uniperif.c:169:19:    got void [noderef] <asn:2>*
	sound/soc/sti/uniperif_player.c:104:18: warning: incorrect type in
		argument 1 (different address spaces)
	sound/soc/sti/uniperif_player.c:104:18:    expected void const volatile
		[noderef] <asn:2>*addr
	sound/soc/sti/uniperif_player.c:104:18:    got void *
	[...]

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index ee462f7..f0fd5a9 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1168,7 +1168,7 @@ struct uniperif {
 
 	/* Resources */
 	struct resource *mem_region;
-	void *base;
+	void __iomem *base;
 	unsigned long fifo_phys_address;
 	int irq;
 
-- 
2.1.4
