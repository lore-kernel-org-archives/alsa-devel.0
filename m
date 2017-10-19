From: Olivier Moysan <olivier.moysan@st.com>
Subject: [INTERNAL][PATCH 4/7] ASoC: stm32: sai: fix stop
	management in isr
Date: Thu, 19 Oct 2017 15:03:20 +0200
Message-ID: <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 98B08266DB1
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 15:03:34 +0200 (CEST)
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

Add check on substream validity.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2af397d..815ef10 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -184,7 +184,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 static irqreturn_t stm32_sai_isr(int irq, void *devid)
 {
 	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
-	struct snd_pcm_substream *substream = sai->substream;
 	struct platform_device *pdev = sai->pdev;
 	unsigned int sr, imr, flags;
 	snd_pcm_state_t status = SNDRV_PCM_STATE_RUNNING;
@@ -199,6 +198,11 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
 			   SAI_XCLRFR_MASK);
 
+	if (!sai->substream) {
+		dev_err(&pdev->dev, "Device stopped. Spurious IRQ 0x%x\n", sr);
+		return IRQ_NONE;
+	}
+
 	if (flags & SAI_XIMR_OVRUDRIE) {
 		dev_err(&pdev->dev, "IRQ %s\n",
 			STM_SAI_IS_PLAYBACK(sai) ? "underrun" : "overrun");
@@ -227,9 +231,9 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 	}
 
 	if (status != SNDRV_PCM_STATE_RUNNING) {
-		snd_pcm_stream_lock(substream);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(substream);
+		snd_pcm_stream_lock(sai->substream);
+		snd_pcm_stop(sai->substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock(sai->substream);
 	}
 
 	return IRQ_HANDLED;
-- 
1.9.1
