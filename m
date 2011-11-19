From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove redundant regcache_sync call in
	cs42l73_resume
Date: Sat, 19 Nov 2011 13:45:34 +0800
Message-ID: <1321681534.4414.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F34B41037EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 06:45:56 +0100 (CET)
Received: by yenr9 with SMTP id r9so1290951yen.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 21:45:56 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

It's done in cs42l73_set_bias_level when the dapm.bias_level is switching
from SND_SOC_BIAS_OFF to SND_SOC_BIAS_STANDBY.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l73.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 066d869..e8a62fe 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1271,10 +1271,6 @@ static int cs42l73_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int cs42l73_resume(struct snd_soc_codec *codec)
 {
-
-	struct cs42l73_private *cs42l73 = snd_soc_codec_get_drvdata(codec);
-	regcache_sync(cs42l73->regmap);
-
 	cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
-- 
1.7.5.4
