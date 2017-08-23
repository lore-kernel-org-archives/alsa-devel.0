From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: Add pm callbacks to
	platform driver" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:51 +0100
Message-ID: <E1dkTmF-0007Cx-Qs@debutante>
References: <87wp5w4379.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 607FC26725C
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:55 +0200 (CEST)
In-Reply-To: <87wp5w4379.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: Add pm callbacks to platform driver

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

>From b4e0180306f10a9d808b855dd77cdd0d7ae4f3fa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Aug 2017 04:56:06 +0000
Subject: [PATCH] ASoC: simple-scu-card: Add pm callbacks to platform driver

Set snd_soc_pm_ops for the pm ops to make sure that the ASoC level of PM
operations are going to happen. This is needed to get suspend/resume
working correctly when the audio is using simple-scu-card.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 0bb3da755532..48606c63562a 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -300,6 +300,7 @@ MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
 static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name = "simple-scu-audio-card",
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = asoc_simple_of_match,
 	},
 	.probe = asoc_simple_card_probe,
-- 
2.14.1
