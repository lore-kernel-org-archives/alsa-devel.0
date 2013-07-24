From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: dapm: Add a update parameter to
	snd_soc_dapm_{mux, mixer}_update_power
Date: Wed, 24 Jul 2013 15:27:38 +0200
Message-ID: <1374672459-5202-4-git-send-email-lars@metafoo.de>
References: <1374672459-5202-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 85975265370
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:26:57 +0200 (CEST)
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

In order to avoid race conditions the assignment of dapm->update should happen
while card->dapm_mutex is being held. To allow CODEC drivers to run a register
update when using snd_soc_dapm_mux_update_power() or
snd_soc_dapm_mixer_update_power() add a update parameter to these two functions.
The update parameter will be assigned to dapm->update while card->dapm_mutex is
locked.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  7 +++++--
 sound/soc/soc-dapm.c     | 10 ++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3717ad0..e77c6f5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -333,6 +333,7 @@ struct snd_soc_dapm_route;
 struct snd_soc_dapm_context;
 struct regulator;
 struct snd_soc_dapm_widget_list;
+struct snd_soc_dapm_update;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
@@ -392,9 +393,11 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* external DAPM widget events */
 int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
-		struct snd_kcontrol *kcontrol, int connect);
+		struct snd_kcontrol *kcontrol, int connect,
+		struct snd_soc_dapm_update *update);
 int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
-		struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e);
+		struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e,
+		struct snd_soc_dapm_update *update);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d511217..366daef 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1952,13 +1952,16 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 }
 
 int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
-	struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
+	struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e,
+	struct snd_soc_dapm_update *update)
 {
 	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	dapm->update = update;
 	ret = soc_dapm_mux_update_power(dapm, kcontrol, mux, e);
+	dapm->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
@@ -1992,13 +1995,16 @@ static int soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 }
 
 int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
-	struct snd_kcontrol *kcontrol, int connect)
+	struct snd_kcontrol *kcontrol, int connect,
+	struct snd_soc_dapm_update *update)
 {
 	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	dapm->update = update;
 	ret = soc_dapm_mixer_update_power(dapm, kcontrol, connect);
+	dapm->update = NULL;
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
-- 
1.8.0
