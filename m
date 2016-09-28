From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: trivial: system spelling fix" to the
	asoc tree
Date: Wed, 28 Sep 2016 11:27:27 -0700
Message-ID: <E1bpJZn-0003q3-Nb@finisterre>
References: <20160928102410.5369-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E17DA267041
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 20:27:40 +0200 (CEST)
In-Reply-To: <20160928102410.5369-1-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: trivial: system spelling fix

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

>From 97b4bc76d9f7ab1fab375bc6d6143804a7bc2256 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Wed, 28 Sep 2016 12:24:10 +0200
Subject: [PATCH] ASoC: trivial: system spelling fix

Do s/ststem/system/ .

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index b95ae4918fca..d023959b8cd6 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -13,4 +13,4 @@ config SND_SIMPLE_SCU_CARD
 	select SND_SIMPLE_CARD_UTILS
 	help
 	  This option enables generic simple SCU sound card support.
-	  It supports DPCM of multi CPU single Codec ststem.
+	  It supports DPCM of multi CPU single Codec system.
-- 
2.9.3
