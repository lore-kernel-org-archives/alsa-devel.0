From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: sta529: Convert to params_width()
Date: Thu, 31 Jul 2014 13:02:21 +0100
Message-ID: <1406808143-8985-3-git-send-email-broonie@kernel.org>
References: <1406808143-8985-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB48C2655BF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:02:40 +0200 (CEST)
In-Reply-To: <1406808143-8985-1-git-send-email-broonie@kernel.org>
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

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/sta529.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index fcdf11026aff..9aa1323fb2ab 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -197,16 +197,16 @@ static int sta529_hw_params(struct snd_pcm_substream *substream,
 	int pdata, play_freq_val, record_freq_val;
 	int bclk_to_fs_ratio;
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		pdata = 1;
 		bclk_to_fs_ratio = 0;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		pdata = 2;
 		bclk_to_fs_ratio = 1;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		pdata = 3;
 		bclk_to_fs_ratio = 2;
 		break;
-- 
2.0.1
