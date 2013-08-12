From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Don't create routes when creating
	kcontrols
Date: Mon, 12 Aug 2013 23:38:28 +0100
Message-ID: <1376347108-23482-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1535B265019
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 00:38:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Attempting to create the route as part of adding a mux control causes us
to attempt to add the same route twice since we loop over all sources
for the mux after creating the control. Instead do the addition in the
callers.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-dapm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 662a904..b78eaa1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -665,7 +665,7 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
  * create it. Either way, add the widget into the control's widget list
  */
 static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
-	int kci, struct snd_soc_dapm_path *path)
+	int kci)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_card *card = dapm->card->snd_card;
@@ -766,7 +766,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 		return ret;
 
 	w->kcontrols[kci] = kcontrol;
-	dapm_kcontrol_add_path(kcontrol, path);
 
 	return 0;
 }
@@ -790,9 +789,11 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				continue;
 			}
 
-			ret = dapm_create_or_share_mixmux_kcontrol(w, i, path);
+			ret = dapm_create_or_share_mixmux_kcontrol(w, i);
 			if (ret < 0)
 				return ret;
+
+			dapm_kcontrol_add_path(w->kcontrols[i], path);
 		}
 	}
 
@@ -821,7 +822,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	path = list_first_entry(&w->sources, struct snd_soc_dapm_path,
 				list_sink);
 
-	ret = dapm_create_or_share_mixmux_kcontrol(w, 0, path);
+	ret = dapm_create_or_share_mixmux_kcontrol(w, 0);
 	if (ret < 0)
 		return ret;
 
-- 
1.8.4.rc1
