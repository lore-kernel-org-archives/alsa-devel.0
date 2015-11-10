From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6231: avoid using divisible by 3 for
	DMIC clk" to the asoc tree
Date: Tue, 10 Nov 2015 18:59:57 +0000
Message-ID: <E1ZwE97-00026t-Kw@debutante>
References: <1447137655-31293-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4DE226053D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 20:00:02 +0100 (CET)
In-Reply-To: <1447137655-31293-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6231: avoid using divisible by 3 for DMIC clk

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

>From 2f64b6ed44c26eeb3d1bf5428936629cf552eda7 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 10 Nov 2015 14:40:55 +0800
Subject: [PATCH] ASoC: rl6231: avoid using divisible by 3 for DMIC clk

Few codecs will meet no DMIC clock output issue when select a divided
number which is divisible by 3. To prevent this issue, the patch ignore
the numbers when calculating the DMIC clock divider.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6231.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index aca479fa7670..18b42925314e 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -80,6 +80,8 @@ int rl6231_calc_dmic_clk(int rate)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(div); i++) {
+		if ((div[i] % 3) == 0)
+			continue;
 		/* find divider that gives DMIC frequency below 3MHz */
 		if (3000000 * div[i] >= rate)
 			return i;
-- 
2.6.2
