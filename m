From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Don't use ~FSL_SAI_CR2_SYNC
Date: Mon,  4 Aug 2014 16:17:44 +0100
Message-ID: <1407165464-18578-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABDC926084B
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 17:18:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

On 64 bit systems ~FSL_SAI_CR2_SYNC generates a constant that won't fit in
an unsigned int, causing GCC to warn.  Since we're already only updating
one bit due to the masking in update bits just write the value
explicitly as zero.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/fsl_sai.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index faa0497..9f10575 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -333,8 +333,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	 * The transmitter bit clock and frame sync are to be
 	 * used by both the transmitter and receiver.
 	 */
-	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
-			   ~FSL_SAI_CR2_SYNC);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
 			   FSL_SAI_CR2_SYNC);
 
-- 
2.0.0
