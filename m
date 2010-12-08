From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCHv2] ASoC: WM8580: Debug BCLK and sample size
Date: Wed,  8 Dec 2010 16:50:24 +0900
Message-ID: <1291794624-13982-1-git-send-email-jassi.brar@samsung.com>
References: <1291717387-11961-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C2D0103AEB
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 09:04:29 +0100 (CET)
In-Reply-To: <1291717387-11961-1-git-send-email-jassi.brar@samsung.com>
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
Cc: sbkim73@samsung.com, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

In case of SNDRV_PCM_FORMAT_S32_LE, we need to set
WM8580_AIF_LENGTH_32, rather than WM8580_AIF_LENGTH_24.
Also, the BCLK has to be 64fs, for sample size of 20, 24 and 32 bits.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/codecs/wm8580.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index cb7765f..6296946 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -491,16 +491,13 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		paifa |= 0x8;
 		break;
 	case SNDRV_PCM_FORMAT_S20_3LE:
-		paifa |= 0x10;
 		paifb |= WM8580_AIF_LENGTH_20;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		paifa |= 0x10;
 		paifb |= WM8580_AIF_LENGTH_24;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		paifa |= 0x10;
-		paifb |= WM8580_AIF_LENGTH_24;
+		paifb |= WM8580_AIF_LENGTH_32;
 		break;
 	default:
 		return -EINVAL;
-- 
1.6.2.5
