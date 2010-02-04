From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Module unloading fix
Date: Thu,  4 Feb 2010 09:10:10 +0200
Message-ID: <1265267410-8007-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E78A8103895
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 08:11:08 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The module unloading path had several problems:
- it freed up the private structure twice
- it freed up the codec structure, which was allocated as part
  of the private structure
- it did not freed up the reg_cache
- it did not unregistered the dais and the codec

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e0106a5..b32aeb3 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2152,8 +2152,6 @@ static int twl4030_soc_remove(struct platform_device *pdev)
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-	kfree(codec->private_data);
-	kfree(codec);
 
 	return 0;
 }
@@ -2237,6 +2235,9 @@ static int __devexit twl4030_codec_remove(struct platform_device *pdev)
 {
 	struct twl4030_priv *twl4030 = platform_get_drvdata(pdev);
 
+	snd_soc_unregister_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
+	snd_soc_unregister_codec(&twl4030->codec);
+	kfree(twl4030->codec.reg_cache);
 	kfree(twl4030);
 
 	twl4030_codec = NULL;
-- 
1.6.6.1
