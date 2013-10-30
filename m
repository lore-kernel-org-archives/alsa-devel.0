From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/9] ASoC: ml26124: Fix negative array index
	read
Date: Wed, 30 Oct 2013 08:35:05 +0100
Message-ID: <1383118507-21503-8-git-send-email-tiwai@suse.de>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DEBC264F3F
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 08:32:34 +0100 (CET)
In-Reply-To: <1383118507-21503-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

get_coeff() may return an error.

Spotted by coverity CID 703394.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ml26124.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 26118828782b..4725aa445cc8 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -342,6 +342,8 @@ static int ml26124_hw_params(struct snd_pcm_substream *substream,
 	struct ml26124_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int i = get_coeff(priv->mclk, params_rate(hw_params));
 
+	if (i < 0)
+		return -EINVAL;
 	priv->substream = substream;
 	priv->rate = params_rate(hw_params);
 
-- 
1.8.4.1
