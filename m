From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/6] ASoC: davinci-mcasp: Active slots depend
	on active serializers
Date: Mon, 10 Nov 2014 12:32:17 +0200
Message-ID: <1415615540-28981-4-git-send-email-peter.ujfalusi@ti.com>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D202614E0
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:32:32 +0100 (CET)
In-Reply-To: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Active slots count depends on the number of channels in the stream
and the number of active serializers. Each serializer will handle
at most the number of channels specified via 'tdm-slots' parameter
in DT.

There are two possible scenarios:

- Single serializer: channel count fits in the max slots supported by
  McASP serializers, active slots is same as channel count

- Multiple serializers: channel count is bigger than max slots supported
  by a serializer. Channel count determines how many serializers are
  needed at their max slot count configuration

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 10ae75e19d99..a9822c7bbb0b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -629,13 +629,29 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	return 0;
 }
 
-static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
+static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
+			      int channels)
 {
 	int i, active_slots;
+	int total_slots;
+	int active_serializers;
 	u32 mask = 0;
 	u32 busel = 0;
 
-	active_slots = mcasp->tdm_slots;
+	total_slots = mcasp->tdm_slots;
+
+	/*
+	 * If more than one serializer is needed, then use them with
+	 * their specified tdm_slots count. Otherwise, one serializer
+	 * can cope with the transaction using as many slots as channels
+	 * in the stream, requires channels symmetry
+	 */
+	active_serializers = (channels + total_slots - 1) / total_slots;
+	if (active_serializers == 1)
+		active_slots = channels;
+	else
+		active_slots = total_slots;
+
 	for (i = 0; i < active_slots; i++)
 		mask |= (1 << i);
 
@@ -647,12 +663,12 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXTDM_REG, mask);
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, busel | TXORD);
 	mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
-		       FSXMOD(active_slots), FSXMOD(0x1FF));
+		       FSXMOD(total_slots), FSXMOD(0x1FF));
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXTDM_REG, mask);
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
 	mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
-		       FSRMOD(active_slots), FSRMOD(0x1FF));
+		       FSRMOD(total_slots), FSRMOD(0x1FF));
 
 	return 0;
 }
@@ -766,7 +782,8 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		ret = mcasp_dit_hw_param(mcasp, params_rate(params));
 	else
-		ret = mcasp_i2s_hw_param(mcasp, substream->stream);
+		ret = mcasp_i2s_hw_param(mcasp, substream->stream,
+					 channels);
 
 	if (ret)
 		return ret;
-- 
2.1.3
