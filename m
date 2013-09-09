From: <oku@iki.fi>
Subject: [PATCH RFC 5/8] ASoC: davinci: Add support for AM33xx
	SoC Audio
Date: Mon, 9 Sep 2013 18:12:16 +0300
Message-ID: <3080f759b7390ff36db367ef1faf8b9df0a8d64d.1378738436.git.jsarha@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FE992650D7
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:35 +0200 (CEST)
In-Reply-To: <cover.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Darren Etheridge <detheridge@ti.com>, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

AM33xx uses same McASP IP as the Davinci Platform. This patch updates
Kconfig and makefile to enable build or McASP, PCM & Codec drivers

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig  |    8 ++++++++
 sound/soc/davinci/Makefile |    3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index c82f89c..48ed52d 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -6,6 +6,14 @@ config SND_DAVINCI_SOC
 	  the DAVINCI AC97 or I2S interface. You will also need
 	  to select the audio interfaces to support below.
 
+config SND_AM33XX_SOC
+	tristate "SoC Audio for the AM33XX chip"
+	depends on SOC_AM33XX
+	select SND_SOC_TLV320AIC3X
+	help
+	  Say Y or M if you want to add support for SoC audio on AM33xx
+	  boards using McASP and TLV320AIC3X codec.
+
 config SND_DAVINCI_SOC_I2S
 	tristate
 
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a396ab6..120b6e2 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -5,14 +5,17 @@ snd-soc-davinci-mcasp-objs:= davinci-mcasp.o
 snd-soc-davinci-vcif-objs:= davinci-vcif.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC) += snd-soc-davinci.o
+obj-$(CONFIG_SND_AM33XX_SOC) += snd-soc-davinci.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
+obj-$(CONFIG_SND_AM33XX_SOC) += snd-soc-davinci-mcasp.o
 obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM33XX_SOC) += snd-soc-evm.o
 obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA830_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DA850_SOC_EVM) += snd-soc-evm.o
-- 
1.7.9.5
