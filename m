From: Olivier Moysan <olivier.moysan@st.com>
Subject: [INTERNAL][PATCH 5/7] ASoC: stm32: sai: Remove
	spurious IRQs on stop
Date: Thu, 19 Oct 2017 15:03:21 +0200
Message-ID: <1508418203-16840-6-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E051266DE1
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 15:03:35 +0200 (CEST)
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Clear IRQ mask on stream stop to avoid spurious IRQs.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 815ef10..fd7dc77 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -419,8 +419,6 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 	}
 
 	/* Enable ITs */
-	regmap_update_bits(sai->regmap, STM_SAI_SR_REGX,
-			   SAI_XSR_MASK, (unsigned int)~SAI_XSR_MASK);
 
 	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX,
 			   SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
@@ -693,6 +691,9 @@ static int stm32_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_STOP:
 		dev_dbg(cpu_dai->dev, "Disable DMA and SAI\n");
 
+		regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX,
+				   SAI_XIMR_MASK, 0);
+
 		regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
 				   SAI_XCR1_SAIEN,
 				   (unsigned int)~SAI_XCR1_SAIEN);
-- 
1.9.1
