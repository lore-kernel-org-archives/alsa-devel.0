From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: Fix slot mask
	settings when using multiple AXRs" to the asoc tree
Date: Thu, 20 Jun 2019 14:32:24 +0100 (BST)
Message-ID: <20190620133224.8E2D744004B@finisterre.sirena.org.uk>
References: <20190620092002.13766-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E39EF80C15
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 15:32:25 +0200 (CEST)
In-Reply-To: <20190620092002.13766-3-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-mcasp: Fix slot mask settings when using multiple AXRs

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

>From fd14f4436fd47d5418023c90e933e66d3645552e Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 20 Jun 2019 12:20:02 +0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Fix slot mask settings when using
 multiple AXRs

If multiple serializers are connected in the system and the number of
channels will need to use more than one serializer the mask to enable the
serializers were left to 0 if tdm_mask is provided

Fixes: dd55ff8346a97 ("ASoC: davinci-mcasp: Add set_tdm_slots() support")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 8bec0dc4f754..62222915d632 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -946,14 +946,13 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
 		active_slots = hweight32(mcasp->tdm_mask[stream]);
 		active_serializers = (channels + active_slots - 1) /
 			active_slots;
-		if (active_serializers == 1) {
+		if (active_serializers == 1)
 			active_slots = channels;
-			for (i = 0; i < total_slots; i++) {
-				if ((1 << i) & mcasp->tdm_mask[stream]) {
-					mask |= (1 << i);
-					if (--active_slots <= 0)
-						break;
-				}
+		for (i = 0; i < total_slots; i++) {
+			if ((1 << i) & mcasp->tdm_mask[stream]) {
+				mask |= (1 << i);
+				if (--active_slots <= 0)
+					break;
 			}
 		}
 	} else {
-- 
2.20.1
