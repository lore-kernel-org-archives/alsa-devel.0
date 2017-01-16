From: jeeja.kp@intel.com
Subject: [PATCH 06/30] ASoC: Intel: bxt: add channel map
	support in bxt_da7219_max98357a machine
Date: Mon, 16 Jan 2017 23:27:33 +0530
Message-ID: <1484589477-7630-7-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A732670FA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:47:16 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
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

HDMI registers channel map controls per PCM. As PCMs are not
registered during dai_link init callback, store the pcm ids and
codec DAIs during this init callback.

Register for late probe and call the jack_init API which also
registers channel map in the late probe callback handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 49 ++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index f46da61..8dfe5e8 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -34,6 +34,16 @@
 
 static struct snd_soc_jack broxton_headset;
 
+struct bxt_hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct bxt_card_private {
+	struct list_head hdmi_pcm_list;
+};
+
 enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
@@ -181,9 +191,20 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 static int broxton_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct bxt_card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct bxt_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
 
-	return hdac_hdmi_jack_init(dai, BXT_DPCM_AUDIO_HDMI1_PB + dai->id);
+	pcm->device = BXT_DPCM_AUDIO_HDMI1_PB + dai->id;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
 }
 
 static int broxton_da7219_fe_init(struct snd_soc_pcm_runtime *rtd)
@@ -531,6 +552,21 @@ static struct snd_soc_dai_link broxton_dais[] = {
 	},
 };
 
+static int bxt_card_late_probe(struct snd_soc_card *card)
+{
+	struct bxt_card_private *ctx = snd_soc_card_get_drvdata(card);
+	struct bxt_hdmi_pcm *pcm;
+	int err;
+
+	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /* broxton audio machine driver for SPT + da7219 */
 static struct snd_soc_card broxton_audio_card = {
 	.name = "bxtda7219max",
@@ -544,11 +580,22 @@ static struct snd_soc_card broxton_audio_card = {
 	.dapm_routes = broxton_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_map),
 	.fully_routed = true,
+	.late_probe = bxt_card_late_probe,
 };
 
 static int broxton_audio_probe(struct platform_device *pdev)
 {
+	struct bxt_card_private *ctx;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
 	broxton_audio_card.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
+
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
 }
 
-- 
2.5.0
