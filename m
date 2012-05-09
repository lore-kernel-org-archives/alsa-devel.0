From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs42l52: Staticise non-exported symbols
Date: Wed,  9 May 2012 22:16:00 +0100
Message-ID: <1336598160-4798-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AD6F103E5D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 23:16:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Makes sparse happy and avoids polluting the global namespace.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs42l52.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 703060d..a710941 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -919,7 +919,7 @@ static struct snd_soc_dai_ops cs42l52_ops = {
 	.set_sysclk	= cs42l52_set_sysclk,
 };
 
-struct snd_soc_dai_driver cs42l52_dai = {
+static struct snd_soc_dai_driver cs42l52_dai = {
 		.name = "cs42l52",
 		.playback = {
 			.stream_name = "Playback",
@@ -1163,7 +1163,7 @@ static int cs42l52_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct snd_soc_codec_driver soc_codec_dev_cs42l52 = {
+static struct snd_soc_codec_driver soc_codec_dev_cs42l52 = {
 	.probe = cs42l52_probe,
 	.remove = cs42l52_remove,
 	.suspend = cs42l52_suspend,
-- 
1.7.10
