From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] ASoC: dapm: Rename
	soc_widget_update_bits_locked() to soc_widget_update_bits()
Date: Sat, 19 Apr 2014 10:44:01 +0200
Message-ID: <1397897042-20092-7-git-send-email-lars@metafoo.de>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-120.synserver.de
 [212.40.185.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D56CE261A96
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 10:44:14 +0200 (CEST)
In-Reply-To: <1397897042-20092-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sven Brandau <brandau@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

There is no unlocked version of soc_widget_update_bits_locked() and there is no
plan to introduce it in the near future, so drop the _locked suffix.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 85a594f..a2475e1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -383,7 +383,7 @@ static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
 	return snd_soc_component_read(w->dapm->component, reg, value);
 }
 
-static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
+static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
 	int reg, unsigned int mask, unsigned int value)
 {
 	if (!w->dapm->component)
@@ -1070,7 +1070,7 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 	else
 		val = w->off_val;
 
-	soc_widget_update_bits_locked(w, -(w->reg + 1),
+	soc_widget_update_bits(w, -(w->reg + 1),
 			    w->mask << w->shift, val << w->shift);
 
 	return 0;
@@ -1366,7 +1366,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
-		soc_widget_update_bits_locked(w, reg, mask, value);
+		soc_widget_update_bits(w, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
@@ -1512,8 +1512,7 @@ static void dapm_widget_update(struct snd_soc_card *card)
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
