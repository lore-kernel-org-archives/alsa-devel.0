From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8524: Don't use dev_err to show
	supported sample rate" to the asoc tree
Date: Wed, 02 Aug 2017 18:30:26 +0100
Message-ID: <E1dcxTW-0003rU-9B@debutante>
References: <20170802081346.8179-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 267FF2673DC
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:30:36 +0200 (CEST)
In-Reply-To: <20170802081346.8179-1-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Mihai Serban <mihai.serban@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8524: Don't use dev_err to show supported sample rate

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

>From 80bfd0431f7dc133f4edbc0b864f800c4ed7a3f4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 2 Aug 2017 16:13:46 +0800
Subject: [PATCH] ASoC: wm8524: Don't use dev_err to show supported sample rate

Switch to use dev_dbg instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8524.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index e22b76d64e32..b66147e0631b 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -118,7 +118,7 @@ static int wm8524_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		case 96000:
 		case 176400:
 		case 192000:
-			dev_err(codec->dev, "Supported sample rate: %dHz\n",
+			dev_dbg(codec->dev, "Supported sample rate: %dHz\n",
 				val);
 			wm8524->rate_constraint_list[j++] = val;
 			wm8524->rate_constraint.count++;
-- 
2.13.2
