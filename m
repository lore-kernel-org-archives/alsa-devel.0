From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/13] ASoC: dapm: Rename
	soc_widget_update_bits_locked() to soc_widget_update_bits()
Date: Tue, 18 Mar 2014 09:02:16 +0100
Message-ID: <1395129736-11938-14-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 39F64261B35
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:56 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There is no unlocked version of soc_widget_update_bits_locked() and there is no
plan to introduce it in the near future, so drop the _locked suffix.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 506ee73..b7f8e9a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -384,7 +384,7 @@ static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
 	return snd_soc_component_read(w->dapm->component, reg, value);
 }
 
-static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
+static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
 	unsigned short reg, unsigned int mask, unsigned int value)
 {
 	if (!w->dapm->component)
@@ -1071,7 +1071,7 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 	else
 		val = w->off_val;
 
-	soc_widget_update_bits_locked(w, -(w->reg + 1),
+	soc_widget_update_bits(w, -(w->reg + 1),
 			    w->mask << w->shift, val << w->shift);
 
 	return 0;
@@ -1367,7 +1367,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
-		soc_widget_update_bits_locked(w, reg, mask, value);
+		soc_widget_update_bits(w, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
@@ -1513,8 +1513,7 @@ static void dapm_widget_update(struct snd_soc_card *card)
 	if (!w)
 		return;
 
-	ret = soc_widget_update_bits_locked(w, update->reg, update->mask,
-				  update->val);
+	ret = soc_widget_update_bits(w, update->reg, update->mask, update->val);
 	if (ret < 0)
 		dev_err(w->dapm->dev, "ASoC: %s DAPM update failed: %d\n",
 			w->name, ret);
-- 
1.8.0
