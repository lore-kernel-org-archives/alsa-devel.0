From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: remove unused variable" to the
	asoc tree
Date: Wed, 09 Mar 2016 09:33:42 +0700
Message-ID: <E1adTwU-00047b-B8@finisterre>
References: <1457424331-15639-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C96A261534
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 03:34:01 +0100 (CET)
In-Reply-To: <1457424331-15639-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: remove unused variable

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

>From c77dd678a7659d58625bd3b3a36d1329d9e7d44c Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Date: Tue, 8 Mar 2016 13:35:31 +0530
Subject: [PATCH] ASoC: rt5640: remove unused variable

We are getting build warning about:
sound/soc/codecs/rt5640.c:1892:11: warning: unused variable 'dai_sel'

The use of the variable was removed but the variable itself was not
removed.

Fixes: c467fc0e010b ("ASoC: rt5640: Set PLL src according to source")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index af9b5f18f0e0..e8b5ba04417a 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1889,7 +1889,7 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 	struct rl6231_pll_code pll_code;
-	int ret, dai_sel;
+	int ret;
 
 	if (source == rt5640->pll_src && freq_in == rt5640->pll_in &&
 	    freq_out == rt5640->pll_out)
-- 
2.7.0
