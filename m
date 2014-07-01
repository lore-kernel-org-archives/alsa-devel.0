From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 1/8] ASoC: core: Change soc_link_dai_widgets
	signature for multiple codecs
Date: Tue,  1 Jul 2014 09:47:54 +0200
Message-ID: <1404200881-32253-2-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0E42656A4
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:48:42 +0200 (CEST)
Received: by mail-we0-f180.google.com with SMTP id x48so9142719wes.39
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:48:42 -0700 (PDT)
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

Since multiple codecs DAI will be usable in the future, remove
explicit unique codec_dai and cpu_dai parameters.
Replace them with snd_soc_pcm_runtime pointer that will contain
every instances.

No functionale change.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 19c1e958..37a965c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1448,9 +1448,10 @@ static int soc_probe_codec_dai(struct snd_soc_card *card,
 
 static int soc_link_dai_widgets(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link,
-				struct snd_soc_dai *cpu_dai,
-				struct snd_soc_dai *codec_dai)
+				struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dapm_widget *play_w, *capture_w;
 	int ret;
 
@@ -1565,8 +1566,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 						codec2codec_close_delayed_work);
 
 			/* link the DAI widgets */
-			ret = soc_link_dai_widgets(card, dai_link,
-					cpu_dai, codec_dai);
+			ret = soc_link_dai_widgets(card, dai_link, rtd);
 			if (ret)
 				return ret;
 		}
-- 
1.9.1
