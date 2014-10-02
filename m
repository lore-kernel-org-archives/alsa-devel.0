From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Improve the error message on
	slave mode setting
Date: Thu,  2 Oct 2014 16:16:50 -0300
Message-ID: <1412277410-25888-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f178.google.com (mail-yk0-f178.google.com
 [209.85.160.178])
 by alsa0.perex.cz (Postfix) with ESMTP id EECBE261735
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 21:17:26 +0200 (CEST)
Received: by mail-yk0-f178.google.com with SMTP id 9so1486847ykp.37
 for <alsa-devel@alsa-project.org>; Thu, 02 Oct 2014 12:17:25 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

For sgtl5000 to operate in slave mode it can only work in "Synchronous
SYS_MCLK input" mode.

In this mode only the following rates can be supported: 256*Fs, 384*Fs, 512*Fs.

Improve the error message to give a better indication as to why the clocking 
failed for slave mode:

[   12.515399] sgtl5000 1-000a: PLL not supported in slave mode
[   12.524124] sgtl5000 1-000a: 233 ratio is not supported. SYS_MCLK needs to be 256, 384 or 512 * fs
[   12.535938] sgtl5000 1-000a: ASoC: can't set sgtl5000 hw params: -22

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index a604a22..c1936bc 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -626,6 +626,9 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 		} else {
 			dev_err(codec->dev,
 				"PLL not supported in slave mode\n");
+			dev_err(codec->dev, "%d ratio is not supported. "
+				"SYS_MCLK needs to be 256, 384 or 512 * fs\n",
+				sgtl5000->sysclk / sys_fs);
 			return -EINVAL;
 		}
 	}
-- 
1.9.1
