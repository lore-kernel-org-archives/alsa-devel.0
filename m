From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8994: Fix missing break in switch" to
	the asoc tree
Date: Mon,  6 Aug 2018 14:34:01 +0100 (BST)
Message-ID: <20180806133401.D2E111124240@debutante.sirena.org.uk>
References: <20180806121451.GA14954@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A47BF2677A2
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 15:34:04 +0200 (CEST)
In-Reply-To: <20180806121451.GA14954@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8994: Fix missing break in switch

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

>From ad0eaee6195db1db1749dd46b9e6f4466793d178 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 6 Aug 2018 07:14:51 -0500
Subject: [PATCH] ASoC: wm8994: Fix missing break in switch

Add missing break statement in order to prevent the code from falling
through to the default case.

Addresses-Coverity-ID: 115050 ("Missing break in switch")
Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 62f8c5b9ba92..14f1b0c0d286 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2432,7 +2432,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
 					    WM8994_OPCLK_ENA, 0);
 		}
-		/* fall through */
+		break;
 
 	default:
 		return -EINVAL;
-- 
2.18.0
