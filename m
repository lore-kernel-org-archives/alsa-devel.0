From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: smartq: Remove unnecessary
	snd_soc_dapm_disable_pin()
Date: Sun,  3 May 2015 19:27:08 +0200
Message-ID: <1430674030-1388-3-git-send-email-lars@metafoo.de>
References: <1430674030-1388-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 204D426049B
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2015 19:27:20 +0200 (CEST)
In-Reply-To: <1430674030-1388-1-git-send-email-lars@metafoo.de>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The "Headphone Jack" widget is managed by the jack detection layer, there
is no need to manually disable.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/smartq_wm8987.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index dfbe2db..c75f98d 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -147,9 +147,6 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "OUT3");
 	snd_soc_dapm_nc_pin(dapm, "ROUT1");
 
-	/* set endpoints to default off mode */
-	snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
-
 	/* Headphone jack detection */
 	err = snd_soc_card_jack_new(rtd->card, "Headphone Jack",
 				    SND_JACK_HEADPHONE, &smartq_jack,
-- 
1.8.0
