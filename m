From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 18/35] ASoC: wm8940: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:01 +0100
Message-ID: <1406807898-5927-18-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D9A1264F1D
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:42 +0200 (CEST)
In-Reply-To: <1406807898-5927-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8940.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index fc6eec9ad66b..52011043e54c 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -430,19 +430,19 @@ static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		goto error_ret;
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
+	switch (params_width(params)) {
+	case 8:
 		companding = companding | (1 << 5);
 		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface |= (1 << 5);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface |= (2 << 5);
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		iface |= (3 << 5);
 		break;
 	}
-- 
2.0.1
