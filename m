From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Add support for sequencing within
Date: Tue, 18 Jan 2011 16:20:13 +0000
Message-ID: <1295367614-12143-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BEBA24745
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 17:20:18 +0100 (CET)
In-Reply-To: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

With larger devices there may be many widgets of the same type in series
in an audio path. Allow drivers to specify an additional level of ordering
within each widget type by adding a subsequence number to widgets and then
splitting operations on widgets so that widgets of the same type but
different sequence numbers are processed separately.  A typical example
would be a supply widget which requires that another widget be enabled
to provide power or clocking.

SND_SOC_DAPM_PGA_S() and SND_SOC_DAPM_SUPPLY_S() macros are provided
allowing this to be used with PGAs and supplies as these are the most
commonly affected widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |   13 +++++++++++++
 sound/soc/soc-dapm.c     |   11 ++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8031769..a3760c9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -157,6 +157,18 @@
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 
+/* additional sequencing control within an event type */
+#define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, wcontrols, \
+	wncontrols, wevent, wflags) \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols, \
+	.event = wevent, .event_flags = wflags, .subseq = wsubseq}
+#define SND_SOC_DAPM_SUPPLY_S(wname, wsubseq, wreg, wshift, winvert, wevent, \
+	wflags)	\
+{	.id = snd_soc_dapm_supply, .name = wname, .reg = wreg,	\
+	.shift = wshift, .invert = winvert, .event = wevent, \
+	.event_flags = wflags, .subseq = wsubseq}
+
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
@@ -450,6 +462,7 @@ struct snd_soc_dapm_widget {
 	unsigned char ext:1;			/* has external widgets */
 	unsigned char force:1;			/* force state */
 	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
+	int subseq;				/* sort within widget type */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 57e1c9f..eb7436c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -737,6 +737,12 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 
 	if (sort[a->id] != sort[b->id])
 		return sort[a->id] - sort[b->id];
+	if (a->subseq != b->subseq) {
+		if (power_up)
+			return a->subseq - b->subseq;
+		else
+			return b->subseq - a->subseq;
+	}
 	if (a->reg != b->reg)
 		return a->reg - b->reg;
 	if (a->dapm != b->dapm)
@@ -869,6 +875,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w, *n;
 	LIST_HEAD(pending);
 	int cur_sort = -1;
+	int cur_subseq = -1;
 	int cur_reg = SND_SOC_NOPM;
 	struct snd_soc_dapm_context *cur_dapm = NULL;
 	int ret;
@@ -884,12 +891,13 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 
 		/* Do we need to apply any queued changes? */
 		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
-		    w->dapm != cur_dapm) {
+		    w->dapm != cur_dapm || w->subseq != cur_subseq) {
 			if (!list_empty(&pending))
 				dapm_seq_run_coalesced(cur_dapm, &pending);
 
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
+			cur_subseq = -1;
 			cur_reg = SND_SOC_NOPM;
 			cur_dapm = NULL;
 		}
@@ -934,6 +942,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 		default:
 			/* Queue it up for application */
 			cur_sort = sort[w->id];
+			cur_subseq = w->subseq;
 			cur_reg = w->reg;
 			cur_dapm = w->dapm;
 			list_move(&w->power_list, &pending);
-- 
1.7.2.3
