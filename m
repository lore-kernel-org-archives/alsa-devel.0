From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: SSM2602: Remove driver specific
	version
Date: Wed, 25 Apr 2012 11:42:47 +0200
Message-ID: <1335346968-6086-2-git-send-email-lars@metafoo.de>
References: <1335346968-6086-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-102.synserver.de
	[212.40.185.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A749F104842
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 11:40:25 +0200 (CEST)
In-Reply-To: <1335346968-6086-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We have never really updated that version number and probably never will, so
just remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index dcedd74..aef8a49 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -43,8 +43,6 @@
 
 #include "ssm2602.h"
 
-#define SSM2602_VERSION "0.1"
-
 enum ssm2602_type {
 	SSM2602,
 	SSM2604,
@@ -608,8 +606,6 @@ static int ssm260x_probe(struct snd_soc_codec *codec)
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	pr_info("ssm2602 Audio Codec %s", SSM2602_VERSION);
-
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, ssm2602->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-- 
1.7.9.5
