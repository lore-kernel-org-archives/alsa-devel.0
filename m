From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5102: Correct supported channels on
	trace compressed DAI" to the asoc tree
Date: Mon, 13 Jun 2016 16:47:44 +0100
Message-ID: <E1bCU5Y-0002zP-0f@finisterre>
References: <1465821317-28449-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 43558265DFE
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 17:47:53 +0200 (CEST)
In-Reply-To: <1465821317-28449-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, ajit.pandey@soctronics.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5102: Correct supported channels on trace compressed DAI

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

>From 19edeb30c55079c9bba4573d700bbcafed03303c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 13 Jun 2016 13:35:16 +0100
Subject: [PATCH] ASoC: wm5102: Correct supported channels on trace compressed
 DAI

The audio trace firmware on wm5102 only supports 4 channels correct
the DAI driver structure to reflect this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index da60e3fe5ee7..e7fe6b7b95b7 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1872,7 +1872,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 		.capture = {
 			.stream_name = "Audio Trace CPU",
 			.channels_min = 1,
-			.channels_max = 6,
+			.channels_max = 4,
 			.rates = WM5102_RATES,
 			.formats = WM5102_FORMATS,
 		},
-- 
2.8.1
