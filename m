From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Explicitly say registerless widgets have
	no register
Date: Wed, 23 Mar 2011 20:46:22 +0000
Message-ID: <1300913182-29896-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6EFE4103806
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 21:46:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This stops code that handles widgets generically from attempting to access
registers for these widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 979ed84..ddc2b3d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -45,25 +45,25 @@
 /* platform domain */
 #define SND_SOC_DAPM_INPUT(wname) \
 {	.id = snd_soc_dapm_input, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0}
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_OUTPUT(wname) \
 {	.id = snd_soc_dapm_output, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0}
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_MIC(wname, wevent) \
 {	.id = snd_soc_dapm_mic, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
 #define SND_SOC_DAPM_HP(wname, wevent) \
 {	.id = snd_soc_dapm_hp, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_SPK(wname, wevent) \
 {	.id = snd_soc_dapm_spk, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_LINE(wname, wevent) \
 {	.id = snd_soc_dapm_line, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD}
 
 /* path domain */
@@ -189,11 +189,11 @@
 /* events that are pre and post DAPM */
 #define SND_SOC_DAPM_PRE(wname, wevent) \
 {	.id = snd_soc_dapm_pre, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD}
 #define SND_SOC_DAPM_POST(wname, wevent) \
 {	.id = snd_soc_dapm_post, .name = wname, .kcontrols = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM, .event = wevent, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD}
 
 /* stream domain */
-- 
1.7.4.1
