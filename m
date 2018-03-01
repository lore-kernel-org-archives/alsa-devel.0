From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Fix codec capabilities" to the
	asoc tree
Date: Thu, 01 Mar 2018 18:06:37 +0000
Message-ID: <E1erSbF-0005mE-Ge@debutante>
References: <20180301142056.GF30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8099926798E
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:06:38 +0100 (CET)
In-Reply-To: <20180301142056.GF30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Fix codec capabilities

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

>From e6ceb922ca802711db4b48639a9c73f9dc412f87 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 1 Mar 2018 15:20:56 +0100
Subject: [PATCH] ASoC: max9867: Fix codec capabilities

Codes is stereo only with playback and capture streams bind
to the same rate.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index ac30213deac4..367c0329d5c8 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -369,19 +369,20 @@ static struct snd_soc_dai_driver max9867_dai[] = {
 	.name = "max9867-aif1",
 	.playback = {
 		.stream_name = "HiFi Playback",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = MAX9867_RATES,
 		.formats = MAX9867_FORMATS,
 	},
 	.capture = {
 		.stream_name = "HiFi Capture",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = MAX9867_RATES,
 		.formats = MAX9867_FORMATS,
 	},
 	.ops = &max9867_dai_ops,
+	.symmetric_rates = 1,
 	}
 };
 
-- 
2.16.2
