From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: fix argument error in nau8824
	machine" to the asoc tree
Date: Fri, 02 Mar 2018 12:55:05 +0000
Message-ID: <E1erkDJ-0004Rj-V4@debutante>
References: <1519958714-30352-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E44F22673CC
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 13:55:26 +0100 (CET)
In-Reply-To: <1519958714-30352-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: fix argument error in nau8824 machine

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

>From 3bf045d15f52529e8abe26543dbe22af44efb41a Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 2 Mar 2018 10:45:14 +0800
Subject: [PATCH] ASoC: Intel: fix argument error in nau8824 machine

Fix the error: passing argument 1 of 'nau8824_enable_jack_detect'
from incompatible pointer type
  nau8824_enable_jack_detect(codec, jack);
                             ^~~~~
Which expects 'struct snd_soc_component *' but argument is of type
'struct snd_soc_codec *'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 08d0b8128fab..680f2b3a24f9 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -103,8 +103,8 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 	struct snd_soc_jack *jack = &ctx->jack;
-	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
+	struct snd_soc_component *component = codec_dai->component;
 	int ret, jack_type;
 
 	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
@@ -134,7 +134,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	nau8824_enable_jack_detect(codec, jack);
+	nau8824_enable_jack_detect(component, jack);
 
 	return ret;
 }
-- 
2.16.2
