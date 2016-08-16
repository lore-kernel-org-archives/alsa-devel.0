From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] ASoC: dapm: Fix typo in comment
Date: Tue, 16 Aug 2016 16:56:17 +0200
Message-ID: <1471359378-9122-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 425252666FB
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 16:56:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 sound/soc/soc-dapm.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8698c26..c46b1ff 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1169,7 +1169,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
  * @custom_stop_condition: (optional) a function meant to stop the widget graph
  *                         walk based on custom logic.
  *
- * Queries DAPM graph as to whether an valid audio stream path exists for
+ * Queries DAPM graph as to whether a valid audio stream path exists for
  * the initial stream specified by name. This takes into account
  * current mixer and mux kcontrol settings. Creates list of valid widgets.
  *
@@ -1294,8 +1294,7 @@ static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 	return w->new_power;
 }
 
-/* Generic check to see if a widget should be powered.
- */
+/* Generic check to see if a widget should be powered. */
 static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 {
 	int in, out;
@@ -1646,7 +1645,7 @@ static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
 	struct snd_soc_dapm_context *d = data;
 	int ret;
 
-	/* If we're off and we're not supposed to be go into STANDBY */
+	/* If we're off and we're not supposed to go into STANDBY */
 	if (d->bias_level == SND_SOC_BIAS_OFF &&
 	    d->target_bias_level != SND_SOC_BIAS_OFF) {
 		if (d->dev)
@@ -1798,7 +1797,7 @@ static bool dapm_idle_bias_off(struct snd_soc_dapm_context *dapm)
  * A complete path is a route that has valid endpoints i.e.:-
  *
  *  o DAC to output pin.
- *  o Input Pin to ADC.
+ *  o Input pin to ADC.
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
@@ -2114,7 +2113,7 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
  * soc_dapm_connect_path() - Connects or disconnects a path
  * @path: The path to update
  * @connect: The new connect state of the path. True if the path is connected,
- *  false if it is disconneted.
+ *  false if it is disconnected.
  * @reason: The reason why the path changed (for debugging only)
  */
 static void soc_dapm_connect_path(struct snd_soc_dapm_path *path,
@@ -2233,7 +2232,7 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 		if (w->dapm != dapm)
 			continue;
 
-		/* only display widgets that burnm power */
+		/* only display widgets that burn power */
 		switch (w->id) {
 		case snd_soc_dapm_hp:
 		case snd_soc_dapm_mic:
@@ -2461,7 +2460,7 @@ static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
 
 	switch (w->id) {
 	case snd_soc_dapm_input:
-		/* On a fully routed card a input is never a source */
+		/* On a fully routed card an input is never a source */
 		if (w->dapm->card->fully_routed)
 			return;
 		ep = SND_SOC_DAPM_EP_SOURCE;
@@ -3445,7 +3444,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->endpoints[dir] = -1;
 	}
 
-	/* machine layer set ups unconnected pins and insertions */
+	/* machine layer sets up unconnected pins and insertions */
 	w->connected = 1;
 	return w;
 }
-- 
1.7.10.4
