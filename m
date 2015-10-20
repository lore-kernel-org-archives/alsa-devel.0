From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ASoC: fsl_sai: fix Rx synchrounous mode
Date: Mon, 19 Oct 2015 17:42:23 -0700
Message-ID: <1445301743-24173-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: alsa-devel@alsa-project.org

When using the Rx clock for both, transmitter and receiver, the
transmitter needs to be set to synchronous with receiver.

This reverts 855675f6e6a6 ("ASoC: fsl_sai: Set SYNC bit of TCR2 to
Asynchronous Mode"), which, judiging from the commit log, seems to
mixed up between the two synchronous modes: The boolean
sai->synchronous[TX] is indicating wheather the SAI should work in
Rx synchronous mode (sync Tx with Rx), hence if the value is true,
the SYNC field of TCR2 needs to be set to 0x1 ("Synchronous with
receiver").

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Nicolin,

I got this reported from a customer, he tried to use the device
tree property "fsl,sai-synchronous-rx" according to the description
but it failed. In a quick test, setting the SYNC field of TCR2 to
0x1 helped in his case. So I think this here is right. But given
that you chaged the very same line can you review that again and
give me a Ack/Nack?

--
Stefan

 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a18fd92..1f0e552 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -454,7 +454,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	 * Rx sync with Tx clocks: Clear SYNC for Tx, set it for Rx.
 	 * Tx sync with Rx clocks: Clear SYNC for Rx, set it for Tx.
 	 */
-	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
+		           sai->synchronous[TX] ? FSL_SAI_CR2_SYNC : 0);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
 			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
 
-- 
2.6.1
