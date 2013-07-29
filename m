From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/10] ASoC: dapm: Delay w->power update until
	the changes are written
Date: Mon, 29 Jul 2013 17:14:03 +0200
Message-ID: <1375110845-8069-9-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D51C261B03
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:19 +0200 (CEST)
In-Reply-To: <1375110845-8069-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Wait with updating the widgets power field until the changes are actually
written to the hardware in dapm_seq_run_coalesced(). This will allow us to query
the current hardware state between calling dapm_power_one_widget() and actually
writing the new power state to hardware.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b811a27..9abb3b2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -293,6 +293,7 @@ static void dapm_reset(struct snd_soc_card *card)
 	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
 
 	list_for_each_entry(w, &card->widgets, list) {
+		w->new_power = w->power;
 		w->power_checked = false;
 		w->inputs = -1;
 		w->outputs = -1;
@@ -1340,7 +1341,7 @@ static void dapm_seq_check_event(struct snd_soc_card *card,
 		return;
 	}
 
-	if (w->power != power)
+	if (w->new_power != power)
 		return;
 
 	if (w->event && (w->event_flags & event)) {
@@ -1369,6 +1370,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 
 	list_for_each_entry(w, pending, power_list) {
 		BUG_ON(reg != w->reg);
+		w->power = w->new_power;
 
 		mask |= w->mask << w->shift;
 		if (w->power)
@@ -1676,8 +1678,6 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 		dapm_seq_insert(w, up_list, true);
 	else
 		dapm_seq_insert(w, down_list, false);
-
-	w->power = power;
 }
 
 static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
@@ -1752,7 +1752,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 			break;
 		}
 
-		if (w->power) {
+		if (w->new_power) {
 			d = w->dapm;
 
 			/* Supplies and micbiases only bring the
-- 
1.8.0
