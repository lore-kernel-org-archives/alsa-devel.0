From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v7 2/4] ASoC: Allow to select ES8328_I2C and
	ES8328_SPI directly
Date: Tue, 31 Jan 2017 15:55:24 +0100
Message-ID: <20170131145526.26808-3-romain.perier@collabora.com>
References: <20170131145526.26808-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 927E1266F0D
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 15:56:02 +0100 (CET)
In-Reply-To: <20170131145526.26808-1-romain.perier@collabora.com>
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

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v7:
 - Added this commit

 sound/soc/codecs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.9.3
