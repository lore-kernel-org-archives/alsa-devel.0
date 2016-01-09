From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] ASoC: rockchip: i2s: Add
	SNDRV_PCM_FMTBIT_S32_LE support
Date: Sat,  9 Jan 2016 23:47:58 +0100
Message-ID: <1452379678-14160-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 37A8926052B
 for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2016 23:48:01 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id b14so218856032wmb.1
 for <alsa-devel@alsa-project.org>; Sat, 09 Jan 2016 14:48:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 58ee645..c35700f 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -242,6 +242,9 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		val |= I2S_TXCR_VDW(24);
 		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		val |= I2S_TXCR_VDW(32);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -360,7 +363,8 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
 			    SNDRV_PCM_FMTBIT_S16_LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-			    SNDRV_PCM_FMTBIT_S24_LE),
+			    SNDRV_PCM_FMTBIT_S24_LE |
+			    SNDRV_PCM_FMTBIT_S32_LE),
 	},
 	.capture = {
 		.stream_name = "Capture",
@@ -370,7 +374,8 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
 			    SNDRV_PCM_FMTBIT_S16_LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-			    SNDRV_PCM_FMTBIT_S24_LE),
+			    SNDRV_PCM_FMTBIT_S24_LE |
+			    SNDRV_PCM_FMTBIT_S32_LE),
 	},
 	.ops = &rockchip_i2s_dai_ops,
 	.symmetric_rates = 1,
-- 
2.7.0
