From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: acp-da7219-max98357: Make symbol
	da7219_dai_clk static" to the asoc tree
Date: Thu, 26 Apr 2018 12:51:34 +0100
Message-ID: <E1fBfR0-0007TU-4J@debutante>
References: <20180313110353.GA117792@lkp-ib04>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C82267836
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:51:44 +0200 (CEST)
In-Reply-To: <20180313110353.GA117792@lkp-ib04>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk static

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

>From dc29f581fa9d5567c3a01ecfdd7f16b2e613c7fb Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 29 Mar 2018 02:14:03 +0000
Subject: [PATCH] ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk
 static

Fixes the following sparse warning:

sound/soc/amd/acp-da7219-max98357a.c:46:12: warning:
 symbol 'da7219_dai_clk' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c782e494..f41560ecbcd1 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -43,7 +43,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.17.0
