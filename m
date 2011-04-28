From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: Fix cards getting stuck in a powered
	state.
Date: Thu, 28 Apr 2011 18:46:07 +0200
Message-ID: <1304009173-5786-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-163.synserver.de
	[212.40.185.163])
	by alsa0.perex.cz (Postfix) with SMTP id 7B36D10381F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:46:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 52ba67bf(ASoC: Force all DAPM contexts into the same bias state) changed
dapm_power_widgets to power up all DAPM contexts if at least one context is
powered. As a side-effect of this change it is possible, that a card is not
powered down again although non of it's DAPM contexts should be powered.

This problem can arise if the card contains at least one widget-less DAPM
context.
As opposed to other DAPM contexts the power state for widget-less contexts is
not reset at the beginning of dapm_power_widgets, so once such a context is
powered it stays powered and keeps the whole card in a powered state with it.
For widget-less codec DAPM contexts it is possible to recover from this
situation by sending a dapm_stream_event. Since non-codec DAPM contexts (for
example card contexts) do not receive stream events, cards containing such
contexts will get stuck in powered state indefinitely.
This is currently the case for most cards where the card's DAPM context itself
is widget-less.
If there is more then one widget-less context the card will stay powered
indefinitely as well, since it is not possible to send stream events to two DAPM
contexts at once.

This patch modifies dapm_power_widgets to iterate over all widget-less DAPM
contexts, instead of just looking at the current DAPM context, and if that
context has a codec assigned it looks at the codec state.
If the codec is active and not suspended it is assumed that the context should
be powered.
Otherwise it is assumed that the context does not have to be powered.

As before, if at least one DAPM context should be powered all other contexts are
power as well, to keep all context in the same bias state.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c |   51 +++++++++++++------------------------------------
 1 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 378f08a..3f2e360 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1025,13 +1025,10 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	LIST_HEAD(down_list);
 	LIST_HEAD(async_domain);
 	int power;
+	int power_card = 0;
 
 	trace_snd_soc_dapm_start(card);
 
-	list_for_each_entry(d, &card->dapm_list, list)
-		if (d->n_widgets)
-			d->dev_power = 0;
-
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
@@ -1053,7 +1050,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			else
 				power = 1;
 			if (power)
-				w->dapm->dev_power = 1;
+				power_card = 1;
 
 			if (w->power == power)
 				continue;
@@ -1070,45 +1067,25 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
-	/* If there are no DAPM widgets then try to figure out power from the
-	 * event type.
+	/* If we have not found a DAPM context yet, which should be powered,
+	 * iterate over all widget-less DAPM codec contexts and try to figure
+	 * out whether it should be powered from the codec state.
 	 */
-	if (!dapm->n_widgets) {
-		switch (event) {
-		case SND_SOC_DAPM_STREAM_START:
-		case SND_SOC_DAPM_STREAM_RESUME:
-			dapm->dev_power = 1;
-			break;
-		case SND_SOC_DAPM_STREAM_STOP:
-			dapm->dev_power = !!dapm->codec->active;
-			break;
-		case SND_SOC_DAPM_STREAM_SUSPEND:
-			dapm->dev_power = 0;
-			break;
-		case SND_SOC_DAPM_STREAM_NOP:
-			switch (dapm->bias_level) {
-				case SND_SOC_BIAS_STANDBY:
-				case SND_SOC_BIAS_OFF:
-					dapm->dev_power = 0;
-					break;
-				default:
-					dapm->dev_power = 1;
-					break;
+	if (!power_card) {
+		list_for_each_entry(d, &card->dapm_list, list) {
+			if (d->n_widgets || !d->codec)
+				continue;
+
+			if (d->codec->active && !d->codec->suspended) {
+				power_card = 1;
+				break;
 			}
-			break;
-		default:
-			break;
 		}
 	}
 
 	/* Force all contexts in the card to the same bias state */
-	power = 0;
 	list_for_each_entry(d, &card->dapm_list, list)
-		if (d->dev_power)
-			power = 1;
-	list_for_each_entry(d, &card->dapm_list, list)
-		d->dev_power = power;
-
+		d->dev_power = power_card;
 
 	/* Run all the bias changes in parallel */
 	list_for_each_entry(d, &dapm->card->dapm_list, list)
-- 
1.7.2.5
