From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: Update the rtd query
Date: Fri, 20 Nov 2015 22:34:41 +0530
Message-ID: <1448039081-772-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A938265342
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 18:01:23 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

sound card rtd was an array and was updated to a list so update
the driver to use a list

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 3f5a96b585b8..65c65d4c422c 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -35,12 +35,10 @@ static struct snd_soc_card skylake_audio_card;
 
 static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
 {
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 
-		rtd = card->rtd + i;
 		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
 			     strlen(SKL_NUVOTON_CODEC_DAI)))
 			return rtd->codec_dai;
-- 
1.9.1
