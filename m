From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: rx51: Use snd_soc_dapm_to_codec()
	instead of dapm->codec
Date: Mon, 29 Sep 2014 11:40:41 +0200
Message-ID: <1411983642-12793-2-git-send-email-lars@metafoo.de>
References: <1411983642-12793-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-039.synserver.de (smtp-out-039.synserver.de
 [212.40.185.39])
 by alsa0.perex.cz (Postfix) with ESMTP id EA1202605CB
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 11:40:32 +0200 (CEST)
In-Reply-To: <1411983642-12793-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The CODEC struct in the snd_soc_dapm_context struct is deprecated and
scheduled for removal. Use the snd_soc_dapm_to_codec() function instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/rx51.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 943922c..b10ae80 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -168,7 +168,7 @@ static int rx51_spk_event(struct snd_soc_dapm_widget *w,
 static int rx51_hp_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *k, int event)
 {
-	struct snd_soc_codec *codec = w->dapm->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		tpa6130a2_stereo_enable(codec, 1);
-- 
1.8.0
