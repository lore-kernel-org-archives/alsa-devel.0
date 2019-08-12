From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Allow reconfiguration of
	tdm_slots and slot_width" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:47 +0100 (BST)
Message-ID: <20190812130947.B354D2740CB7@ypsilon.sirena.org.uk>
References: <20190812095226.18870-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58EB5F805AF
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:09:59 +0200 (CEST)
In-Reply-To: <20190812095226.18870-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: Allow reconfiguration of tdm_slots and slot_width

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

>From 6fa4e0cae684d268d309d1b1f929d52e3df5649c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 12 Aug 2019 12:52:26 +0300
Subject: [PATCH] ASoC: pcm3168a: Allow reconfiguration of tdm_slots and
 slot_width

When using right_j format and the codec is slave it can support 16bit
format, but only if slot_width == 16, in the same DAI mode the 24 bit
audio can work with 24 or 32 slot_width.

Because of this, the codec and CPU needs to be reconfigured when the sample
format changes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190812095226.18870-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 75fa8e9ee894..50ed86d45c26 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -402,18 +402,6 @@ static int pcm3168a_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		return -EINVAL;
 	}
 
-	if (io_params->tdm_slots && io_params->tdm_slots != slots) {
-		dev_err(component->dev, "Not matching slots %d vs %d\n",
-			io_params->tdm_slots, slots);
-		return -EINVAL;
-	}
-
-	if (io_params->slot_width && io_params->slot_width != slot_width) {
-		dev_err(component->dev, "Not matching slot_width %d vs %d\n",
-			io_params->slot_width, slot_width);
-		return -EINVAL;
-	}
-
 	io_params->tdm_slots = slots;
 	io_params->slot_width = slot_width;
 	/* Ignore the not relevant mask for the DAI/direction */
-- 
2.20.1
