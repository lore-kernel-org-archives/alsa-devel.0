From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Sprinkle lockdep asserts through
	the code
Date: Thu,  6 Mar 2014 16:57:17 +0800
Message-ID: <1394096237-2004-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADCD12658D0
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 10:14:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Try to spot locking issues by asserting that the DAPM mutex is held when
it should be. There's a bit of fun due to us not requiring the lock to be
held prior to the card being instantiated which mean we need to wrap the
assert in some paths and this isn't methodical by any stretch of the
imagination.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

I've only compile tested this so it's entirely possible there's some
oversights here - at this point I'm mostly just throwing it out there
for people to play with as a work in progress.

 sound/soc/soc-dapm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3728e21..c8a780d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -111,6 +111,12 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_post] = 14,
 };
 
+static void dapm_assert_locked(struct snd_soc_dapm_context *dapm)
+{
+	if (dapm->card && dapm->card->instantiated)
+		lockdep_assert_held(&dapm->card->dapm_mutex);
+}
+
 static void pop_wait(u32 pop_time)
 {
 	if (pop_time)
@@ -144,6 +150,8 @@ static bool dapm_dirty_widget(struct snd_soc_dapm_widget *w)
 
 static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 {
+	dapm_assert_locked(w->dapm);
+
 	if (!dapm_dirty_widget(w)) {
 		dev_vdbg(w->dapm->dev, "Marking %s dirty due to %s\n",
 			 w->name, reason);
@@ -356,6 +364,8 @@ static void dapm_reset(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
 
+	lockdep_assert_held(&card->dapm_mutex);
+
 	memset(&card->dapm_stats, 0, sizeof(card->dapm_stats));
 
 	list_for_each_entry(w, &card->widgets, list) {
@@ -1750,6 +1760,8 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 	ASYNC_DOMAIN_EXCLUSIVE(async_domain);
 	enum snd_soc_bias_level bias;
 
+	lockdep_assert_held(&card->dapm_mutex);
+
 	trace_snd_soc_dapm_start(card);
 
 	list_for_each_entry(d, &card->dapm_list, list) {
@@ -2045,6 +2057,8 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
+	lockdep_assert_held(&card->dapm_mutex);
+
 	/* find dapm widget path assoc with kcontrol */
 	dapm_kcontrol_for_each_path(path, kcontrol) {
 		if (!path->name || !e->texts[mux])
@@ -2095,6 +2109,8 @@ static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
+	lockdep_assert_held(&card->dapm_mutex);
+
 	/* find dapm widget path assoc with kcontrol */
 	dapm_kcontrol_for_each_path(path, kcontrol) {
 		found = 1;
@@ -2260,6 +2276,8 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
 
+	dapm_assert_locked(dapm);
+
 	if (!w) {
 		dev_err(dapm->dev, "ASoC: DAPM unknown pin %s\n", pin);
 		return -EINVAL;
-- 
1.9.0
