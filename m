From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Use ASoC jack instead of
	snd_jack" to the asoc tree
Date: Thu, 16 Feb 2017 19:04:36 +0000
Message-ID: <E1ceRM4-0007bs-51@debutante>
References: <1484589477-7630-19-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AD66267094
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:44 +0100 (CET)
In-Reply-To: <1484589477-7630-19-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Use ASoC jack instead of snd_jack

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 624900163d060f15d71ff383104a909737de770c Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 7 Feb 2017 19:09:49 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Use ASoC jack instead of snd_jack

Use snd_soc_jack instead of snd_jack and create the jack in machine
driver and pass the jack pointer to hdac_hdmi driver for jack
reporting.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 19 ++++++++-----------
 sound/soc/codecs/hdac_hdmi.h |  3 ++-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f8b6e9f1c6f6..0f2c1e823281 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -102,7 +102,7 @@ struct hdac_hdmi_pcm {
 	int pcm_id;
 	struct list_head port_list;
 	struct hdac_hdmi_cvt *cvt;
-	struct snd_jack *jack;
+	struct snd_soc_jack *jack;
 	int stream_tag;
 	int channels;
 	int format;
@@ -159,7 +159,8 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 			dev_dbg(&edev->hdac.dev,
 					"jack report for pcm=%d\n",
 					pcm->pcm_id);
-			snd_jack_report(pcm->jack, SND_JACK_AVOUT);
+			snd_soc_jack_report(pcm->jack, SND_JACK_AVOUT,
+						SND_JACK_AVOUT);
 		}
 		pcm->jack_event++;
 	} else {
@@ -169,7 +170,7 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		 * to multiple ports.
 		 */
 		if (pcm->jack_event == 1)
-			snd_jack_report(pcm->jack, 0);
+			snd_soc_jack_report(pcm->jack, 0, SND_JACK_AVOUT);
 		if (pcm->jack_event > 0)
 			pcm->jack_event--;
 	}
@@ -1556,13 +1557,11 @@ static struct snd_pcm *hdac_hdmi_get_pcm_from_id(struct snd_soc_card *card,
 	return NULL;
 }
 
-int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
+int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
+				struct snd_soc_jack *jack)
 {
-	char jack_name[NAME_SIZE];
 	struct snd_soc_codec *codec = dai->codec;
 	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm =
-		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
 	struct snd_pcm *snd_pcm;
@@ -1578,6 +1577,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 	pcm->pcm_id = device;
 	pcm->cvt = hdmi->dai_map[dai->id].cvt;
 	pcm->jack_event = 0;
+	pcm->jack = jack;
 	mutex_init(&pcm->lock);
 	INIT_LIST_HEAD(&pcm->port_list);
 	snd_pcm = hdac_hdmi_get_pcm_from_id(dai->component->card, device);
@@ -1594,10 +1594,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 
 	list_add_tail(&pcm->head, &hdmi->pcm_list);
 
-	sprintf(jack_name, "HDMI/DP, pcm=%d Jack", device);
-
-	return snd_jack_new(dapm->card->snd_card, jack_name,
-		SND_JACK_AVOUT,	&pcm->jack, true, false);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
 
diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
index 8dfd1e0b57b3..bf7edb3227d2 100644
--- a/sound/soc/codecs/hdac_hdmi.h
+++ b/sound/soc/codecs/hdac_hdmi.h
@@ -1,6 +1,7 @@
 #ifndef __HDAC_HDMI_H__
 #define __HDAC_HDMI_H__
 
-int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm);
+int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
+				struct snd_soc_jack *jack);
 
 #endif /* __HDAC_HDMI_H__ */
-- 
2.11.0
