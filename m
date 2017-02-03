From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v8 2/4] ASoC: Allow to select ES8328_I2C and
	ES8328_SPI directly
Date: Fri,  3 Feb 2017 15:37:58 +0100
Message-ID: <20170203143800.23859-3-romain.perier@collabora.com>
References: <20170203143800.23859-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F77A266AE9
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 15:38:09 +0100 (CET)
In-Reply-To: <20170203143800.23859-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

Currently, we have to select these symbols explictly via Kconfig, from
another entry. If we plan to use generic audio drivers like
simple-audio-card, the user need to be able to enable these symbols
directly via the menuconfig.

This commit also fixes unmet dependencies to SND_SOC_IMX_ES8328 caused
by these changes.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v8:
 - Fixed unmet direct dependencies reported by kbuilt test robot:
"warning: (SND_SOC_IMX_ES8328 && SND_SOC_ALL_CODECS) selects
 SND_SOC_ES8328_I2C which has unmet direct dependencies (SOUND && !M68K
 && !UML && SND && SND_SOC && SND_SOC_ES8328)
warning: (SND_SOC_IMX_ES8328 && SND_SOC_ALL_CODECS) selects
  SND_SOC_ES8328_SPI which has unmet direct dependencies (SOUND && !M68K
  && !UML && SND && SND_SOC && SND_SOC_ES8328)
"
Changes in v7:
 - Added this commit

 sound/soc/codecs/Kconfig | 8 ++++----
 sound/soc/fsl/Kconfig    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a..cfa4233 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -528,12 +528,12 @@ config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
 config SND_SOC_ES8328_I2C
-	tristate
-	select SND_SOC_ES8328
+	depends on SND_SOC_ES8328
+	tristate "I2C support for Everest Semi ES8328 CODEC"
 
 config SND_SOC_ES8328_SPI
-	tristate
-	select SND_SOC_ES8328
+	depends on SND_SOC_ES8328
+	tristate "SPI support for Everest Semi ES8328 CODEC"
 
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 37f9b62..0b914a1 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -244,7 +244,7 @@ config SND_SOC_IMX_WM8962
 
 config SND_SOC_IMX_ES8328
 	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
-	depends on OF && (I2C || SPI)
+	depends on OF && (I2C || SPI) && SND_SOC_ES8328
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_IMX_PCM_DMA
-- 
2.9.3
