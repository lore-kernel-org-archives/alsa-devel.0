From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] ASoC: Move call to
	snd_soc_dapm_new_widgets() after snd_soc_dapm_auto_nc_codec_pins()
Date: Tue, 27 Aug 2013 15:51:00 +0200
Message-ID: <1377611461-3638-7-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D1D0260865
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:39 +0200 (CEST)
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

Call snd_soc_dapm_new_widgets() before the auto non-connected pins have been
marked as not connected will power the system under the assumption that those
pins are connected. Once the pins have been marked as disconnected the system
there will be an additional power run. This can cause unnecessary power
transitions. Calling snd_soc_dapm_new_widgets() only after the pins have been
marked as non-connected avoids this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aef5e8c..c3c4906 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1816,12 +1816,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
-	snd_soc_dapm_new_widgets(&card->dapm);
-
 	if (card->fully_routed)
 		list_for_each_entry(codec, &card->codec_dev_list, card_list)
 			snd_soc_dapm_auto_nc_codec_pins(codec);
 
+	snd_soc_dapm_new_widgets(&card->dapm);
+
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: failed to register soundcard %d\n",
-- 
1.8.0
