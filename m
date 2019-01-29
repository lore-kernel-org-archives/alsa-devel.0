From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: soc-core: clear platform pointers on
	error
Date: Tue, 29 Jan 2019 13:47:09 -0800
Message-ID: <20190129214710.135124-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FFDD2674B9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 22:47:20 +0100 (CET)
Received: by mail-oi1-f197.google.com with SMTP id e185so11266130oih.18
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 13:47:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Curtis Malainey <cujomalainey@chromium.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Originally snd_soc_init_platform was not cleaning up its pointers, this
was fixed to always reallocate dynamic memory but created a memory leak
when snd_soc_init_platform was called multiple times during the same
probe attempt and also threw away any changes made to the struct between
calls. In order to avoid reallocating memory that is still valid, the
behaviour will be changed to clear the dynamically set pointers on a
probe error and a unregister event and snd_soc_init_platform will go
back to its original behaviour of only allocating null pointers so it will
stop throwing away valid changes.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/soc-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d6b5edba8d2d..9431dd605103 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1053,7 +1053,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	 *	soc.h :: struct snd_soc_dai_link
 	 */
 	/* convert Legacy platform link */
-	if (!platform || dai_link->legacy_platform) {
+	if (!platform) {
 		platform = devm_kzalloc(card->dev,
 				sizeof(struct snd_soc_dai_link_component),
 				GFP_KERNEL);
@@ -1076,6 +1076,24 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	return 0;
 }
 
+static void soc_cleanup_platform(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link;
+	int i;
+	/*
+	 * FIXME
+	 *
+	 * this function should be removed with snd_soc_init_platform
+	 */
+
+	for_each_card_prelinks(card, i, link) {
+		if (link->legacy_platform) {
+			link->legacy_platform = 0;
+			link->platforms       = NULL;
+		}
+	}
+}
+
 static int snd_soc_init_multicodec(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *dai_link)
 {
@@ -2020,6 +2038,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
 	soc_remove_pcm_runtimes(card);
+	soc_cleanup_platform(card);
 
 	/* remove auxiliary devices */
 	soc_remove_aux_devices(card);
-- 
2.20.1.495.gaa96b0ce6b-goog
