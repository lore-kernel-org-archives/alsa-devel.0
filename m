From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Fixup build error for mt6358" to the
	asoc tree
Date: Mon, 28 Jan 2019 12:35:26 +0000 (GMT)
Message-ID: <20190128123526.D19971127D29@debutante.sirena.org.uk>
References: <87imy9h6m4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 15246267454
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:35:28 +0100 (CET)
In-Reply-To: <87imy9h6m4.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Shunli Wang <shunli.wang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Fixup build error for mt6358

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

>From 141474c6ac7f279824780453d3f9c75d6193dc85 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 28 Jan 2019 11:24:34 +0900
Subject: [PATCH] ASoC: Fixup build error for mt6358

This patch fixup build error for
commit 6a8d4198ca8 ("ASoC: mediatek: mt6358: add codec driver")

Fixes: commit 6a8d4198ca8 ("ASoC: mediatek: mt6358: add codec driver")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 55fd58015c2d..83ef965cbff1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1344,7 +1344,7 @@ config SND_SOC_MT6358
 	tristate "MediaTek MT6358 Codec"
 	help
 	  Enable support for the platform which uses MT6358 as
-	external codec device.
+	  external codec device.
 
 config SND_SOC_NAU8540
        tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
-- 
2.20.1
