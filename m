From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: fix fake interruption when
	booting" to the asoc tree
Date: Thu, 13 Jun 2019 16:56:38 +0100 (BST)
Message-ID: <20190613155638.6B71C440049@finisterre.sirena.org.uk>
References: <20190610034040.12629-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80F18F896F1
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 17:56:41 +0200 (CEST)
In-Reply-To: <20190610034040.12629-1-KCHSU0@nuvoton.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, WTLI@nuvoton.com, lgirdwood@gmail.com, yuhsuan@google.com, YHCHuang@nuvoton.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: fix fake interruption when booting

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From cbb9f8ccc8232b4647c4180af653eee744818221 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Mon, 10 Jun 2019 11:40:40 +0800
Subject: [PATCH] ASoC: nau8825: fix fake interruption when booting

There is no pull-up resistor at IRQ line where it connects from
the codec to SoC. When booting, the signal of IRQ pin will keep low
which makes the SoC invoke the ISR repeatedly because the IRQ is
registered trigger low. It will not stop until the codec sets up
the interruption and pulls the signal high. In the patch,
nau8825 will internally pull the signal to high at booting in case
the fake interrupts happen.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 4 ++++
 sound/soc/codecs/nau8825.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 47e65cf99879..83ec841f7865 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1881,6 +1881,10 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 		NAU8825_JACK_EJECT_DEBOUNCE_MASK,
 		nau8825->jack_eject_debounce << NAU8825_JACK_EJECT_DEBOUNCE_SFT);
 
+	/* Pull up IRQ pin */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_PIN_PULLUP | NAU8825_IRQ_PIN_PULL_EN,
+		NAU8825_IRQ_PIN_PULLUP | NAU8825_IRQ_PIN_PULL_EN);
 	/* Mask unneeded IRQs: 1 - disable, 0 - enable */
 	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK, 0x7ff, 0x7ff);
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index f6074c618569..3f41897ed3f6 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -171,6 +171,8 @@
 #define NAU8825_JACK_POLARITY	(1 << 1) /* 0 - active low, 1 - active high */
 
 /* INTERRUPT_MASK (0xf) */
+#define NAU8825_IRQ_PIN_PULLUP (1 << 14)
+#define NAU8825_IRQ_PIN_PULL_EN (1 << 13)
 #define NAU8825_IRQ_OUTPUT_EN (1 << 11)
 #define NAU8825_IRQ_HEADSET_COMPLETE_EN (1 << 10)
 #define NAU8825_IRQ_RMS_EN (1 << 8)
-- 
2.20.1
