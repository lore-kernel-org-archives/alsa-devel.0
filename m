From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6231: remove never matched if
	condition" to the asoc tree
Date: Thu, 21 Dec 2017 12:44:19 +0000
Message-ID: <E1eS0Cx-000599-HK@debutante>
References: <1513826493-9866-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F3F8267868
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 13:44:26 +0100 (CET)
In-Reply-To: <1513826493-9866-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6231: remove never matched if condition

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

>From 790dde243f7dd5b8e576686eba0b891470b09f57 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 21 Dec 2017 11:21:33 +0800
Subject: [PATCH] ASoC: rl6231: remove never matched if condition

(in_t < 0) will never be true since in_t is unsigned.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6231.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 33690e98e297..7ef3b5476bcc 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -178,8 +178,6 @@ int rl6231_pll_calc(const unsigned int freq_in,
 		for (n_t = 0; n_t <= max_n; n_t++) {
 			in_t = f_in * (n_t + 2);
 			pll_out = f_out * (k_t + 2);
-			if (in_t < 0)
-				continue;
 			if (in_t == pll_out) {
 				bypass = true;
 				n = n_t;
-- 
2.15.1
