From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Fix overwriting of
	ahclkx" to the asoc tree
Date: Mon, 02 May 2016 12:03:45 +0100
Message-ID: <E1axBdh-0001Zr-M2@debutante>
References: <1461600490-19504-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A9A26047C
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 13:03:58 +0200 (CEST)
In-Reply-To: <1461600490-19504-1-git-send-email-Linux.HWI@garmin.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jim Lodes <jim.lodes@garmin.com>
Cc: "J.D. Schroeder" <jay.schroeder@garmin.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org, jsarha@ti.com, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Fix overwriting of ahclkx

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

>From 823ecdd684e28d4e71686fc8787b6d31b1223382 Mon Sep 17 00:00:00 2001
From: Jim Lodes <jim.lodes@garmin.com>
Date: Mon, 25 Apr 2016 11:08:10 -0500
Subject: [PATCH] ASoC: davinci-mcasp: Fix overwriting of ahclkx

The mcasp davinci_mcasp_set_dai_fmt function was overriding ahclkx
input/output status that had already been set by the
davinci_mcasp_set_sysclk function. This commit removes clearing
of the ahclkx input/output status from davinci_mcasp_set_dai_fmt.

Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e1324989bd6b..a1197ad023f6 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -489,7 +489,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG,
-			       ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
+			       ACLKX | AFSX | ACLKR | AHCLKR | AFSR);
 		mcasp->bclk_master = 0;
 		break;
 	default:
-- 
2.8.1
