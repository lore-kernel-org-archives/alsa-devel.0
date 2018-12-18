From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: Grammar s/the the/the/" to the
	asoc tree
Date: Tue, 18 Dec 2018 15:30:29 +0000 (GMT)
Message-ID: <20181218153029.073B31125500@debutante.sirena.org.uk>
References: <20181218134743.13692-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 164372677E4
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 16:30:32 +0100 (CET)
In-Reply-To: <20181218134743.13692-1-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Jiri Kosina <trivial@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: Grammar s/the the/the/

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

>From 3930bdad68d0fb1d3cb34cd83bb7d552e5d28bb0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 18 Dec 2018 14:47:43 +0100
Subject: [PATCH] ASoC: xlnx: Grammar s/the the/the/

Fixes: 33f8db9a89200c18 ("ASoC: xlnx: enable i2s driver build")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 25e287feb58c..723a583a8d57 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -1,5 +1,5 @@
 config SND_SOC_XILINX_I2S
-	tristate "Audio support for the the Xilinx I2S"
+	tristate "Audio support for the Xilinx I2S"
 	help
 	  Select this option to enable Xilinx I2S Audio. This enables
 	  I2S playback and capture using xilinx soft IP. In transmitter
-- 
2.19.0.rc2
