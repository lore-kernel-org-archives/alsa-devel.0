From: jeeja.kp@intel.com
Subject: [PATCH v2 03/11] ASoC: hdac_hdmi: Update sig_bits
	based on converter capability
Date: Fri, 24 Mar 2017 23:10:26 +0530
Message-ID: <1490377234-30257-4-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E49AE2674BB
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:24 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When creating the codec dai, use sig_bits to update the max bps based
on the codec capability. So both the link DMA and codec format will be
calculated based on DAI sig_bits.

So update the sig_bits with converter capability and use the sig_bits
for HDA format calculation.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 78fca8a..5b76947 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -469,7 +469,7 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 
 	format = snd_hdac_calc_stream_format(params_rate(hparams),
 			params_channels(hparams), params_format(hparams),
-			24, 0);
+			dai->driver->playback.sig_bits, 0);
 
 	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, dai_map->cvt);
 	if (!pcm)
@@ -1419,8 +1419,8 @@ static int hdac_hdmi_create_dais(struct hdac_device *hdac,
 		hdmi_dais[i].playback.rate_min = rate_min;
 		hdmi_dais[i].playback.channels_min = 2;
 		hdmi_dais[i].playback.channels_max = 2;
+		hdmi_dais[i].playback.sig_bits = bps;
 		hdmi_dais[i].ops = &hdmi_dai_ops;
-
 		i++;
 	}
 
-- 
2.5.0
