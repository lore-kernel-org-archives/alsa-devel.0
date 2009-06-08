From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: Coalesce power updates for PGAs
Date: Mon,  8 Jun 2009 15:28:52 +0100
Message-ID: <1244471333-6485-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D885D2445B
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:28:57 +0200 (CEST)
In-Reply-To: <20090608142734.GA6137@rakim.wolfsonmicro.main>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Handle gain ramping for PGAs so we can coalesce their power updates too.
This is not ideal since we can't cope properly with gain ramping for
stereo paths but that was the case without coalescing and gain ramping
is relatively infrequently used so the effects are limited.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3fc791c..7299ce4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -786,6 +786,10 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 				pr_err("%s: pre event failed: %d\n",
 				       w->name, ret);
 		}
+
+		/* Lower PGA volume to reduce pops */
+		if (w->id == snd_soc_dapm_pga && !w->power)
+			dapm_set_pga(w, w->power);
 	}
 
 	if (reg >= 0) {
@@ -797,6 +801,10 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 	}
 
 	list_for_each_entry(w, pending, power_list) {
+		/* Raise PGA volume to reduce pops */
+		if (w->id == snd_soc_dapm_pga && w->power)
+			dapm_set_pga(w, w->power);
+
 		/* power up post event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
@@ -886,8 +894,6 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
 		case snd_soc_dapm_line:
 		case snd_soc_dapm_spk:
 			/* No register support currently */
-		case snd_soc_dapm_pga:
-			/* Don't coalsece these yet due to gain ramping */
 			ret = dapm_generic_apply_power(w);
 			break;
 
-- 
1.6.3.1
