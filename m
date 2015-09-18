From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 2/4] ASoC: wm8962: remove 64k sample rate
	support
Date: Fri, 18 Sep 2015 17:19:25 +0800
Message-ID: <2e8075642e5d428b1136b3b7b18be5b7d30c358a.1442566367.git.zidan.wang@freescale.com>
References: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 507DE265B51
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:17:44 +0200 (CEST)
In-Reply-To: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
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
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

wm8962 can't support 64k sample rate. When playing a 64KHz wave file,
'Unsupported rate 64000Hz' will be prompted.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8962.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4eb975..293e47a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2944,7 +2944,8 @@ static int wm8962_mute(struct snd_soc_dai *dai, int mute)
 				   WM8962_DAC_MUTE, val);
 }
 
-#define WM8962_RATES SNDRV_PCM_RATE_8000_96000
+#define WM8962_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define WM8962_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-- 
1.9.1
