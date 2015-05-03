From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: speyside: Use
	snd_soc_codec_get_dapm()
Date: Sun,  3 May 2015 19:27:10 +0200
Message-ID: <1430674030-1388-5-git-send-email-lars@metafoo.de>
References: <1430674030-1388-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 238302604F4
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2015 19:27:22 +0200 (CEST)
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

The dapm field of the snd_soc_codec struct is eventually going to be
removed. Replace direct access to it with snd_soc_codec_get_dapm(), which
will return the DAPM context for the CODEC.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Depends on topic/dapm
---
 sound/soc/samsung/speyside.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 2dcb988..d1ae21c 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -123,7 +123,7 @@ static void speyside_set_polarity(struct snd_soc_codec *codec,
 	gpio_direction_output(WM8996_HPSEL_GPIO, speyside_jack_polarity);
 
 	/* Re-run DAPM to make sure we're using the correct mic bias */
-	snd_soc_dapm_sync(&codec->dapm);
+	snd_soc_dapm_sync(snd_soc_codec_get_dapm(codec));
 }
 
 static int speyside_wm0010_init(struct snd_soc_pcm_runtime *rtd)
-- 
1.8.0
