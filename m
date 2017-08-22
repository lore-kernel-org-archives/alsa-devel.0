From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/14] ASoC: Intel: cht_bsw_rt5672: use actual
	HID in suspend/resume
Date: Tue, 22 Aug 2017 15:32:38 -0500
Message-ID: <20170822203239.19891-14-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F40F92670FB
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:17 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The code scans all components looking for the default name
i2c-10EC5670:00, which of course doesn't work in platforms
where the BIOS uses a different HID such as Dell 5585

Since we already have the correct information available, just
use the actual codec name and length.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index ad2f27e..a637bb5 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -348,9 +348,11 @@ static struct snd_soc_dai_link cht_dailink[] = {
 static int cht_suspend_pre(struct snd_soc_card *card)
 {
 	struct snd_soc_component *component;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
-		if (!strcmp(component->name, "i2c-10EC5670:00")) {
+		if (!strncmp(component->name,
+			     ctx->codec_name, sizeof(ctx->codec_name))) {
 			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
@@ -364,9 +366,11 @@ static int cht_suspend_pre(struct snd_soc_card *card)
 static int cht_resume_post(struct snd_soc_card *card)
 {
 	struct snd_soc_component *component;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
-		if (!strcmp(component->name, "i2c-10EC5670:00")) {
+		if (!strncmp(component->name,
+			     ctx->codec_name, sizeof(ctx->codec_name))) {
 			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
-- 
2.9.3
