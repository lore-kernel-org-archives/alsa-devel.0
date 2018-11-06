From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ak5558: Remove redundant
	snd_soc_component_read32 calls
Date: Tue,  6 Nov 2018 17:39:19 +0800
Message-ID: <20181106093919.20740-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B3E2267839
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 10:39:29 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so5848972pfi.5
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2018 01:39:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_component_update_bits() will only update the mask bits,
so remove the redundant snd_soc_component_read32().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ak5558.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 60f1f12c81ea..8179512129d3 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -130,16 +130,12 @@ static int ak5558_hw_params(struct snd_pcm_substream *substream,
 	u8 bits;
 	int pcm_width = max(params_physical_width(params), ak5558->slot_width);
 
-	/* set master/slave audio interface */
-	bits = snd_soc_component_read32(component, AK5558_02_CONTROL1);
-	bits &= ~AK5558_BITS;
-
 	switch (pcm_width) {
 	case 16:
-		bits |= AK5558_DIF_24BIT_MODE;
+		bits = AK5558_DIF_24BIT_MODE;
 		break;
 	case 32:
-		bits |= AK5558_DIF_32BIT_MODE;
+		bits = AK5558_DIF_32BIT_MODE;
 		break;
 	default:
 		return -EINVAL;
@@ -168,18 +164,15 @@ static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set master/slave audio interface */
-	format = snd_soc_component_read32(component, AK5558_02_CONTROL1);
-	format &= ~AK5558_DIF;
-
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		format |= AK5558_DIF_I2S_MODE;
+		format = AK5558_DIF_I2S_MODE;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		format |= AK5558_DIF_MSB_MODE;
+		format = AK5558_DIF_MSB_MODE;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		format |= AK5558_DIF_MSB_MODE;
+		format = AK5558_DIF_MSB_MODE;
 		break;
 	default:
 		return -EINVAL;
-- 
2.17.1
