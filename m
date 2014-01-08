From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/8] ASoC: alc5632: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 19:51:57 +0000
Message-ID: <1389210723-16535-2-git-send-email-broonie@kernel.org>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D94A2651A1
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 20:55:09 +0100 (CET)
In-Reply-To: <1389210723-16535-1-git-send-email-broonie@kernel.org>
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

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/alc5632.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 19e9f222d09c..fb001c56cf8d 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -869,14 +869,14 @@ static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
 	iface &= ~ALC5632_DAI_I2S_DL_MASK;
 
 	/* bit size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		iface |= ALC5632_DAI_I2S_DL_16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface |= ALC5632_DAI_I2S_DL_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface |= ALC5632_DAI_I2S_DL_24;
 		break;
 	default:
-- 
1.8.5.2
