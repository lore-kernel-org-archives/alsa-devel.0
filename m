From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: Add missing 10EC5072 ACPI ID"
	to the asoc tree
Date: Wed, 30 Nov 2016 17:16:35 +0000
Message-ID: <E1cC8Ul-0005tt-3W@debutante>
References: <20161130135529.22163-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B881266B78
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 18:16:45 +0100 (CET)
In-Reply-To: <20161130135529.22163-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: Add missing 10EC5072 ACPI ID

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

>From d25280060835e1b2b84c242905da8334ab15c5b4 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 30 Nov 2016 14:55:29 +0100
Subject: [PATCH] ASoC: rt5670: Add missing 10EC5072 ACPI ID

rt5670 driver supports also RT5672 codec, but its ACPI ID is missing.
This was found on Dell Wyse 3040 box.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index d32ebe73c2c9..97bafac3bc15 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2813,6 +2813,7 @@ MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5670_acpi_match[] = {
 	{ "10EC5670", 0},
+	{ "10EC5672", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5670_acpi_match);
-- 
2.10.2
