From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: samsung: remove redundant pointer
	cpu_dai
Date: Tue, 13 Mar 2018 13:36:26 +0000
Message-ID: <20180313133626.31286-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E3EE266E77
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 14:36:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer cpu_dai is assigned a value but the pointer is never
read, hence it is redundant and can be removed.

Cleans up clang warning:
sound/soc/samsung/snow.c:45:2: warning: Value stored to 'cpu_dai' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/samsung/snow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index fc62110f500f..47b904e2b8c3 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -37,12 +37,10 @@ static int snow_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai;
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	codec_dai = rtd->codec_dai;
-	cpu_dai = rtd->cpu_dai;
 
 	/* Set the MCLK rate for the codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-- 
2.15.1
