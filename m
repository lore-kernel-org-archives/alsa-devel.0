From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: dapm: fix kcontrols for effect widgets
Date: Tue, 30 Apr 2019 18:11:34 -0500
Message-ID: <20190430231134.4471-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22B9AF896F0
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:11:39 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>

This patch adds the handling of snd_soc_dapm_effect that was missing.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 65ee0bb5dd0b..81a7a12196ff 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -883,6 +883,7 @@ static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 			case snd_soc_dapm_switch:
 			case snd_soc_dapm_mixer:
 			case snd_soc_dapm_pga:
+			case snd_soc_dapm_effect:
 			case snd_soc_dapm_out_drv:
 				wname_in_long_name = true;
 				kcname_in_long_name = true;
@@ -2370,6 +2371,7 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 		case snd_soc_dapm_dac:
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_pga:
+		case snd_soc_dapm_effect:
 		case snd_soc_dapm_out_drv:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
@@ -3197,6 +3199,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_pga:
+		case snd_soc_dapm_effect:
 		case snd_soc_dapm_out_drv:
 			dapm_new_pga(w);
 			break;
-- 
2.17.1
