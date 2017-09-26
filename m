From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] ASoC: Intel: Kabylake machine driver changes
	for a FE DAI
Date: Tue, 26 Sep 2017 14:42:02 -0700
Message-ID: <1506462122-23828-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C375267140
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 23:42:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

'Kbl Audio Headset Playback' FE DAI also needs SSP hw parama fix.
Adding this dai also to be handled in kabylake_ssp_fixup() call.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 88ff542..e767283 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -302,6 +302,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
 	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
+	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
 	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
-- 
1.9.1
