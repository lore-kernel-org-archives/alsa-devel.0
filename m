From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Report an error for unknown adav80x
	formats
Date: Sat, 16 Jul 2011 11:35:37 +0900
Message-ID: <1310783737-6075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D52E9103A4D
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jul 2011 04:35:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Not only fixes error handling but also some uninitialized variable
warnings.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/adav80x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index e30fba6..300c04b 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -456,7 +456,7 @@ static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
 		val = ADAV80X_CAPTURE_WORD_LEN24;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	snd_soc_update_bits(codec, adav80x_port_ctrl_regs[dai->id][0],
@@ -488,7 +488,7 @@ static int adav80x_set_playback_pcm_format(struct snd_soc_codec *codec,
 		val = ADAV80X_PLAYBACK_MODE_RIGHT_J_24;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	snd_soc_update_bits(codec, adav80x_port_ctrl_regs[dai->id][1],
-- 
1.7.5.4
