From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: use correct
	drvdata in snd_byt_cht_es8316_mc_remove()" to the asoc tree
Date: Thu, 10 Jan 2019 11:54:26 +0000 (GMT)
Message-ID: <20190110115426.092A91127052@debutante.sirena.org.uk>
References: <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 838842674B9
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 12:54:35 +0100 (CET)
In-Reply-To: <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: use correct drvdata in snd_byt_cht_es8316_mc_remove()

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

>From f833fe2056b3a6d69598ef029cede6e77dcc1b14 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 10 Jan 2019 01:43:09 +0000
Subject: [PATCH] ASoC: Intel: bytcht_es8316: use correct drvdata in
 snd_byt_cht_es8316_mc_remove()

The snd_byt_cht_es8316_mc_remove() use the platform drvdata as a type
of 'struct byt_cht_es8316_private', but snd_byt_cht_es8316_mc_probe()
set it to 'struct snd_soc_card', as suggested by Dan Carpenter, fix
the usage in snd_byt_cht_es8316_mc_remove().

Fixes: 0d3e91da0750 ("ASoC: Intel: bytcht_es8316: Add external speaker mux support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index cdf2061e7613..fa9c4cf97686 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -544,7 +544,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 {
-	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
 	return 0;
-- 
2.20.1
