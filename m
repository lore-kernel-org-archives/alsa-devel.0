From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Use the more idiomatic
	params_width" to the asoc tree
Date: Thu, 09 Jul 2015 12:20:28 +0100
Message-ID: <E1ZD9sS-0005qV-Ml@debutante>
References: <1436437726-16159-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D54B265163
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 13:20:40 +0200 (CEST)
In-Reply-To: <1436437726-16159-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: arizona: Use the more idiomatic params_width

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

>From 5ed68f0a28f96c5127246d1743dd57b58a090f07 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 9 Jul 2015 11:28:46 +0100
Subject: [PATCH] ASoC: arizona: Use the more idiomatic params_width

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a88202d768f4..c246fbd70881 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1504,7 +1504,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	else
 		rates = &arizona_48k_bclk_rates[0];
 
-	wl = snd_pcm_format_width(params_format(params));
+	wl = params_width(params);
 
 	if (tdm_slots) {
 		arizona_aif_dbg(dai, "Configuring for %d %d bit TDM slots\n",
-- 
2.1.4
