From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: user configuration of key
	detection" to the asoc tree
Date: Tue, 17 Apr 2018 18:09:29 +0100
Message-ID: <E1f8U6j-0001fI-3f@debutante>
References: <1521617423-2213-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 827E526763F
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 19:09:33 +0200 (CEST)
In-Reply-To: <1521617423-2213-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: user configuration of key detection

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7b0037fa2d6048284e90de4131fc53c0ac1d4430 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Wed, 21 Mar 2018 15:30:23 +0800
Subject: [PATCH] ASoC: nau8824: user configuration of key detection

The SAR ADC of key press detection varies depending on headset.
We can't make a set of common threshold values for every case.
Therefore, the driver provides configuration for user and
they can set up values by UCM configuration.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 637e9527805f..76502c090654 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -409,6 +409,15 @@ static const struct snd_kcontrol_new nau8824_snd_controls[] = {
 
 	SOC_SINGLE("DACL LR Mix", NAU8824_REG_DAC_MUTE_CTRL, 0, 1, 0),
 	SOC_SINGLE("DACR LR Mix", NAU8824_REG_DAC_MUTE_CTRL, 1, 1, 0),
+
+	SOC_SINGLE("THD for key media",
+		NAU8824_REG_VDET_THRESHOLD_1, 8, 0xff, 0),
+	SOC_SINGLE("THD for key voice command",
+		NAU8824_REG_VDET_THRESHOLD_1, 0, 0xff, 0),
+	SOC_SINGLE("THD for key volume up",
+		NAU8824_REG_VDET_THRESHOLD_2, 8, 0xff, 0),
+	SOC_SINGLE("THD for key volume down",
+		NAU8824_REG_VDET_THRESHOLD_2, 0, 0xff, 0),
 };
 
 static int nau8824_output_dac_event(struct snd_soc_dapm_widget *w,
-- 
2.17.0
