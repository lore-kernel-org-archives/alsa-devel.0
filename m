From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: pcm3168a: Allow reconfiguration of
	tdm_slots and slot_width
Date: Mon, 12 Aug 2019 12:52:26 +0300
Message-ID: <20190812095226.18870-3-peter.ujfalusi@ti.com>
References: <20190812095226.18870-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBADDF80213
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 11:52:20 +0200 (CEST)
In-Reply-To: <20190812095226.18870-1-peter.ujfalusi@ti.com>
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

When using right_j format and the codec is slave it can support 16bit
format, but only if slot_width == 16, in the same DAI mode the 24 bit
audio can work with 24 or 32 slot_width.

Because of this, the codec and CPU needs to be reconfigured when the sample
format changes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
