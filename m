From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix TDM slot rx/tx mask
	associations
Date: Mon, 9 Nov 2015 12:19:19 -0600
Message-ID: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 71D292606CB
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 19:19:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Andreas Dannenberg <dannenberg@ti.com>
List-Id: alsa-devel@alsa-project.org

Fixes the associations between the tx_mask and rx_mask and the associated
playback / capture streams during setting of the TDM slot. With this
patch in place it is now possible for example to only populate tx_mask
(leaving rx_mask as 0) for output-only codecs to control the TDM slot(s)
the McASP serial port uses for transmit. Before that, this scenario
would incorrectly rely on the rx_mask for this.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 4495a40..caa0beb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -681,8 +681,8 @@ static int davinci_mcasp_set_tdm_slot(struct snd_soc_dai *dai,
 	}
 
 	mcasp->tdm_slots = slots;
-	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = rx_mask;
-	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = tx_mask;
+	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
 	mcasp->slot_width = slot_width;
 
 	return davinci_mcasp_set_ch_constraints(mcasp);
-- 
1.9.1
