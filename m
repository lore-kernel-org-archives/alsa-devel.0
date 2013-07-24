From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: dapm: Pass snd_soc_card directly to
	soc_dpcm_runtime_update()
Date: Wed, 24 Jul 2013 15:27:36 +0200
Message-ID: <1374672459-5202-2-git-send-email-lars@metafoo.de>
References: <1374672459-5202-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 94A4026535D
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:26:55 +0200 (CEST)
In-Reply-To: <1374672459-5202-1-git-send-email-lars@metafoo.de>
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
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <Andreas.Irestal@axis.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Hebbar Gururaja <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

soc_dpcm_runtime_update() operates on a ASoC card as a whole. Currently it takes
a snd_soc_dapm_widget as its only parameter though. The widget is then used to
look up the card and is otherwise unused. This patch changes the function to
take a pointer to the card directly. This makes it possible to to call
soc_dpcm_runtime_update() for updates which are not related to one specific
widget.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dpcm.h |  2 +-
 sound/soc/soc-dapm.c     |  4 ++--
 sound/soc/soc-pcm.c      | 10 +---------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 04598f1..047d657 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -133,6 +133,6 @@ void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
 /* internal use only */
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
 int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
-int soc_dpcm_runtime_update(struct snd_soc_dapm_widget *);
+int soc_dpcm_runtime_update(struct snd_soc_card *);
 
 #endif
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4097a55..db531f9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1956,7 +1956,7 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	ret = soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
-		soc_dpcm_runtime_update(widget);
+		soc_dpcm_runtime_update(card);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
@@ -2002,7 +2002,7 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	ret = soc_dapm_mixer_update_power(widget, kcontrol, connect);
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
-		soc_dpcm_runtime_update(widget);
+		soc_dpcm_runtime_update(card);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f4f68cb..fb70fbe 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1833,18 +1833,10 @@ static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
 /* Called by DAPM mixer/mux changes to update audio routing between PCMs and
  * any DAI links.
  */
-int soc_dpcm_runtime_update(struct snd_soc_dapm_widget *widget)
+int soc_dpcm_runtime_update(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card;
 	int i, old, new, paths;
 
-	if (widget->codec)
-		card = widget->codec->card;
-	else if (widget->platform)
-		card = widget->platform->card;
-	else
-		return -EINVAL;
-
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dapm_widget_list *list;
-- 
1.8.0
