From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: kirkwood-i2s: Remove empty remove()
Date: Tue, 16 Jul 2013 10:55:05 +0100
Message-ID: <1373968506-22375-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 822B126165C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 11:55:11 +0200 (CEST)
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
 sound/soc/kirkwood/kirkwood-i2s.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 44412ea..becc082 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -398,11 +398,6 @@ static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 
 }
 
-static int kirkwood_i2s_remove(struct snd_soc_dai *dai)
-{
-	return 0;
-}
-
 static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 	.startup	= kirkwood_i2s_startup,
 	.trigger	= kirkwood_i2s_trigger,
@@ -413,7 +408,6 @@ static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 
 static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 	.probe = kirkwood_i2s_probe,
-	.remove = kirkwood_i2s_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -431,7 +425,6 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 
 static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
 	.probe = kirkwood_i2s_probe,
-	.remove = kirkwood_i2s_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-- 
1.8.3.2
