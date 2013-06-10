From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH] ASoC: Add Kconfig and Makefile to support
	SPEAr audio driver
Date: Mon, 10 Jun 2013 16:19:40 +0530
Message-ID: <1370861380-27657-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog102.obsmtp.com (eu1sys200aog102.obsmtp.com
 [207.126.144.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6702610AA
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 12:49:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com
List-Id: alsa-devel@alsa-project.org

This patch adds Kconfig and Makefile to support SPEAr Audio driver.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/Kconfig        |    1 +
 sound/soc/Makefile       |    1 +
 sound/soc/spear/Kconfig  |   39 +++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/Makefile |    7 +++++++
 4 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 5da8ca7..c6d98e2 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -47,6 +47,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/ux500/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 99f32f7..b86bf5a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= ux500/
diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
new file mode 100644
index 0000000..3b7cdad
--- /dev/null
+++ b/sound/soc/spear/Kconfig
@@ -0,0 +1,39 @@
+config SND_SPEAR_EVM
+	tristate "SoC Audio support for SPEAr EVM"
+	select SND_DESIGNWARE_I2S
+	select SND_SOC_STA529
+	select SND_SPEAR_SOC
+	help
+	 Say Y if you want to add support for SoC audio on SPEAr
+	 platform
+
+config SND_SPEAR1340_EVM
+	tristate "SoC Audio support for SPEAr1340 EVM"
+	select SND_DESIGNWARE_I2S
+	select SND_SOC_STA529
+	select SND_SPEAR_SPDIF_OUT
+	select SND_SPEAR_SPDIF_IN
+	select SND_SOC_SPDIF
+	select SND_SPEAR_SOC
+	help
+	 Say Y if you want to add support for SoC audio on SPEAr1340
+	 platform
+
+config SND_SPEAR_SOC
+	tristate "SoC Audio for the ST chip"
+	depends on SND_DESIGNWARE_I2S || SND_SPEAR_SPDIF_OUT || \
+		SND_SPEAR_SPDIF_IN
+	help
+	 Say Y or M if you want to add support for any of the audio
+	 controllers (I2S/SPDIF). You will also need to select
+	 the audio interface codecs to support below.
+
+config SND_SPEAR_SPDIF_OUT
+	tristate "SPEAr SPDIF Out Device Driver"
+	help
+	 Say Y or M if you want to add support for SPDIF OUT driver.
+
+config SND_SPEAR_SPDIF_IN
+	tristate "SPEAr SPDIF IN Device Driver"
+	help
+	 Say Y or M if you want to add support for SPDIF IN driver.
diff --git a/sound/soc/spear/Makefile b/sound/soc/spear/Makefile
new file mode 100644
index 0000000..b365126
--- /dev/null
+++ b/sound/soc/spear/Makefile
@@ -0,0 +1,7 @@
+# SPEAR Platform Support
+obj-$(CONFIG_SND_SPEAR_SOC) += spear_pcm.o
+obj-$(CONFIG_SND_SPEAR_SPDIF_IN) += spdif_in.o
+obj-$(CONFIG_SND_SPEAR_SPDIF_OUT) += spdif_out.o
+
+# SPEAR Machine Support
+obj-$(CONFIG_SND_SPEAR_EVM) += spear_evb.o
-- 
1.6.0.2
