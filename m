From: libin.yang@intel.com
Subject: [PATCH] ASoC: codec: hdac_hdmi: no checking monitor in
	hw_params
Date: Tue,  7 May 2019 14:33:11 +0800
Message-ID: <1557210791-20332-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7329F80726
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 08:52:38 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Libin Yang <libin.yang@intel.com>, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Some userspace apps, like pulseaudio, may call open, hw_params,
prepare to judge whether the pcm is ready or not. Current hdac_hdmi
will return -ENODEV if monitor is not connected, which will cause
the apps believe the pcm is not ready. Actually PCM for hdmi is ready,
even the monitor is not connected.

This patch removes the check of monitor presence in hw_params, just like
what the legacy HD-Audio driver does.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4de1fbf..660e058 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -455,24 +455,11 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
 {
 	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
-	struct hdac_device *hdev = hdmi->hdev;
 	struct hdac_hdmi_dai_port_map *dai_map;
-	struct hdac_hdmi_port *port;
 	struct hdac_hdmi_pcm *pcm;
 	int format;
 
 	dai_map = &hdmi->dai_map[dai->id];
-	port = dai_map->port;
-
-	if (!port)
-		return -ENODEV;
-
-	if ((!port->eld.monitor_present) || (!port->eld.eld_valid)) {
-		dev_err(&hdev->dev,
-			"device is not configured for this pin:port%d:%d\n",
-					port->pin->nid, port->id);
-		return -ENODEV;
-	}
 
 	format = snd_hdac_calc_stream_format(params_rate(hparams),
 			params_channels(hparams), params_format(hparams),
-- 
2.7.4
