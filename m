From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6231: fix range of DMIC clock" to the
	asoc tree
Date: Mon, 16 Nov 2015 17:02:48 +0000
Message-ID: <E1ZyNB2-0005md-Vu@debutante>
References: <1447656067-19415-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B6D92604EF
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:02:55 +0100 (CET)
In-Reply-To: <1447656067-19415-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6231: fix range of DMIC clock

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

>From 7336dcefac4d8f94fa205a668138a6462841acc4 Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Mon, 16 Nov 2015 14:41:07 +0800
Subject: [PATCH] ASoC: rl6231: fix range of DMIC clock

The maximum DMIC clock rate is 3.072 MHz for most DMIC. And it will get better
performance in higher clock rate. If we set maximum to 3 MHz in driver, we will
get a clock rate which is not even close to 3 MHz.
For example, if DMIC clock source is 24.576 MHz, the DMIC clock will be about
1.5 MHz in current code. But it will be 3.072 MHz with this patch.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6231.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 18b42925314e..1dc68ab08a17 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -82,8 +82,8 @@ int rl6231_calc_dmic_clk(int rate)
 	for (i = 0; i < ARRAY_SIZE(div); i++) {
 		if ((div[i] % 3) == 0)
 			continue;
-		/* find divider that gives DMIC frequency below 3MHz */
-		if (3000000 * div[i] >= rate)
+		/* find divider that gives DMIC frequency below 3.072MHz */
+		if (3072000 * div[i] >= rate)
 			return i;
 	}
 
-- 
2.6.2
