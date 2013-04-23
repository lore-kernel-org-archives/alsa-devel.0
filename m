From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/21] ASoC: ux500: forward declare
	msp_i2s_platform_data
Date: Tue, 23 Apr 2013 18:30:40 +0200
Message-ID: <1366734653-488286-9-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A7D1264F0F
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2013 18:32:12 +0200 (CEST)
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

We get a lot of build warnings from the msp driver like:

In file included from sound/soc/ux500/ux500_msp_dai.h:21:0,
                 from sound/soc/ux500/mop500.c:25:
sound/soc/ux500/ux500_msp_i2s.h:546:11: warning: 'struct msp_i2s_platform_data' declared inside parameter list [enabled by default]
    struct msp_i2s_platform_data *platform_data);
           ^
sound/soc/ux500/ux500_msp_i2s.h:546:11: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

The easiest solution is to add a declaration of the struct name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/ux500/ux500_msp_i2s.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 1311c0d..6f3e3dc 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -543,6 +543,7 @@ struct ux500_msp_dma_params {
 	struct stedma40_chan_cfg *dma_cfg;
 };
 
+struct msp_i2s_platform_data;
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 			struct ux500_msp **msp_p,
 			struct msp_i2s_platform_data *platform_data);
-- 
1.8.1.2
