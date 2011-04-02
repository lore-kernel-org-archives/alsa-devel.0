From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/2] ASoC: remove dapm_update_bits()
Date: Sat,  2 Apr 2011 15:23:35 +0800
Message-ID: <1301729016-355-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 42ED51037F2
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 09:23:29 +0200 (CEST)
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

dapm_update_bits() is only called in dapm_generic_apply_power().  And in turn,
dapm_generic_apply_power() is only called in dapm_seq_run() when w->id is
snd_soc_dapm_{input|output|hp|line|mic}. Under these cases, dapm_update_bits()
is rather useless, because the below tests are always true:
        /* check for valid widgets */
        if (widget->reg < 0 || widget->id == snd_soc_dapm_input ||
                widget->id == snd_soc_dapm_output ||
                widget->id == snd_soc_dapm_hp ||
                widget->id == snd_soc_dapm_mic ||
                widget->id == snd_soc_dapm_line ||
                widget->id == snd_soc_dapm_spk)
                return 0;
Therefore, we better omit this function for simplicity.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-dapm.c |   41 -----------------------------------------
 1 files changed, 0 insertions(+), 41 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 81c4052..d511bbe 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -322,45 +322,6 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	return -ENODEV;
 }
 
-/* update dapm codec register bits */
-static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
-{
-	int change, power;
-	unsigned int old, new;
-	struct snd_soc_codec *codec = widget->codec;
-	struct snd_soc_dapm_context *dapm = widget->dapm;
-	struct snd_soc_card *card = dapm->card;
-
-	/* check for valid widgets */
-	if (widget->reg < 0 || widget->id == snd_soc_dapm_input ||
-		widget->id == snd_soc_dapm_output ||
-		widget->id == snd_soc_dapm_hp ||
-		widget->id == snd_soc_dapm_mic ||
-		widget->id == snd_soc_dapm_line ||
-		widget->id == snd_soc_dapm_spk)
-		return 0;
-
-	power = widget->power;
-	if (widget->invert)
-		power = (power ? 0:1);
-
-	old = snd_soc_read(codec, widget->reg);
-	new = (old & ~(0x1 << widget->shift)) | (power << widget->shift);
-
-	change = old != new;
-	if (change) {
-		pop_dbg(dapm->dev, card->pop_time,
-			"pop test %s : %s in %d ms\n",
-			widget->name, widget->power ? "on" : "off",
-			card->pop_time);
-		pop_wait(card->pop_time);
-		snd_soc_write(codec, widget->reg, new);
-	}
-	dev_dbg(dapm->dev, "reg %x old %x new %x change %d\n", widget->reg,
-		old, new, change);
-	return change;
-}
-
 /* create new dapm mixer control */
 static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
@@ -673,8 +634,6 @@ static int dapm_generic_apply_power(struct snd_soc_dapm_widget *w)
 			return ret;
 	}
 
-	dapm_update_bits(w);
-
 	/* power up post event */
 	if (w->power && w->event &&
 	    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-- 
1.7.2.3
