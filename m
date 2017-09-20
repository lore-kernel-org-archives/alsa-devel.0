From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RESEND 2/3] ASoC: Intel: cht_bsw_rt5672: use
	actual HID in suspend/resume
Date: Tue, 19 Sep 2017 19:34:52 -0500
Message-ID: <20170920003453.16209-3-pierre-louis.bossart@linux.intel.com>
References: <20170920003453.16209-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 93D36267233
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 02:35:04 +0200 (CEST)
In-Reply-To: <20170920003453.16209-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The code scans all components looking for the default name
i2c-10EC5670:00, which of course doesn't work in platforms
where the BIOS uses a different HID such as Dell 5585

Since we already have the correct information available, just
use the actual codec name and length.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index a0e60bc1f84f..5b1e3ee965a7 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -347,9 +347,11 @@ static struct snd_soc_dai_link cht_dailink[] = {
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
@@ -363,9 +365,11 @@ static int cht_suspend_pre(struct snd_soc_card *card)
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
2.11.0
