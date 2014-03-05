From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl: Don't select FIQ from Eukrea
Date: Wed,  5 Mar 2014 09:14:40 +0800
Message-ID: <1393982080-11357-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B71C265824
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 02:14:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Denis Carikli <denis@eukrea.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

There is no point in using FIQ if DMA is available (it is selected) and
selecting FIQ currently breaks the build on non-i.MX platforms.  If FIQ
is actually required the build will need to be restricted or have a
select for the relevant FIQ code adding.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index a7d6ab6..b244830 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -175,7 +175,6 @@ config SND_SOC_EUKREA_TLV320
 		|| (OF && ARM)
 	depends on I2C
 	select SND_SOC_TLV320AIC23
-	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	select SND_SOC_FSL_SSI
-- 
1.9.0
