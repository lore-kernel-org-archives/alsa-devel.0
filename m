From: libin.yang@intel.com
Subject: [RFC PATCH] ASoC: codec: hdac_hdmi: no checking
	monitor in hw_params
Date: Mon,  6 May 2019 14:59:20 +0800
Message-ID: <1557125960-29353-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8467F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 09:18:47 +0200 (CEST)
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
Cc: Libin Yang <libin.yang@intel.com>, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, samreen.nilofer@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch move the check of monitor from hw_params to trigger callback.

The original code will check the monitor presence in hw_params. If the
monitor doesn't exist, hw_params will return -ENODEV. Mostly this is OK.

However, pulseaudio will check the pcm devices when kernel is booting up.
It will try to open, set hw_params, prepare such pcm devices. We can't
guarantee that the monitor will be connected when kernel is booting up.
Especially, hdac_hdmi will export 3 pcms at most. It's hard to say users
will connect 3 monitors to the HDMI/DP ports. This will cause pulseaudio
fail in parsing the pcm devices because the driver will return -ENODEV in
hw_params.

This patch tries to move the check of monitor presence into trigger
callback. This can "trick" the pulseaudio the pcm is ready.

This bug is found when we try to enable HDMI detection in
gnome-sound-setting for ASoC hdac_hdmi. After we enable the hdmi in UCM,
pulseaudio will try to parse the hdmi pcm devices. It will cause failure if
there are no monitors connected.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4de1fbf..f482e09 100644
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
@@ -630,6 +617,36 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 		dai_map->port = NULL;
 }
 
+static int hdac_hdmi_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
+				 struct snd_soc_dai *dai)
+{
+	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_dai_port_map *dai_map;
+	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = hdmi->hdev;
+
+	/*
+	 * When start, if there is no monitor,
+	 * It should not start audio.
+	 */
+	if (cmd == SNDRV_PCM_TRIGGER_START) {
+		dai_map = &hdmi->dai_map[dai->id];
+		port = dai_map->port;
+
+		if (!port)
+			return -ENODEV;
+
+		if ((!port->eld.monitor_present) || (!port->eld.eld_valid)) {
+			dev_err(&hdev->dev,
+				"device is not configured for this pin:port%d:%d\n",
+				port->pin->nid, port->id);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
 static int
 hdac_hdmi_query_cvt_params(struct hdac_device *hdev, struct hdac_hdmi_cvt *cvt)
 {
@@ -1389,6 +1406,7 @@ static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup = hdac_hdmi_pcm_open,
 	.shutdown = hdac_hdmi_pcm_close,
 	.hw_params = hdac_hdmi_set_hw_params,
+	.trigger = hdac_hdmi_pcm_trigger,
 	.set_tdm_slot = hdac_hdmi_set_tdm_slot,
 };
 
-- 
2.7.4
