From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Add actuall support for 96KHz
	playback support
Date: Fri,  3 Apr 2009 14:39:05 +0300
Message-ID: <1238758745-15424-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A52E71037EB
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 13:39:22 +0200 (CEST)
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Adds the needed code to be able to use 96KHz playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    3 +++
 sound/soc/codecs/twl4030.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4199498..bfda7a8 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1311,6 +1311,9 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	case 48000:
 		mode |= TWL4030_APLL_RATE_48000;
 		break;
+	case 96000:
+		mode |= TWL4030_APLL_RATE_96000;
+		break;
 	default:
 		printk(KERN_ERR "TWL4030 hw params: unknown rate %d\n",
 			params_rate(params));
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 33dbb14..cb63765 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -109,6 +109,7 @@
 #define TWL4030_APLL_RATE_32000		0x80
 #define TWL4030_APLL_RATE_44100		0x90
 #define TWL4030_APLL_RATE_48000		0xA0
+#define TWL4030_APLL_RATE_96000		0xE0
 #define TWL4030_SEL_16K			0x04
 #define TWL4030_CODECPDZ		0x02
 #define TWL4030_OPT_MODE		0x01
-- 
1.6.2
