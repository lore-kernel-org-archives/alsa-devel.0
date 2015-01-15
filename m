From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: set the same format for dac and
	adc
Date: Thu, 15 Jan 2015 10:49:25 +0800
Message-ID: <1421290165-20724-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (60-248-182-7.hinet-ip.hinet.net
 [60.248.182.7]) by alsa0.perex.cz (Postfix) with ESMTP id 57A1B2605D3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 03:51:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, flove@realtek.com, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

There is only one I2S I/F, AD/DA path must operate to the same
format.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 2cd4fe4..1d1c7f8 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -861,10 +861,8 @@ static int rt286_hw_params(struct snd_pcm_substream *substream,
 		RT286_I2S_CTRL1, 0x0018, d_len_code << 3);
 	dev_dbg(codec->dev, "format val = 0x%x\n", val);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_update_bits(codec, RT286_DAC_FORMAT, 0x407f, val);
-	else
-		snd_soc_update_bits(codec, RT286_ADC_FORMAT, 0x407f, val);
+	snd_soc_update_bits(codec, RT286_DAC_FORMAT, 0x407f, val);
+	snd_soc_update_bits(codec, RT286_ADC_FORMAT, 0x407f, val);
 
 	return 0;
 }
-- 
1.8.1.1.439.g50a6b54
