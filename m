From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 03/11] ASoC: Use data based init for cx20442
	DAPM
Date: Wed, 30 Mar 2011 21:53:09 +0800
Message-ID: <1301493197-8673-3-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B1FD9243AC
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:53:45 +0200 (CEST)
In-Reply-To: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Takashi Iwai <tiwai@suse.de>, Lu Guanqun <guanqun.lu@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

CC: Liam Girdwood <lrg@slimlogic.co.uk>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
CC: Jarkko Nikula <jhnikula@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/cx20442.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 0bb424a..d68ea53 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -86,18 +86,6 @@ static const struct snd_soc_dapm_route cx20442_audio_map[] = {
 	{"ADC", NULL, "Input Mixer"},
 };
 
-static int cx20442_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, cx20442_dapm_widgets,
-				  ARRAY_SIZE(cx20442_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, cx20442_audio_map,
-				ARRAY_SIZE(cx20442_audio_map));
-
-	return 0;
-}
-
 static unsigned int cx20442_read_reg_cache(struct snd_soc_codec *codec,
 							unsigned int reg)
 {
@@ -344,8 +332,6 @@ static int cx20442_codec_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, cx20442);
 
-	cx20442_add_widgets(codec);
-
 	cx20442->control_data = NULL;
 	codec->hw_write = NULL;
 	codec->card->pop_time = 0;
@@ -377,6 +363,10 @@ static struct snd_soc_codec_driver cx20442_codec_dev = {
 	.reg_word_size = sizeof(u8),
 	.read = cx20442_read_reg_cache,
 	.write = cx20442_write,
+	.dapm_widgets = cx20442_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cx20442_dapm_widgets),
+	.dapm_routes = cx20442_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(cx20442_audio_map),
 };
 
 static int cx20442_platform_probe(struct platform_device *pdev)
-- 
1.7.2.3
