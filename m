From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Fix typo in
	twl4030_codec_mute function
Date: Thu,  7 May 2009 14:32:00 +0300
Message-ID: <1241695920-24509-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CC30247AB
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 13:32:15 +0200 (CEST)
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

Copy-paste error: TWL4030_PRECKL_GAIN >> TWL4030_PRECKR_GAIN
It has not caused problems, since
TWL4030_PRECKL_GAIN == TWL4030_PRECKR_GAIN == 0x30

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1a00e4b..fd392c6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -237,7 +237,7 @@ static void twl4030_codec_mute(struct snd_soc_codec *codec, int mute)
 					TWL4030_REG_PRECKL_CTL);
 		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PRECKR_CTL);
 		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					reg_val & (~TWL4030_PRECKL_GAIN),
+					reg_val & (~TWL4030_PRECKR_GAIN),
 					TWL4030_REG_PRECKR_CTL);
 
 		/* Disable PLL */
-- 
1.6.2.3
