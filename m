From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 4/7] staging: max98927: Added missing \n to end
	of dev_err messages
Date: Mon, 19 Jun 2017 15:07:23 -0700
Message-ID: <1497910046-3369-4-git-send-email-ryans.lee@maximintegrated.com>
References: <1497910046-3369-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0097.outbound.protection.outlook.com [104.47.33.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F880267168
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 00:07:45 +0200 (CEST)
In-Reply-To: <1497910046-3369-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 585b8d0..5e33956 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -160,7 +160,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		mode = MAX98927_PCM_MASTER_MODE_MASTER;
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(codec->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -176,7 +176,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		invert = MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported");
+		dev_err(codec->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -331,7 +331,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d",
+		dev_err(codec->dev, "format unsupported %d\n",
 			params_format(params));
 		goto err;
 	}
-- 
2.7.4
