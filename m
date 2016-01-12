From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI depending on SoC type
Date: Tue, 12 Jan 2016 19:13:31 +0100
Message-ID: <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

i.MX6UL does not provide an SSI interface like the other i.MX6 SoCs,
but only an SAI interface.
Select the appropriate interface(s) depending on the enabled SoC types.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/fsl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 14dfdee..c128823 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -258,7 +258,8 @@ config SND_SOC_IMX_SGTL5000
 	select SND_SOC_SGTL5000
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_SAI if SOC_IMX6UL
+	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX
 	help
 	  Say Y if you want to add support for SoC audio on an i.MX board wit=
h
 	  a sgtl5000 codec.
--=20
2.1.4
