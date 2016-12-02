From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Add pre & post suspend calls in
	bxt machine
Date: Fri,  2 Dec 2016 15:33:44 +0530
Message-ID: <1480673024-28608-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F95B267783
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 10:54:07 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

We need to disable jack detection before entering suspend and
enable it after resume.

This was essential as headphone jack widget will always
remain ON if a jack is inserted and this results in no audio
after system resumes from a suspend.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 1309405b3808..b272b72e6a77 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -432,6 +432,33 @@ static int bxt_fe_startup(struct snd_pcm_substream *substream)
 	},
 };
 
+static int bxt_suspend_pre(struct snd_soc_card *card)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
+			rt298_mic_detect(codec, NULL);
+			break;
+		}
+	}
+	return 0;
+}
+
+static int bxt_resume_post(struct snd_soc_card *card)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
+			rt298_mic_detect(codec, &broxton_headset);
+			break;
+		}
+	}
+	return 0;
+}
+
+
 /* broxton audio machine driver for SPT + RT298S */
 static struct snd_soc_card broxton_rt298 = {
 	.name = "broxton-rt298",
@@ -445,6 +472,9 @@ static int bxt_fe_startup(struct snd_pcm_substream *substream)
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.suspend_pre = bxt_suspend_pre,
+	.resume_post = bxt_resume_post,
+
 };
 
 static int broxton_audio_probe(struct platform_device *pdev)
-- 
1.9.1
