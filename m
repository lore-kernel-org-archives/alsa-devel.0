From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 1/2] ASoC: core: allow DAI PCM controls
	bound to PCM device
Date: Mon, 28 Nov 2016 10:33:53 +0100
Message-ID: <1480325634-23320-2-git-send-email-arnaud.pouliquen@st.com>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 49792266D44
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 10:34:14 +0100 (CET)
In-Reply-To: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In case of several instances of the same PCM control (e.g IEC controls).
Application should be able to address the control using the
device field number, according to the PCM character device.
This patch allows to link DAI PCM controls to the PCM device.
During DAI_link probe, PCM controls are added after device field is forced
to the PCM device number.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/soc-dai.h |  4 ++++
 sound/soc/soc-core.c    | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..93624c9 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -247,6 +247,10 @@ struct snd_soc_dai_driver {
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
+
+	/* Optional PCM controls to bind to PCM device on DAIs link*/
+	const struct snd_kcontrol_new *pcm_controls;
+	int num_pcm_controls;
 };
 
 /*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4afa8db..ace83c9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1552,6 +1552,25 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 	return 0;
 }
 
+static int soc_link_dai_pcm_controls(struct snd_soc_dai **dais, int num_dais,
+				     struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_kcontrol_new kctl;
+	int i, j, err;
+
+	for (i = 0; i < num_dais; ++i) {
+		for (j = 0; j < dais[i]->driver->num_pcm_controls; j++) {
+			kctl = dais[i]->driver->pcm_controls[j];
+			if (!rtd->dai_link->no_pcm)
+				kctl.device = rtd->pcm->device;
+			if (snd_soc_add_dai_controls(dais[i], &kctl, 1))
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int soc_link_dai_widgets(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link,
 				struct snd_soc_pcm_runtime *rtd)
@@ -1663,6 +1682,15 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 				       dai_link->stream_name, ret);
 				return ret;
 			}
+
+			/* Bind DAIs pcm controls to the PCM device */
+			ret = soc_link_dai_pcm_controls(&cpu_dai, 1, rtd);
+			if (ret < 0)
+				return ret;
+			ret = soc_link_dai_pcm_controls(rtd->codec_dais,
+							rtd->num_codecs, rtd);
+			if (ret < 0)
+				return ret;
 		} else {
 			INIT_DELAYED_WORK(&rtd->delayed_work,
 						codec2codec_close_delayed_work);
-- 
1.9.1
