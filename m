From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] ASoC: sgtl5000: Allow 8kHz playback in
	codec slave mode
Date: Thu, 27 Nov 2014 13:02:01 -0200
Message-ID: <1417100521-8483-3-git-send-email-festevam@gmail.com>
References: <1417100521-8483-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C15AA266192
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 16:02:29 +0100 (CET)
Received: by mail-qg0-f54.google.com with SMTP id q107so3616563qgd.13
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 07:02:29 -0800 (PST)
In-Reply-To: <1417100521-8483-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, craig.mcqueen@beamcommunications.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When trying to play a 8kHz file with codec in slave mode we get the following
error on a mx28evk:

$ aplay -Dhw:0,0 stereo_8k.wav 
Playing WAVE 'stereo_8k.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
[   21.218647] sgtl5000 0-000a: PLL not supported in slave mode
[   21.224559] sgtl5000 0-000a: 128 ratio is not supported. SYS_MCLK needs to be 256, 384 or 512 * fs
[   21.233687] sgtl5000 0-000a: ASoC: can't set sgtl5000 hw params: -22
aplay: set_params:1123: Unable to install hw params:

This error happens because we are using 'sys_fs' instead of 'frame_rate' in the
valid ratio check.

Use the real'frame_rate' so that the ratio is correctly calculated and the 
playback can run. 

sgtl5000 codec manual states that in 'Synchronous SYS_MCLK input' mode that the
following SYS_CLK frequencies are allowed: 256*fs, 384*fs, 512*fs.

, where fs is the sampling frequency, which can be in the range of:
8, 11.025, 16, 22.5, 32, 44.1, 48, 96 kHz.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8dea6b3..29cf7ce 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -618,7 +618,7 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 	 * factor of freq = 96 kHz can only be 256, since mclk is in the range
 	 * of 8 MHz - 27 MHz
 	 */
-	switch (sgtl5000->sysclk / sys_fs) {
+	switch (sgtl5000->sysclk / frame_rate) {
 	case 256:
 		clk_ctl |= SGTL5000_MCLK_FREQ_256FS <<
 			SGTL5000_MCLK_FREQ_SHIFT;
@@ -641,7 +641,7 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 				"PLL not supported in slave mode\n");
 			dev_err(codec->dev, "%d ratio is not supported. "
 				"SYS_MCLK needs to be 256, 384 or 512 * fs\n",
-				sgtl5000->sysclk / sys_fs);
+				sgtl5000->sysclk / frame_rate);
 			return -EINVAL;
 		}
 	}
-- 
1.9.1
