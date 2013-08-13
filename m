From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: pcm1792a: Remove empty capture DAI
	stub
Date: Tue, 13 Aug 2013 18:30:47 +0100
Message-ID: <1376415048-6029-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C87B261A5E
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 19:30:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

These intialisations are just what will be done for static data anyway so
remove them.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm1792a.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 72cf835..c57d3a5 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -162,10 +162,6 @@ static struct snd_soc_dai_driver pcm1792a_dai = {
 		.channels_max = 2,
 		.rates = PCM1792A_RATES,
 		.formats = PCM1792A_FORMATS, },
-	.capture = {
-		.channels_min = 0,
-		.channels_max = 0,
-	},
 	.ops = &pcm1792a_dai_ops,
 };
 
-- 
1.8.4.rc2
