From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Staticise non-exported symbols in cs4271
Date: Wed, 26 Jan 2011 11:36:14 +0000
Message-ID: <1296041774-24028-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26CAE24531
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 14:06:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4271.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 5357ec5..9c5b7db 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -386,7 +386,7 @@ static struct snd_soc_dai_ops cs4271_dai_ops = {
 	.digital_mute	= cs4271_digital_mute,
 };
 
-struct snd_soc_dai_driver cs4271_dai = {
+static struct snd_soc_dai_driver cs4271_dai = {
 	.name = "cs4271-hifi",
 	.playback = {
 		.stream_name	= "Playback",
@@ -526,7 +526,7 @@ static int cs4271_remove(struct snd_soc_codec *codec)
 	return 0;
 };
 
-struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
+static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
 	.probe			= cs4271_probe,
 	.remove			= cs4271_remove,
 	.suspend		= cs4271_soc_suspend,
-- 
1.7.2.3
