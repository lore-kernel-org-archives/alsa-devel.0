From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] [RFC]ASoC: dapm: enable kcontrols for siggen
	and effect type widgets
Date: Thu, 24 May 2018 11:37:42 -0700
Message-ID: <20180524183742.4986-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 40CC3267646
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 20:37:44 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch proposes to enable kcontrols for siggen and effect type
dapm widgets. This will allow triggering the tone generating siggen
component and also modifying the run-time attributes such as frequency,
amplitude etc. Effect type widgets such as the equalizer could
potentially need kcontrols to pass algorithm data from the userspace.

This patch also renames the function dapm_new_pga() to
dapm_new_kcontrol() so that it does not allude that it applies only
to pga widgets.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-dapm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0c0cb7713eb4..4577880f69cc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -852,6 +852,8 @@ static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 			kcname_in_long_name = true;
 		} else {
 			switch (w->id) {
+			case snd_soc_dapm_siggen:
+			case snd_soc_dapm_effect:
 			case snd_soc_dapm_switch:
 			case snd_soc_dapm_mixer:
 			case snd_soc_dapm_pga:
@@ -1010,8 +1012,8 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	return 0;
 }
 
-/* create new dapm volume control */
-static int dapm_new_pga(struct snd_soc_dapm_widget *w)
+/* create new dapm kcontrol */
+static int dapm_new_kcontrol(struct snd_soc_dapm_widget *w)
 {
 	int i, ret;
 
@@ -3046,9 +3048,11 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 		case snd_soc_dapm_demux:
 			dapm_new_mux(w);
 			break;
+		case snd_soc_dapm_siggen:
+		case snd_soc_dapm_effect:
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_out_drv:
-			dapm_new_pga(w);
+			dapm_new_kcontrol(w);
 			break;
 		case snd_soc_dapm_dai_link:
 			dapm_new_dai_link(w);
-- 
2.17.0
