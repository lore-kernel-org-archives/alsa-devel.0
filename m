From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 09/10] [PATCH 04/10] ASoC: finally enable support for eXeda
	and CM-X300
Date: Wed, 14 Oct 2009 09:20:26 +0200
Message-ID: <b013b3ef99e26e493af0a8d8becf3f98502b362a.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eric.y.miao@gmail.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

From: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: alsa-devel@alsa-project.org
---
 sound/soc/pxa/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index dcb3181..d4f4031 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -90,7 +90,8 @@ config SND_PXA2XX_SOC_E800
 
 config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
-	depends on SND_PXA2XX_SOC && MACH_EM_X270
+	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
+			MACH_CM_X300)
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
-- 
1.6.0.6
