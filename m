From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Get the card directly from the DAPM
	context
Date: Wed,  2 Mar 2011 19:21:07 +0000
Message-ID: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3986B10381E
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 20:20:54 +0100 (CET)
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

Rather than indirecting through the CODEC we can look the card up directly
from the card pointer in the DAPM context.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b8e6ab7..8240ab8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -368,7 +368,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	int i, ret = 0;
 	size_t name_len;
 	struct snd_soc_dapm_path *path;
-	struct snd_card *card = dapm->codec->card->snd_card;
+	struct snd_card *card = dapm->card->snd_card;
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -430,7 +430,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
-	struct snd_card *card = dapm->codec->card->snd_card;
+	struct snd_card *card = dapm->card->snd_card;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -480,7 +480,7 @@ static inline void dapm_clear_walk(struct snd_soc_dapm_context *dapm)
  */
 static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 {
-	int level = snd_power_get_state(widget->dapm->codec->card->snd_card);
+	int level = snd_power_get_state(widget->dapm->card->snd_card);
 
 	switch (level) {
 	case SNDRV_CTL_POWER_D3hot:
@@ -1083,7 +1083,7 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
  */
 static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 {
-	struct snd_soc_card *card = dapm->codec->card;
+	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
-- 
1.7.2.3
