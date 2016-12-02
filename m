From: jeeja.kp@intel.com
Subject: [PATCH 12/12] ASoC: hdac_hdmi: Enable pin and
	converter in prepare
Date: Fri,  2 Dec 2016 23:11:49 +0530
Message-ID: <1480700509-23380-13-git-send-email-jeeja.kp@intel.com>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 38876267814
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 18:32:27 +0100 (CET)
In-Reply-To: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Sachin Mokashi <sachinx.mokashi@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Instead of enabling pin and cvt in pcm_open(), need to restore pin and
cvt state after system resume to restart the playback which is
paused/stopped before system suspend.
So enable pin and cvt in playback_prepare and call prepare when trigger
cmd is paused/started and resume to reconfigure pin and cvt.

Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c602c49..8d47505 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -114,6 +114,12 @@ struct hdac_hdmi_priv {
 	struct hdac_chmap chmap;
 };
 
+static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
+			struct hdac_hdmi_dai_pin_map *dai_map);
+
+static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
+			struct hdac_hdmi_dai_pin_map *dai_map);
+
 static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 						int pcm_idx)
 {
@@ -411,6 +417,10 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
+	hdac_hdmi_enable_cvt(hdac, dai_map);
+	ret = hdac_hdmi_enable_pin(hdac, dai_map);
+	if (ret < 0)
+		return ret;
 	mutex_lock(&pin->lock);
 	pin->channels = substream->runtime->channels;
 
@@ -622,11 +632,6 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map->pin = pin;
 
-	hdac_hdmi_enable_cvt(hdac, dai_map);
-	ret = hdac_hdmi_enable_pin(hdac, dai_map);
-	if (ret < 0)
-		return ret;
-
 	ret = hdac_hdmi_eld_limit_formats(substream->runtime,
 				pin->eld.eld_buffer);
 	if (ret < 0)
@@ -642,15 +647,16 @@ static int hdac_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct hdac_hdmi_dai_pin_map *dai_map;
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	int ret;
 
 	dai_map = &hdmi->dai_map[dai->id];
-	if (cmd == SNDRV_PCM_TRIGGER_RESUME) {
-		ret = hdac_hdmi_enable_pin(hdac, dai_map);
-		if (ret < 0)
-			return ret;
-
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		return hdac_hdmi_playback_prepare(substream, dai);
+
+	default:
+		return 0;
 	}
 
 	return 0;
-- 
2.5.0
