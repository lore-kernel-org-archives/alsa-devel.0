From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Check the interface format
	for 4 channel mode
Date: Mon,  1 Jun 2009 14:06:40 +0300
Message-ID: <1243854400-20902-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1243854400-20902-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1CD2443B
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 13:06:53 +0200 (CEST)
In-Reply-To: <1243854400-20902-1-git-send-email-peter.ujfalusi@nokia.com>
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

In addition to the operating mode check, also check the
codec's interface format in case of four channel mode.
If the codec is not in TDM (DSP_A) mode, return with error.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index df474a5..c53c7ca 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1608,9 +1608,15 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 
 	 /* If the substream has 4 channel, do the necessary setup */
 	if (params_channels(params) == 4) {
-		/* Safety check: are we in the correct operating mode? */
-		if ((twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE) &
-			TWL4030_OPTION_1))
+		u8 format, mode;
+
+		format = twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF);
+		mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE);
+
+		/* Safety check: are we in the correct operating mode and
+		 * the interface is in TDM mode? */
+		if ((mode & TWL4030_OPTION_1) &&
+		    ((format & TWL4030_AIF_FORMAT) == TWL4030_AIF_FORMAT_TDM))
 			twl4030_tdm_enable(codec, substream->stream, 1);
 		else
 			return -EINVAL;
-- 
1.6.3.1
