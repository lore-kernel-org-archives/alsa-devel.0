From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: namespace rockchip i2s module
	name" to the asoc tree
Date: Tue, 06 Oct 2015 11:56:20 +0100
Message-ID: <E1ZjPuu-0005HK-U8@finisterre>
References: <1444071819-11521-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED992650D4
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 12:56:42 +0200 (CEST)
In-Reply-To: <1444071819-11521-1-git-send-email-sjoerd.simons@collabora.co.uk>
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

   ASoC: rockchip: namespace rockchip i2s module name

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

>From 698d0b59f3d91cc44a76dd2994a002d263c3606b Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Mon, 5 Oct 2015 21:03:39 +0200
Subject: [PATCH] ASoC: rockchip: namespace rockchip i2s module name

Change the rockchip i2s object name (and thus module name) from the
rather generic snd-soc-i2s to the more specific snd-soc-rockchip-i2s

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 1bc1dc3..e9ba558 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,7 +1,7 @@
 # ROCKCHIP Platform Support
-snd-soc-i2s-objs := rockchip_i2s.o
+snd-soc-rockchip-i2s-objs := rockchip_i2s.o
 
-obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
 
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
-- 
2.5.0
