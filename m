From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: max98088: fix typo in constant"
	to the asoc tree
Date: Tue, 07 Jul 2015 14:58:03 +0100
Message-ID: <E1ZCTNr-0005bI-PQ@finisterre>
References: <1435700582-17286-1-git-send-email-nikolas@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDDF4265743
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:17 +0200 (CEST)
In-Reply-To: <1435700582-17286-1-git-send-email-nikolas@gnu.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nik Nyby <nikolas@gnu.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: max98088: fix typo in constant

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

>From b650247da5a8c5d8991eeb9cf31e2e71d7be1b08 Mon Sep 17 00:00:00 2001
From: Nik Nyby <nikolas@gnu.org>
Date: Tue, 30 Jun 2015 17:43:02 -0400
Subject: [PATCH] ASoC: codecs: max98088: fix typo in constant

This fixes a typo in the M98088_REG_02_JACK_STATUS constant.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98088.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98088.h b/sound/soc/codecs/max98088.h
index be89a4f..efa39bf 100644
--- a/sound/soc/codecs/max98088.h
+++ b/sound/soc/codecs/max98088.h
@@ -16,7 +16,7 @@
  */
 #define M98088_REG_00_IRQ_STATUS            0x00
 #define M98088_REG_01_MIC_STATUS            0x01
-#define M98088_REG_02_JACK_STAUS            0x02
+#define M98088_REG_02_JACK_STATUS           0x02
 #define M98088_REG_03_BATTERY_VOLTAGE       0x03
 #define M98088_REG_0F_IRQ_ENABLE            0x0F
 #define M98088_REG_10_SYS_CLK               0x10
-- 
2.1.4
