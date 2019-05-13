From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use i on snd_soc_resume()" to
	the asoc tree
Date: Mon, 13 May 2019 13:30:27 +0100 (BST)
Message-ID: <20190513123027.EDE521129232@debutante.sirena.org.uk>
References: <87woiualtp.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3FDBF8972A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <87woiualtp.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: use i on snd_soc_resume()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 22d251a5964780452aed378a143816fbf2d4201d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2019 16:06:07 +0900
Subject: [PATCH] ASoC: soc-core: use i on snd_soc_resume()

This patch uses "int i" instead of "int j" on snd_soc_resume(),
and moves struct snd_soc_dai *codec_dai to top of this function.
This is cleanup and prepare for Multi CPU support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2403bec2fccf..0d9b02075050 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -687,6 +687,8 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	bool bus_control = false;
 	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
@@ -694,14 +696,12 @@ int snd_soc_resume(struct device *dev)
 
 	/* activate pins from sleep state */
 	for_each_card_rtds(card, rtd) {
-		struct snd_soc_dai *codec_dai;
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-		int j;
 
 		if (cpu_dai->active)
 			pinctrl_pm_select_default_state(cpu_dai->dev);
 
-		for_each_rtd_codec_dai(rtd, j, codec_dai) {
+		for_each_rtd_codec_dai(rtd, i, codec_dai) {
 			if (codec_dai->active)
 				pinctrl_pm_select_default_state(codec_dai->dev);
 		}
-- 
2.20.1
