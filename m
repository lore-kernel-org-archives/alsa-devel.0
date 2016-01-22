From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: Fix input boost mixer
	left/right naming" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:55 +0000
Message-ID: <E1aMgQB-0004Dt-Tv@debutante>
References: <1453208949-23946-1-git-send-email-stuarth@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A8E261B01
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:27:02 +0100 (CET)
In-Reply-To: <1453208949-23946-1-git-send-email-stuarth@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stuart Henderson <stuart.henderson@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: Fix input boost mixer left/right naming

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

>From 95826a37991de87659e21b3649f265a049724aa2 Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuart.henderson@cirrus.com>
Date: Tue, 19 Jan 2016 13:09:08 +0000
Subject: [PATCH] ASoC: wm8960: Fix input boost mixer left/right naming

INBMIX1 controls LINPUTs and INBMIX2 controls RINPUTs, so fix the naming
accordingly.

Signed-off-by: Stuart Henderson <stuart.henderson@cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 5380798883b5..66057f853fae 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -231,13 +231,13 @@ SOC_DOUBLE_R("Capture Volume ZC Switch", WM8960_LINVOL, WM8960_RINVOL,
 SOC_DOUBLE_R("Capture Switch", WM8960_LINVOL, WM8960_RINVOL,
 	7, 1, 1),
 
-SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
+SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
 	       WM8960_INBMIX1, 4, 7, 0, lineinboost_tlv),
-SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT2 Volume",
+SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
 	       WM8960_INBMIX1, 1, 7, 0, lineinboost_tlv),
-SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
+SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
 	       WM8960_INBMIX2, 4, 7, 0, lineinboost_tlv),
-SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
+SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT2 Volume",
 	       WM8960_INBMIX2, 1, 7, 0, lineinboost_tlv),
 SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT1 Volume",
 		WM8960_RINPATH, 4, 3, 0, micboost_tlv),
-- 
2.7.0.rc3
