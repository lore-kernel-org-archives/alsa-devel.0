From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: pxa: select SND_PXA2XX_LIB for drivers
	that depend on it
Date: Sat, 30 Jun 2018 22:24:33 +0200
Message-ID: <20180630202433.8615-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB2F26735C
 for <alsa-devel@alsa-project.org>; Sat, 30 Jun 2018 22:24:39 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, lkp@intel.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Commit d767d3ce5c48b ("ASoC: pxa: provide PCM ops for ssp, i2s and ac97
components") created a build-time dependency to SND_PXA2XX_LIB but
missed to reflect that in Kconfig.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 95dcf97a6271..2fc02c227f69 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -24,15 +24,18 @@ config SND_PXA2XX_AC97
 config SND_PXA2XX_SOC_AC97
 	tristate
 	select AC97_BUS
+	select SND_PXA2XX_LIB
 	select SND_PXA2XX_LIB_AC97
 	select SND_SOC_AC97_BUS
 
 config SND_PXA2XX_SOC_I2S
+	select SND_PXA2XX_LIB
 	tristate
 
 config SND_PXA_SOC_SSP
 	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
 	select PXA_SSP
+	select SND_PXA2XX_LIB
 
 config SND_MMP_SOC_SSPA
 	tristate
-- 
2.17.1
