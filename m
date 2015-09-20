From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: correct the max register value
	of mic boost pga" to the asoc tree
Date: Sat, 19 Sep 2015 17:13:03 -0700
Message-ID: <E1ZdSFb-00040m-Qk@finisterre>
References: <119b66684faaf7ff237dfccc864ec8e0561aefd3.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D672605D7
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:18 +0200 (CEST)
In-Reply-To: <119b66684faaf7ff237dfccc864ec8e0561aefd3.1442566367.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: correct the max register value of mic boost pga

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

>From 8524bb0c7ac688a3cd6ba12dae6104c54d0566b9 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 18 Sep 2015 17:19:43 +0800
Subject: [PATCH] ASoC: wm8960: correct the max register value of mic boost pga

the max register value of mic boost pga should be 3.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 70816f0..d9b43b0 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -234,9 +234,9 @@ SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
 SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
 	       WM8960_INBMIX2, 1, 7, 0, lineinboost_tlv),
 SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT1 Volume",
-		WM8960_RINPATH, 4, 4, 0, micboost_tlv),
+		WM8960_RINPATH, 4, 3, 0, micboost_tlv),
 SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT1 Volume",
-		WM8960_LINPATH, 4, 4, 0, micboost_tlv),
+		WM8960_LINPATH, 4, 3, 0, micboost_tlv),
 
 SOC_DOUBLE_R_TLV("Playback Volume", WM8960_LDAC, WM8960_RDAC,
 		 0, 255, 0, dac_tlv),
-- 
2.5.0
