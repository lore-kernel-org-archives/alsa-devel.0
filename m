From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: ux500: Fix sparse non static symbol warning
Date: Wed, 8 Jan 2014 18:13:35 +0800
Message-ID: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linus.walleij@linaro.org, fabio.baltieri@linaro.org, lee.jones@linaro.org, arnd@arndb.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warning:

sound/soc/ux500/ux500_msp_i2s.c:649:5: warning:
 symbol 'ux500_msp_i2s_of_init_msp' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/ux500/ux500_msp_i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 7f2a4ac..959d7b4 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -646,9 +646,9 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 
 }
 
-int ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
-			      struct ux500_msp *msp,
-			      struct msp_i2s_platform_data **platform_data)
+static int ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
+				struct ux500_msp *msp,
+				struct msp_i2s_platform_data **platform_data)
 {
 	struct msp_i2s_platform_data *pdata;
 
