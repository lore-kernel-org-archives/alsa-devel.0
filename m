From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Allow the codec to work in
	slave mode
Date: Thu, 18 Sep 2014 20:17:25 -0300
Message-ID: <1411082245-25679-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A80D0262626
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 01:17:53 +0200 (CEST)
Received: by mail-yk0-f172.google.com with SMTP id q9so409801ykb.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 16:17:52 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, jean-michel.hautbois@vodalys.com, alsa-devel@alsa-project.org, Fabio Estevam <fabio.estevam@freescale.com>, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When configuring sgtl5000 to work in slave mode the following error is seen:

root@freescale /$ aplay dtmf_mono_16b_48000.wav 
[   11.406460] random: nonblocking pool is initialized
[   11.600461] sgtl5000 1-000a: PLL not supported in slave mode
[   11.609052] sgtl5000 1-000a: ASoC: can't set sgtl5000 hw params: -22
ALSA lib pcm_direct.c:980:(snd1_pcm_direct_initialize_slave) unable to install hw params
ALSA lib pcm_dmix.c:1030:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:660: audio open error: Invalid argument

Do not error out when sgtl5000_set_clock() reaches the default path for slave 
mode.

While at it, fix a typo in the comment.

Tested on a imx53-qsb configured as ssi in master and sgtl5000 as slave.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index a604a22..b641ed1 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -619,14 +619,10 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 			SGTL5000_MCLK_FREQ_SHIFT;
 		break;
 	default:
-		/* if mclk not satisify the divider, use pll */
+		/* if mclk not satisfy the divider, use pll */
 		if (sgtl5000->master) {
 			clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
 				SGTL5000_MCLK_FREQ_SHIFT;
-		} else {
-			dev_err(codec->dev,
-				"PLL not supported in slave mode\n");
-			return -EINVAL;
 		}
 	}
 
-- 
1.9.1
