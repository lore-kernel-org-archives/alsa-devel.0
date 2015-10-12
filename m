From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: sh: Fit typo in Kconfig" to the asoc
	tree
Date: Mon, 12 Oct 2015 16:55:00 +0100
Message-ID: <E1ZlfRE-0002nX-6g@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B58265109
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 17:55:10 +0200 (CEST)
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
To: Masanari Iida <standby24x7@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: sh: Fit typo in Kconfig

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

>From d795eb3f5c10d36ed51ca7cd5ce411677f6f7aab Mon Sep 17 00:00:00 2001
From: Masanari Iida <standby24x7@gmail.com>
Date: Sat, 10 Oct 2015 14:17:58 +0900
Subject: [PATCH] ASoc: sh: Fit typo in Kconfig

s/SUR/SRU/g

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 07114b0..de668b2 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -40,7 +40,7 @@ config SND_SOC_RCAR
 	select SND_SIMPLE_CARD
 	select REGMAP_MMIO
 	help
-	  This option enables R-Car SUR/SCU/SSIU/SSI sound support
+	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
 
 config SND_SOC_RSRC_CARD
 	tristate "Renesas Sampling Rate Convert Sound Card"
-- 
2.5.0
