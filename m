From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs4270: Check that we can enable
	regulators on resume
Date: Mon, 19 Mar 2012 16:16:17 +0000
Message-ID: <1332173777-9786-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66328104172
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 17:16:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's possible that the regulator enable will fail and if it does we may
as well just give up with trying to bring the rest of the device up and
report the original error.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 1d672f5..15df950 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -602,8 +602,10 @@ static int cs4270_soc_resume(struct snd_soc_codec *codec)
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int reg;
 
-	regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
-			      cs4270->supplies);
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
+				    cs4270->supplies);
+	if (ret != 0)
+		return ret;
 
 	/* In case the device was put to hard reset during sleep, we need to
 	 * wait 500ns here before any I2C communication. */
-- 
1.7.9.1
