From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: pcm3168a: Rename min_frame_size to
	slot_width
Date: Thu, 20 Jun 2019 12:26:55 +0300
Message-ID: <20190620092656.14759-2-peter.ujfalusi@ti.com>
References: <20190620092656.14759-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85D71F80C15
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 11:26:25 +0200 (CEST)
In-Reply-To: <20190620092656.14759-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

It represents slot size and not frame.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/pcm3168a.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index ed0b4317c9ae..861d24cc002e 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -432,7 +432,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	u32 val, mask, shift, reg;
 	unsigned int rate, fmt, ratio, max_ratio;
 	unsigned int chan;
-	int i, min_frame_size;
+	int i, slot_width;
 
 	rate = params_rate(params);
 	chan = params_channels(params);
@@ -467,11 +467,11 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
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
@@ -488,7 +488,7 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	case 32:
 		break;
 	default:
-		dev_err(component->dev, "unsupported frame size: %d\n", min_frame_size);
+		dev_err(component->dev, "unsupported frame size: %d\n", slot_width);
 		return -EINVAL;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
