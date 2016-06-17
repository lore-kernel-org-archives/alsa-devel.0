From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH] ASoc: wm8731: add 32bit mode.
Date: Fri, 17 Jun 2016 14:48:16 +1000
Message-ID: <1466138896-19739-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas03p.mx.bigpond.com (nskntmtas03p.mx.bigpond.com
 [61.9.168.143]) by alsa0.perex.cz (Postfix) with ESMTP id 3503826582C
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 06:48:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

This patch adds 32 bit word capability to the wm8731 driver. The wm8731
codec is capable of handling 32 bit word sizes, however that has not
previously been activated in the codec driver.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/codecs/wm8731.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4bcf5f8..d18261a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -358,6 +358,9 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	case 24:
 		iface |= 0x0008;
 		break;
+	case 32:
+		iface |= 0x000c;
+		break;
 	}
 
 	wm8731_set_deemph(codec);
@@ -541,7 +544,7 @@ static int wm8731_startup(struct snd_pcm_substream *substream,
 #define WM8731_RATES SNDRV_PCM_RATE_8000_96000
 
 #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-	SNDRV_PCM_FMTBIT_S24_LE)
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8731_dai_ops = {
 	.startup	= wm8731_startup,
-- 
2.7.4
