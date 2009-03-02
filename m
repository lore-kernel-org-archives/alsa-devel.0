From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: fix typo and removed unneeded switch
	case for cs4270
Date: Mon,  2 Mar 2009 17:19:01 +0000
Message-ID: <1236014341-25837-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1236014341-25837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAB53103807
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 18:19:02 +0100 (CET)
In-Reply-To: <1236014341-25837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Mack <daniel@caiaq.de>

This removes a misspelled comment and got rid of superfluous switch
case.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Acked-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 339e0f6..f86f33c 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -267,10 +267,8 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_CBM_CFM:
 		cs4270->slave_mode = 0;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
-		/* unsupported - cs4270 can eigther be slave or master to
-		 * both the bitclk and the lrclk. */
 	default:
+		/* all other modes are unsupported by the hardware */
 		ret = -EINVAL;
 	}
 
-- 
1.6.1.3
