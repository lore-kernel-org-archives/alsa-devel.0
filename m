From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: spdif: Set transmit data
	level to 16 samples" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:38 +0000
Message-ID: <E1a7tGM-0002hH-MJ@finisterre>
References: <1449823533-6993-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 961A0260A59
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:46 +0100 (CET)
In-Reply-To: <1449823533-6993-1-git-send-email-sjoerd.simons@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: spdif: Set transmit data level to 16 samples

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

>From 5042f936c6810d0e7153cc9e1794c6998590a930 Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Fri, 11 Dec 2015 09:45:33 +0100
Subject: [PATCH] ASoC: rockchip: spdif: Set transmit data level to 16 samples

Explicitly set the transmit data level on the transceiver to 16 samples
rather then the default 0. This matches both the level set in the vendor
kernel and the (seemingly very similar) i2s engine. This fixes audio
glitches when playing back at 192k rate.

At the same time, fix a trivial typo in the TDL mask definition

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 6 ++++--
 sound/soc/rockchip/rockchip_spdif.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index a38a302..bb09a07 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -152,8 +152,10 @@ static int rk_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
-				   SPDIF_DMACR_TDE_ENABLE,
-				   SPDIF_DMACR_TDE_ENABLE);
+				   SPDIF_DMACR_TDE_ENABLE |
+				   SPDIF_DMACR_TDL_MASK,
+				   SPDIF_DMACR_TDE_ENABLE |
+				   SPDIF_DMACR_TDL(16));
 
 		if (ret != 0)
 			return ret;
diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip/rockchip_spdif.h
index 07f86a2..9c24dbc 100644
--- a/sound/soc/rockchip/rockchip_spdif.h
+++ b/sound/soc/rockchip/rockchip_spdif.h
@@ -42,7 +42,7 @@
 
 #define SPDIF_DMACR_TDL_SHIFT	0
 #define SPDIF_DMACR_TDL(x)	((x) << SPDIF_DMACR_TDL_SHIFT)
-#define SPDIF_DMACR_TDL_MASK	(0x1f << SDPIF_DMACR_TDL_SHIFT)
+#define SPDIF_DMACR_TDL_MASK	(0x1f << SPDIF_DMACR_TDL_SHIFT)
 
 /*
  * XFER
-- 
2.6.4
