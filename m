From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 8/8] ASoC: core: Add a warning for
	link_dai_widget in the multicodec case
Date: Tue,  1 Jul 2014 09:48:01 +0200
Message-ID: <1404200881-32253-9-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 769C62656FF
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:49:07 +0200 (CEST)
Received: by mail-wi0-f181.google.com with SMTP id n3so7225391wiv.8
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:49:07 -0700 (PDT)
In-Reply-To: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Multicodec links are not supported in the case of CODEC to CODEC links.
Just print a warning if it happens.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3764150..3640242 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1486,6 +1486,9 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	struct snd_soc_dapm_widget *play_w, *capture_w;
 	int ret;
 
+	if (rtd->num_codecs > 1)
+		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
+
 	/* link the DAI widgets */
 	play_w = codec_dai->playback_widget;
 	capture_w = cpu_dai->capture_widget;
-- 
1.9.1
