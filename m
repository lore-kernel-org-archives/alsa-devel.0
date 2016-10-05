From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: report JACK_LINEOUT event" to
	the asoc tree
Date: Wed, 05 Oct 2016 17:21:46 +0200
Message-ID: <E1bro0w-0004hz-KB@finisterre>
References: <20161004173320.1556-1-sathyanarayana.nujella@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5963C266638
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 17:22:01 +0200 (CEST)
In-Reply-To: <20161004173320.1556-1-sathyanarayana.nujella@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, harshapriya.n@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: report JACK_LINEOUT event

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

>From 64d94b9fbcd4518b0fc695243107d5baded7b154 Mon Sep 17 00:00:00 2001
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Date: Tue, 4 Oct 2016 10:33:20 -0700
Subject: [PATCH] ASoC: Intel: report JACK_LINEOUT event

This patch updates Jack type bitmask to include SND_JACK_LINEOUT while
creating a new jack, so that LINEOUT events are reported properly.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 6532b8f0ab2f..865a21e557cc 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -130,8 +130,8 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 */
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3, &broxton_headset,
-			NULL, 0);
+			SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_LINEOUT,
+			&broxton_headset, NULL, 0);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
-- 
2.9.3
