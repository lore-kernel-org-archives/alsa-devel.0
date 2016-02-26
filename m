From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cht_bsw_rt5645: Fix writing to string
	literal" to the asoc tree
Date: Fri, 26 Feb 2016 11:46:55 +0900
Message-ID: <E1aZ8Qh-0006In-UL@finisterre>
References: <1456217420-9327-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B2A126524C
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:01 +0100 (CET)
In-Reply-To: <1456217420-9327-1-git-send-email-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cht_bsw_rt5645: Fix writing to string literal

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

>From c8560b7c917f8738f5d80dd516930edc1d05e4e4 Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Tue, 23 Feb 2016 09:50:20 +0100
Subject: [PATCH] ASoC: cht_bsw_rt5645: Fix writing to string literal

We cannot use strcpy() to write to a const char * location. This is
causing a 'BUG: unable to handle kernel paging request' error at boot
when using the cht-bsw-rt5645 driver.

With this patch we also fix a wrong indexing in the driver where the
codec_name of the wrong dai_link is being overwritten.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 2d3afddb0a2e..a7b96a9a4e0e 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -367,8 +367,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 	card->dev = &pdev->dev;
 	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
+
 	/* set correct codec name */
-	strcpy((char *)card->dai_link[2].codec_name, codec_name);
+	for (i = 0; i < ARRAY_SIZE(cht_dailink); i++)
+		if (!strcmp(card->dai_link[i].codec_name, "i2c-10EC5645:00"))
+			card->dai_link[i].codec_name = kstrdup(codec_name, GFP_KERNEL);
+
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
-- 
2.7.0
