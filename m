From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: ak4642: Remove redundant break
Date: Fri, 13 Sep 2013 15:50:50 +0530
Message-ID: <1379067650-4362-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BC5B92608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:38:59 +0200 (CEST)
Received: by mail-pb0-f43.google.com with SMTP id md4so1056614pbc.30
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:38:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, broonie@kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

'break' after return statement is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/ak4642.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 2d03787..21c35ed 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -352,7 +352,6 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	 */
 	default:
 		return -EINVAL;
-		break;
 	}
 	snd_soc_update_bits(codec, MD_CTL1, DIF_MASK, data);
 
@@ -405,7 +404,6 @@ static int ak4642_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 	snd_soc_update_bits(codec, MD_CTL2, FS_MASK, rate);
 
-- 
1.7.9.5
