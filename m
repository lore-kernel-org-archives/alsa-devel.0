From: me@rockwellcollins.com
Subject: [PATCH 1/1] ASoC: Add AU1761 audio codec as selectable
	option
Date: Fri, 24 Feb 2017 15:00:34 -0600
Message-ID: <2521.7434893877$1505297932@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>

This commit adds the ADI AU1761 audio codec as a selectable option
in the kernel config.  Currently the driver can only be selected
for ADI blackfin devices or if SND_SOC_ALL_CODECS is enabled.

Signed-off-by: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e49e9da..43539c3b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -303,12 +303,14 @@ config SND_SOC_ADAU1761
 	select SND_SOC_ADAU17X1
 
 config SND_SOC_ADAU1761_I2C
-	tristate
+	tristate "Analog Devices AU1761 CODEC - I2C"
+	depends on I2C
 	select SND_SOC_ADAU1761
 	select REGMAP_I2C
 
 config SND_SOC_ADAU1761_SPI
-	tristate
+	tristate "Analog Devices AU1761 CODEC - SPI"
+	depends on SPI
 	select SND_SOC_ADAU1761
 	select REGMAP_SPI
 
-- 
2.7.4
