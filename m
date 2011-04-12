From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: codecs: JZ4740: Fix OOPS
Date: Tue, 12 Apr 2011 19:33:28 +0200
Message-ID: <1302629609-21537-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
	[212.40.185.51]) by alsa0.perex.cz (Postfix) with SMTP id 1F32C1038D8
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 19:32:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit ce6120cc(ASoC: Decouple DAPM from CODECs) changed the signature of
snd_soc_dapm_widgets_new to take an pointer to a snd_soc_dapm_context instead of
a snd_soc_codec. The call to snd_soc_dapm_widgets_new in jz4740_codec_dev_probe
was not updated to reflect this change, which results in a compiletime warning
and a runtime OOPS.

Since the core code calls snd_soc_dapm_widgets_new after the codec has been
registered it can be dropped here.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/jz4740.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index f7cd346..f5ccdbf7 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -308,8 +308,6 @@ static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 	snd_soc_dapm_add_routes(dapm, jz4740_codec_dapm_routes,
 		ARRAY_SIZE(jz4740_codec_dapm_routes));
 
-	snd_soc_dapm_new_widgets(codec);
-
 	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
-- 
1.7.2.5
