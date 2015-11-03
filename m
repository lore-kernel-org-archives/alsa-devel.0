From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: Fix the Input PGA Mute switch"
	to the asoc tree
Date: Tue, 03 Nov 2015 19:09:40 +0000
Message-ID: <E1Ztgxg-0007Nj-Om@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 766CF2605B0
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 20:09:52 +0100 (CET)
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
To: JongHo Kim <furmuwon@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: Fix the Input PGA Mute switch

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

>From 41a59cae585678136c28cdcbba9cb2faf27685f5 Mon Sep 17 00:00:00 2001
From: JongHo Kim <furmuwon@gmail.com>
Date: Tue, 3 Nov 2015 11:06:32 +0900
Subject: [PATCH] ASoC: wm8960: Fix the Input PGA Mute switch

Change the xinvert value from 0 to 1 on the "Capture Switch" control
WM8960 datasheet is shown as follows:
Bit 7 at 00h and 01h register address
1 : Enable Mute, 0 : Disable Mute

Signed-off-by: JongHo Kim <furmuwon@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e3b7d0c57411..bbe24275f8c9 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -223,7 +223,7 @@ SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
 SOC_DOUBLE_R("Capture Volume ZC Switch", WM8960_LINVOL, WM8960_RINVOL,
 	6, 1, 0),
 SOC_DOUBLE_R("Capture Switch", WM8960_LINVOL, WM8960_RINVOL,
-	7, 1, 0),
+	7, 1, 1),
 
 SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
 	       WM8960_INBMIX1, 4, 7, 0, boost_tlv),
-- 
2.6.2
