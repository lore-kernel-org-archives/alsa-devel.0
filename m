From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Select RCCLK on
	init()" to the asoc tree
Date: Wed, 07 Mar 2018 14:21:32 +0000
Message-ID: <E1etZwi-0002fH-FM@debutante>
References: <20180225104713.4745-33-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B26BE267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:21:38 +0100 (CET)
In-Reply-To: <20180225104713.4745-33-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Select RCCLK on init()

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

>From c22969d70fc9253112e88da55116e04074cdeac4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:10 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Select RCCLK on init()

When the BYT_RT5651_MCLK_EN quirk is set, we disable the MCLK from
byt_rt5651_init(), we need to select the RCCLK as sysclk before doing this
to make sure that jack-detect works directly after boot.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 6efd7c9e7407..53ce313024f1 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -457,6 +457,11 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
+	/* Start with RC clk for jack-detect (we disable MCLK below) */
+	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
+		snd_soc_component_update_bits(codec, RT5651_GLB_CLK,
+			RT5651_SCLK_SRC_MASK, RT5651_SCLK_SRC_RCCLK);
+
 	switch (BYT_RT5651_MAP(byt_rt5651_quirk)) {
 	case BYT_RT5651_IN1_MAP:
 		custom_map = byt_rt5651_intmic_in1_map;
-- 
2.16.2
