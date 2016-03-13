From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-hdmi-audio: Support for DRA7xx
	family" to the asoc tree
Date: Sun, 13 Mar 2016 15:15:07 +0700
Message-ID: <E1af1B5-0004Jl-Ng@finisterre>
References: <1457705094-7556-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A60182608F0
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:15 +0100 (CET)
In-Reply-To: <1457705094-7556-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-hdmi-audio: Support for DRA7xx family

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

>From e04fadaa169b09609fb55779236d35fb3197c932 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 11 Mar 2016 16:04:54 +0200
Subject: [PATCH] ASoC: omap-hdmi-audio: Support for DRA7xx family

DRA7xx family is compatible with the OMAP5 HDMI.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-hdmi-audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index f83cc2bc0fc4..64425d352962 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -345,6 +345,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 		dai_drv = &omap4_hdmi_dai;
 		break;
 	case OMAPDSS_VER_OMAP5:
+	case OMAPDSS_VER_DRA7xx:
 		dai_drv = &omap5_hdmi_dai;
 		break;
 	default:
-- 
2.7.0
