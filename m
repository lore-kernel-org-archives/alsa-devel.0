From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm1681: Staticise DAI driver
Date: Thu,  8 Aug 2013 12:26:32 +0100
Message-ID: <1375961192-14610-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 71C50261A6A
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 13:26:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@streamunlimited.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

It is not exported so doesn't need to be in the global namespace and
sparse warns on this.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm1681.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 27da41b..51b1866 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -225,7 +225,7 @@ static const struct snd_kcontrol_new pcm1681_controls[] = {
 			    pcm1681_get_deemph, pcm1681_put_deemph),
 };
 
-struct snd_soc_dai_driver pcm1681_dai = {
+static struct snd_soc_dai_driver pcm1681_dai = {
 	.name = "pcm1681-hifi",
 	.playback = {
 		.stream_name = "Playback",
-- 
1.8.4.rc1
