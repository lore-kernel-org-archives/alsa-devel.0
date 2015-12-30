From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Exit startup early if no
	runtime" to the asoc tree
Date: Wed, 30 Dec 2015 18:05:15 +0000
Message-ID: <E1aEL7b-0007Kq-Ku@debutante>
References: <1450874881-31458-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 875BE2659D7
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:05:24 +0100 (CET)
In-Reply-To: <1450874881-31458-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Exit startup early if no runtime

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

>From 26eb5a9a6a8545ebb9d45de9e6d43e511b250839 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 29 Dec 2015 09:49:19 +0000
Subject: [PATCH] ASoC: arizona: Exit startup early if no runtime

commit 9b8ef9f6b3fc ("ASoC: dapm: Add startup & shutdown for dai_links")

Added support for calling startup on CODEC to CODEC links, however this
is called with a NULL runtime pointer. There isn't really a sensible way
to pass a valid runtime pointer to a CODEC to CODEC link at the moment,
so we need to make the startup function safe for NULL runtimes.

This patch returns from the Arizona startup function early if there is no
runtime, this is perfectly safe as all the startup function does is set
the PCM constraints for user-space which arn't relevant to a CODEC to
CODEC link anyway.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 38a73e3da508..88e2c74f1d17 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1494,6 +1494,9 @@ static int arizona_startup(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hw_constraint_list *constraint;
 	unsigned int base_rate;
 
+	if (!substream->runtime)
+		return 0;
+
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
 		base_rate = priv->sysclk;
-- 
2.6.2
