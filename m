From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Fix incorrect VDW value for
	24 bit" to the asoc tree
Date: Wed, 25 Nov 2015 12:11:11 +0000
Message-ID: <E1a1Yul-0001p2-EH@debutante>
References: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2D20260699
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:11:21 +0100 (CET)
In-Reply-To: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
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

   ASoC: rockchip: Fix incorrect VDW value for 24 bit

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

>From 18a9d7486ad28d68920128720514f9555a4c1869 Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Wed, 25 Nov 2015 09:54:11 +0100
Subject: [PATCH] ASoC: rockchip: Fix incorrect VDW value for 24 bit

Correct valid data word register value for 24 bit data width. The
bit value should be 10 (aka 0x2), not 0x10.

This fixes playback of 24 bit audio.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip/rockchip_spdif.h
index 07f86a21046a..921b4095fb92 100644
--- a/sound/soc/rockchip/rockchip_spdif.h
+++ b/sound/soc/rockchip/rockchip_spdif.h
@@ -28,9 +28,9 @@
 #define SPDIF_CFGR_VDW(x)	(x << SPDIF_CFGR_VDW_SHIFT)
 #define SDPIF_CFGR_VDW_MASK	(0xf << SPDIF_CFGR_VDW_SHIFT)
 
-#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x00)
-#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x01)
-#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x10)
+#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x0)
+#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x1)
+#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x2)
 
 /*
  * DMACR
-- 
2.6.2
