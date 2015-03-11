From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add suspend_pre and resume_post
	for Braswell snd_soc_card
Date: Wed, 11 Mar 2015 11:48:33 +0800
Message-ID: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 49616265015
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 04:42:29 +0100 (CET)
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
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, yao.jin@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

On Braswell, we need to add some machine specific setting before suspend
and after resume. For example, disable/enable jack detection in codec so
use snd_soc_card suspend_pre and resume_post ops for this purpose.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 sound/soc/intel/cht_bsw_rt5672.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
index 279df4c..c41fae3 100644
--- a/sound/soc/intel/cht_bsw_rt5672.c
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -267,6 +267,35 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	},
 };
 
+static int cht_suspend_pre(struct snd_soc_card *card)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
+			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
+			rt5670_jack_suspend(codec);
+			break;
+		}
+	}
+	return 0;
+}
+
+static int cht_resume_post(struct snd_soc_card *card)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
+			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
+			rt5670_jack_resume(codec);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
 	.name = "cherrytrailcraudio",
@@ -278,6 +307,8 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.num_dapm_routes = ARRAY_SIZE(cht_audio_map),
 	.controls = cht_mc_controls,
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
+	.suspend_pre = cht_suspend_pre,
+	.resume_post = cht_resume_post,
 };
 
 static int snd_cht_mc_probe(struct platform_device *pdev)
-- 
1.9.1
