From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 3/4] ASoC: core: add optional pcm_new
	callback for DAI driver
Date: Mon, 19 Dec 2016 12:08:45 +0100
Message-ID: <1482145726-16782-4-git-send-email-arnaud.pouliquen@st.com>
References: <1482145726-16782-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id C09B1266BC9
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 12:09:14 +0100 (CET)
In-Reply-To: <1482145726-16782-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

During probe, DAIs can need to perform some actions that request
the knowledge of the pcm runtime handle.
The callback is called during DAIs linking, after PCM device creation.
For instance this can be used to add relationship between a DAI pcm
control and the pcm device.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/soc-dai.h |  3 +++
 sound/soc/soc-core.c    | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..1c8b579 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -231,6 +231,9 @@ struct snd_soc_dai_driver {
 	int (*resume)(struct snd_soc_dai *dai);
 	/* compress dai */
 	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
+	/* Optional Callback used at pcm creation*/
+	int (*pcm_new)(struct snd_soc_pcm_runtime *rtd,
+		       struct snd_soc_dai *dai);
 	/* DAI is also used for the control bus */
 	bool bus_control;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd9..b8c5813 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1552,6 +1552,27 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 	return 0;
 }
 
+static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
+				struct snd_soc_pcm_runtime *rtd)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < num_dais; ++i) {
+		struct snd_soc_dai_driver *drv = dais[i]->driver;
+
+		if (!rtd->dai_link->no_pcm && drv->pcm_new)
+			ret = drv->pcm_new(rtd, dais[i]);
+		if (ret < 0) {
+			dev_err(dais[i]->dev,
+				"ASoC: Failed to bind %s with pcm device\n",
+				dais[i]->name);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int soc_link_dai_widgets(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link,
 				struct snd_soc_pcm_runtime *rtd)
@@ -1663,6 +1684,13 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 				       dai_link->stream_name, ret);
 				return ret;
 			}
+			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
+			if (ret < 0)
+				return ret;
+			ret = soc_link_dai_pcm_new(rtd->codec_dais,
+						   rtd->num_codecs, rtd);
+			if (ret < 0)
+				return ret;
 		} else {
 			INIT_DELAYED_WORK(&rtd->delayed_work,
 						codec2codec_close_delayed_work);
-- 
1.9.1
