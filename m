From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Staticise dapm_mark_dirty()
Date: Thu,  6 Mar 2014 16:19:39 +0800
Message-ID: <1394093979-25623-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 731122658BA
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 09:32:32 +0100 (CET)
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

The function is not called outside soc-dapm.c so there is no need for it
to be exported.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/soc-dapm.h | 1 -
 sound/soc/soc-dapm.c     | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 04d32d8..ef78f56 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -449,7 +449,6 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 
 /* Mostly internal - should not normally be used */
-void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
 void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
 
 /* dapm path query */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0d8ba30..3728e21 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -142,7 +142,7 @@ static bool dapm_dirty_widget(struct snd_soc_dapm_widget *w)
 	return !list_empty(&w->dirty);
 }
 
-void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
+static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 {
 	if (!dapm_dirty_widget(w)) {
 		dev_vdbg(w->dapm->dev, "Marking %s dirty due to %s\n",
@@ -150,7 +150,6 @@ void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 		list_add_tail(&w->dirty, &w->dapm->card->dapm_dirty);
 	}
 }
-EXPORT_SYMBOL_GPL(dapm_mark_dirty);
 
 void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm)
 {
-- 
1.9.0
