From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH 1/2] ASoC: ac97: pxa2xx: fixup multi-platform AC'97 build
 failures
Date: Fri, 28 Jun 2013 11:17:48 -0700
Message-ID: <1372443469-20191-2-git-send-email-khilman@linaro.org>
References: <1372443469-20191-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1372443469-20191-1-git-send-email-khilman@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

commit b047e1cc (ASoC: ac97: Support multi-platform AC'97) introduced
some build failures for the pxa2xx-ac97 support, fix them.

Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 sound/soc/pxa/pxa2xx-ac97.c | 2 ++
 sound/soc/pxa/pxa2xx-ac97.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index a3c22ba..1475515 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -238,6 +238,8 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
 		return -ENXIO;
diff --git a/sound/soc/pxa/pxa2xx-ac97.h b/sound/soc/pxa/pxa2xx-ac97.h
index eda891e..a49c21b 100644
--- a/sound/soc/pxa/pxa2xx-ac97.h
+++ b/sound/soc/pxa/pxa2xx-ac97.h
@@ -14,7 +14,4 @@
 #define PXA2XX_DAI_AC97_AUX		1
 #define PXA2XX_DAI_AC97_MIC		2
 
-/* platform data */
-extern struct snd_ac97_bus_ops pxa2xx_ac97_ops;
-
 #endif
-- 
1.8.3
