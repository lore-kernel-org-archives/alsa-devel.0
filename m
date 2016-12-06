From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: disable sinc filter for high
	THD of ADC" to the asoc tree
Date: Tue, 06 Dec 2016 14:35:57 +0000
Message-ID: <E1cEGqb-0003a6-Au@finisterre>
References: <1480643338-9423-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8B15266619
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 15:36:14 +0100 (CET)
In-Reply-To: <1480643338-9423-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: disable sinc filter for high THD of ADC

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

>From 5f1516d52f9287a94dc3b9d57c370ed01802a911 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 2 Dec 2016 09:48:58 +0800
Subject: [PATCH] ASoC: nau8825: disable sinc filter for high THD of ADC

This bit will enable 4th order SINC filter.
=1, filter will enable;  but it consumes higher power.
=0, the sinc filter is disable, and it should always keep 0 value to
get high THD.

Therefor, disable the filter when codec initiation for better
performance when recording.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 3 ++-
 sound/soc/codecs/nau8825.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 2b89569333a1..efe3a44658d5 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1846,7 +1846,8 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 	 * (audible hiss). Set it to something better.
 	 */
 	regmap_update_bits(regmap, NAU8825_REG_ADC_RATE,
-		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_64);
+		NAU8825_ADC_SYNC_DOWN_MASK | NAU8825_ADC_SINC4_EN,
+		NAU8825_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
 		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_64);
 	/* Disable DACR/L power */
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 0672a25617b9..5d1704e73241 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -269,6 +269,8 @@
 #define NAU8825_BIQ_PATH_DAC   (1 << NAU8825_BIQ_PATH_SFT)
 
 /* ADC_RATE (0x2b) */
+#define NAU8825_ADC_SINC4_SFT		4
+#define NAU8825_ADC_SINC4_EN		(1 << NAU8825_ADC_SINC4_SFT)
 #define NAU8825_ADC_SYNC_DOWN_SFT	0
 #define NAU8825_ADC_SYNC_DOWN_MASK	0x3
 #define NAU8825_ADC_SYNC_DOWN_32	0
-- 
2.10.2
