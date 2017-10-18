From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: connect LOUT Amp with Charge
	Pump" to the asoc tree
Date: Wed, 18 Oct 2017 12:12:00 +0100
Message-ID: <E1e4mGW-0002FV-2S@debutante>
References: <1508152516-25767-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 572BA267412
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:12:13 +0200 (CEST)
In-Reply-To: <1508152516-25767-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: connect LOUT Amp with Charge Pump

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

>From a6189d371d05863720e4381361f83ce5d376fad7 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 16 Oct 2017 19:15:14 +0800
Subject: [PATCH] ASoC: rt5659: connect LOUT Amp with Charge Pump

"Charge Pump" is necessary for "LOUT Amp".

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 999432e98a5a..fa66b11df8d4 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3209,6 +3209,7 @@ static const struct snd_soc_dapm_route rt5659_dapm_routes[] = {
 	{ "LOUT R MIX", "OUTVOL R Switch", "OUTVOL R" },
 	{ "LOUT Amp", NULL, "LOUT L MIX" },
 	{ "LOUT Amp", NULL, "LOUT R MIX" },
+	{ "LOUT Amp", NULL, "Charge Pump" },
 	{ "LOUT Amp", NULL, "SYS CLK DET" },
 	{ "LOUT L Playback", "Switch", "LOUT Amp" },
 	{ "LOUT R Playback", "Switch", "LOUT Amp" },
-- 
2.14.1
