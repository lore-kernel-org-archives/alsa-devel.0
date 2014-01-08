From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/8] ASoC: cs42l51: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 19:51:58 +0000
Message-ID: <1389210723-16535-3-git-send-email-broonie@kernel.org>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C628262607
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
 sound/soc/codecs/cs42l51.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 1e0fa3b5f79a..6e9ea8379a91 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -423,21 +423,17 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 		intf_ctl |= CS42L51_INTF_CTL_DAC_FORMAT(CS42L51_DAC_DIF_LJ24);
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		switch (params_format(params)) {
-		case SNDRV_PCM_FORMAT_S16_LE:
-		case SNDRV_PCM_FORMAT_S16_BE:
+		switch (params_width(params)) {
+		case 16:
 			fmt = CS42L51_DAC_DIF_RJ16;
 			break;
-		case SNDRV_PCM_FORMAT_S18_3LE:
-		case SNDRV_PCM_FORMAT_S18_3BE:
+		case 18:
 			fmt = CS42L51_DAC_DIF_RJ18;
 			break;
-		case SNDRV_PCM_FORMAT_S20_3LE:
-		case SNDRV_PCM_FORMAT_S20_3BE:
+		case 20:
 			fmt = CS42L51_DAC_DIF_RJ20;
 			break;
-		case SNDRV_PCM_FORMAT_S24_LE:
-		case SNDRV_PCM_FORMAT_S24_BE:
+		case 24:
 			fmt = CS42L51_DAC_DIF_RJ24;
 			break;
 		default:
-- 
1.8.5.2
