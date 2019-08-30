From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-evm: Do not fail if the
	dai_set_sysclk returns -ENOTSUPP" to the asoc tree
Date: Fri, 30 Aug 2019 12:45:18 +0100 (BST)
Message-ID: <20190830114518.95B422742BD3@ypsilon.sirena.org.uk>
References: <20190830103841.25128-5-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 604A6F80445
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 13:45:20 +0200 (CEST)
In-Reply-To: <20190830103841.25128-5-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, nsekhar@ti.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-evm: Do not fail if the dai_set_sysclk returns -ENOTSUPP

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 69f34053f883a53e86fa8ff7b99a81d8b5d50dae Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 30 Aug 2019 13:38:41 +0300
Subject: [PATCH] ASoC: ti: davinci-evm: Do not fail if the dai_set_sysclk
 returns -ENOTSUPP

The davinci McBSP (davinci-i2s) driver does not implement the set_sysclk
callback, which is fine and should not be treated as error.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190830103841.25128-5-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index bfd8d1a03ba7..686b23d7a90d 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -68,7 +68,7 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 
 	/* set the CPU system clock */
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
-	if (ret < 0)
+	if (ret < 0 && ret != -ENOTSUPP)
 		return ret;
 
 	return 0;
-- 
2.20.1
