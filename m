From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Add missing prepare for iis
	clock of s3c24xx" to the asoc tree
Date: Fri, 28 Jul 2017 11:18:05 +0100
Message-ID: <E1db2LN-0003nf-Rr@debutante>
References: <20170727171338.13300-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A2F0267726
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 12:18:20 +0200 (CEST)
In-Reply-To: <20170727171338.13300-3-krzk@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Arvind@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, "Yadav <arvind.yadav.cs"@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Add missing prepare for iis clock of s3c24xx

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

>From 81ea6cc73c384e4093519e0c75394aa2a1941a10 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 27 Jul 2017 19:13:37 +0200
Subject: [PATCH] ASoC: samsung: Add missing prepare for iis clock of s3c24xx

The s3c_i2sv2_probe() only enabled iis clock.  Missing prepare isn't
probably fatal, because for SoC clocks this is usually no-op, but for
correctness this clock should be prepared.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Arvind Yadav<arvind.yadav.cs@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 9b28046eea8e..3894bda06ebb 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -637,7 +637,7 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 		return -ENOENT;
 	}
 
-	clk_enable(i2s->iis_pclk);
+	clk_prepare_enable(i2s->iis_pclk);
 
 	/* Mark ourselves as in TXRX mode so we can run through our cleanup
 	 * process without warnings. */
-- 
2.13.2
