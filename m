From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8804: Drop duplicate const" to the
	asoc tree
Date: Wed, 29 Jul 2015 15:13:11 +0100
Message-ID: <E1ZKS6Z-0004a2-6F@finisterre>
References: <1437987388-9706-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7660E26595B
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:28 +0200 (CEST)
In-Reply-To: <1437987388-9706-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8804: Drop duplicate const

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

>From c8a6b92be8516c92cf46bc127fa0adf53a05d31c Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 27 Jul 2015 10:56:23 +0200
Subject: [PATCH] ASoC: wm8804: Drop duplicate const

SOC_ENUM_SINGLE_DECL() already includes a const, drop the extra const.
Fixes the following sparse warning:

	sound/soc/codecs/wm8804.c:101:14: warning: duplicate const

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8804.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index c195c2e..8d91470 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -98,7 +98,7 @@ WM8804_REGULATOR_EVENT(0)
 WM8804_REGULATOR_EVENT(1)
 
 static const char *txsrc_text[] = { "S/PDIF RX", "AIF" };
-static const SOC_ENUM_SINGLE_DECL(txsrc, WM8804_SPDTX4, 6, txsrc_text);
+static SOC_ENUM_SINGLE_DECL(txsrc, WM8804_SPDTX4, 6, txsrc_text);
 
 static const struct snd_kcontrol_new wm8804_tx_source_mux[] = {
 	SOC_DAPM_ENUM_EXT("Input Source", txsrc,
-- 
2.1.4
