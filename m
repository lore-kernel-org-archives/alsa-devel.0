From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 7/7] ASoC: pxa: make SND_PXA2XX_SOC_I2S
	selectable
Date: Wed, 27 Jun 2018 21:33:59 +0200
Message-ID: <20180627193359.26631-8-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id C04A12679CA
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:17 +0200 (CEST)
In-Reply-To: <20180627193359.26631-1-daniel@zonque.org>
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
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 960744e46edc..95dcf97a6271 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -31,7 +31,7 @@ config SND_PXA2XX_SOC_I2S
 	tristate
 
 config SND_PXA_SOC_SSP
-	tristate
+	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
 	select PXA_SSP
 
 config SND_MMP_SOC_SSPA
-- 
2.17.1
