From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: multi-component: TWL4030: Restore
	registers on removal
Date: Thu, 12 Aug 2010 09:29:52 +0300
Message-ID: <1281594592-2251-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4068E243B7
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 08:30:18 +0200 (CEST)
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

Add back the register restore call, when the codec driver is
removed.
This does not affect normal operation, but it is usefull when
debugging audio through the twl4030 class codecs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
Hello Liam, Mark

I did missed the removal of the register restore from the module
unload path in multi-comp.
This patchs adds it back.

Peter

 sound/soc/codecs/twl4030.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 898430f..c7ee1a4 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2258,6 +2258,8 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 
 static int twl4030_soc_remove(struct snd_soc_codec *codec)
 {
+	/* Reset registers to their chip default before leaving */
+	twl4030_reset_registers(codec);
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
-- 
1.7.2
