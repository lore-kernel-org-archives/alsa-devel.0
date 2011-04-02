From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 2/2] ASoC: rename dapm_generic_apply_power()
Date: Sat,  2 Apr 2011 15:23:36 +0800
Message-ID: <1301729016-355-2-git-send-email-guanqun.lu@intel.com>
References: <1301729016-355-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C1A11037FC
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 09:23:29 +0200 (CEST)
In-Reply-To: <1301729016-355-1-git-send-email-guanqun.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Lu Guanqun <guanqun.lu@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

dapm_generic_apply_power() is only called in dapm_seq_run() when w->id is
snd_soc_dapm_{input|output|hp|line|mic}. So, it's not a generic function at
all, we better rename it to reflect what it's doing.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-dapm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d511bbe..9b7ac3f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -605,10 +605,10 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(dapm_reg_event);
 
-/* Standard power change method, used to apply power changes to most
- * widgets.
+/*
+ * power change method, used for input, output, hp, line, spk, mic.
  */
-static int dapm_generic_apply_power(struct snd_soc_dapm_widget *w)
+static int dapm_input_output_apply_power(struct snd_soc_dapm_widget *w)
 {
 	int ret;
 
@@ -947,7 +947,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 		case snd_soc_dapm_line:
 		case snd_soc_dapm_spk:
 			/* No register support currently */
-			ret = dapm_generic_apply_power(w);
+			ret = dapm_input_output_apply_power(w);
 			break;
 
 		default:
-- 
1.7.2.3
