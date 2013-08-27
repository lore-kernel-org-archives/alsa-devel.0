From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] ASoC: Pass card instead of dapm context to
	snd_soc_dapm_new_widgets()
Date: Tue, 27 Aug 2013 15:51:01 +0200
Message-ID: <1377611461-3638-8-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEDC265104
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:40 +0200 (CEST)
In-Reply-To: <1377611461-3638-1-git-send-email-lars@metafoo.de>
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

snd_soc_dapm_new_widgets() works on the ASoC card as a whole not on a specific
DAPM context. The DAPM context that is passed as the parameter is only used to
look up the pointer to the card. This patch updates the signature of
snd_soc_dapm_new_widgets() to take the card directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 2 +-
 sound/soc/soc-core.c     | 2 +-
 sound/soc/soc-dapm.c     | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c728d28..27a72d5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -413,7 +413,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 			 struct snd_soc_dapm_widget *sink);
 
 /* dapm path setup */
-int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
+int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c3c4906..7d13c4f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1820,7 +1820,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		list_for_each_entry(codec, &card->codec_dev_list, card_list)
 			snd_soc_dapm_auto_nc_codec_pins(codec);
 
-	snd_soc_dapm_new_widgets(&card->dapm);
+	snd_soc_dapm_new_widgets(card);
 
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e9afbc4..548b1c9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2712,9 +2712,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_weak_routes);
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
+int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 	unsigned int val;
 
-- 
1.8.0
