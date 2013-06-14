From: Mark Brown <broonie@linaro.org>
Subject: [PATCH 2/2] ASoC: SPEAr: Hide component drivers in
	Kconfig
Date: Fri, 14 Jun 2013 12:30:18 +0100
Message-ID: <1371209418-32496-2-git-send-email-broonie@linaro.org>
References: <1371209418-32496-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EAEC2265198
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:30:24 +0200 (CEST)
In-Reply-To: <1371209418-32496-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

The individual component drivers are only useful with a machine driver and
should be selected by the machine drivers so shouldn't have help text of
their own in order to hide them in interactive configuration.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/spear/Kconfig |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
index 5b744ed..e3851d6 100644
--- a/sound/soc/spear/Kconfig
+++ b/sound/soc/spear/Kconfig
@@ -20,21 +20,11 @@ config SND_SPEAR1340_EVM
 	 platform
 
 config SND_SPEAR_SOC
-	tristate "SoC Audio for the ST chip"
-	depends on SND_DESIGNWARE_I2S || SND_SPEAR_SPDIF_OUT || \
-		SND_SPEAR_SPDIF_IN
-	help
-	 Say Y or M if you want to add support for any of the audio
-	 controllers (I2S/SPDIF). You will also need to select
-	 the audio interface codecs to support below.
+	tristate
 	select SND_SOC_DMAENGINE_PCM
 
 config SND_SPEAR_SPDIF_OUT
-	tristate "SPEAr SPDIF Out Device Driver"
-	help
-	 Say Y or M if you want to add support for SPDIF OUT driver.
+	tristate
 
 config SND_SPEAR_SPDIF_IN
-	tristate "SPEAr SPDIF IN Device Driver"
-	help
-	 Say Y or M if you want to add support for SPDIF IN driver.
+	tristate
-- 
1.7.10.4
