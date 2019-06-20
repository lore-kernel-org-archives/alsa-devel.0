From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Rename min_frame_size to
	slot_width" to the asoc tree
Date: Thu, 20 Jun 2019 14:32:24 +0100 (BST)
Message-ID: <20190620133224.7430544004A@finisterre.sirena.org.uk>
References: <20190620092656.14759-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ABF9F89717
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 15:32:26 +0200 (CEST)
In-Reply-To: <20190620092656.14759-2-peter.ujfalusi@ti.com>
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

   ASoC: pcm3168a: Rename min_frame_size to slot_width

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From b5d8dffb8cc9792c3bb4310e142932c8bc5c0387 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 20 Jun 2019 12:26:55 +0300
Subject: [PATCH] ASoC: pcm3168a: Rename min_frame_size to slot_width

It represents slot size and not frame.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 9eb24ca09793..e1658947090b 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -435,7 +435,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	u32 val, mask, shift, reg;
 	unsigned int rate, fmt, ratio, max_ratio;
 	unsigned int chan;
-	int i, min_frame_size;
+	int i, slot_width;
 
 	rate = params_rate(params);
 	chan = params_channels(params);
@@ -470,11 +470,11 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (pcm3168a->slot_width)
-		min_frame_size = pcm3168a->slot_width;
+		slot_width = pcm3168a->slot_width;
 	else
-		min_frame_size = params_width(params);
+		slot_width = params_width(params);
 
-	switch (min_frame_size) {
+	switch (slot_width) {
 	case 16:
 		if (master_mode || (fmt != PCM3168A_FMT_RIGHT_J)) {
 			dev_err(component->dev, "16-bit slots are supported only for slave mode using right justified\n");
@@ -491,7 +491,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	case 32:
 		break;
 	default:
-		dev_err(component->dev, "unsupported frame size: %d\n", min_frame_size);
+		dev_err(component->dev, "unsupported frame size: %d\n", slot_width);
 		return -EINVAL;
 	}
 
-- 
2.20.1
