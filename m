From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH 7/8] sound:asoc: Add Kconfig and Makefile to
	support SPEAr audio driver
Date: Tue, 20 Mar 2012 17:03:51 +0530
Message-ID: <23b293a002accaad0119a68286f1650aac400cdc.1332242166.git.rajeev-dlh.kumar@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog102.obsmtp.com (eu1sys200aog102.obsmtp.com
	[207.126.144.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AE11104250
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:34:58 +0100 (CET)
In-Reply-To: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, spear-devel@list.st.com, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch add Kconfig and Makefile to support SPEAr Audio driver

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/Kconfig  |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/Makefile |   16 ++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
new file mode 100644
index 0000000..4ab9154
--- /dev/null
+++ b/sound/soc/spear/Kconfig
@@ -0,0 +1,46 @@
+config SND_SOC_SPEAR_EVM
+	tristate "SoC Audio support for SPEAr EVM"
+	select SND_SOC_DESIGNWARE_I2S
+	select SND_SOC_STA529
+	select SND_SOC_SPEAR_PCM
+	help
+	 Say Y if you want to add support for SoC audio on SPEAr
+	 platform
+
+config SND_SOC_SPEAR1340_EVM
+	tristate "SoC Audio support for SPEAr1340 EVM"
+	select SND_SOC_DESIGNWARE_I2S
+	select SND_SOC_STA529
+	select SND_SOC_SPEAR_SPDIF_OUT
+	select SND_SOC_SPEAR_SPDIF_IN
+	select SND_SOC_SPDIF
+	select SND_SOC_SPEAR_PCM
+	help
+	 Say Y if you want to add support for SoC audio on SPEAr1340
+	 platform
+
+config SND_SOC_SPEAR_PCM
+	tristate "SoC Audio for the ST chip"
+	depends on SND_SOC_DESIGNWARE_I2S || SND_SOC_SPEAR_SPDIF_OUT || \
+		SND_SOC_SPEAR_SPDIF_IN
+	help
+	 Say Y or M if you want to add support for any of the audio
+	 controllers (I2S/SPDIF). You will also need to select
+	 the audio interface codecs to support below.
+
+config SND_SOC_DESIGNWARE_I2S
+	tristate "Synopsys I2S Device Driver"
+	help
+	 Say Y or M if you want to add support for I2S driver for
+	 Synopsys desigwnware I2S device. The device supports upto
+	 maximum of 8 channels each for play, record or both.
+
+config SND_SOC_SPEAR_SPDIF_OUT
+	tristate "SPEAr SPDIF Out Device Driver"
+	help
+	 Say Y or M if you want to add support for SPDIF OUT driver.
+
+config SND_SOC_SPEAR_SPDIF_IN
+	tristate "SPEAr SPDIF IN Device Driver"
+	help
+	 Say Y or M if you want to add support for SPDIF IN driver.
diff --git a/sound/soc/spear/Makefile b/sound/soc/spear/Makefile
new file mode 100644
index 0000000..bc49e75
--- /dev/null
+++ b/sound/soc/spear/Makefile
@@ -0,0 +1,16 @@
+# SPEAr Platform Support
+snd-soc-pcm-objs := spear_pcm.o
+snd-soc-i2s-objs := designware_i2s.o
+snd-soc-spdif-in-objs := spdif_in.o
+snd-soc-spdif-out-objs := spdif_out.o
+
+obj-$(CONFIG_SND_SOC_SPEAR_PCM) += snd-soc-pcm.o
+obj-$(CONFIG_SND_SOC_DESIGNWARE_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SOC_SPEAR_SPDIF_IN) += snd-soc-spdif-in.o
+obj-$(CONFIG_SND_SOC_SPEAR_SPDIF_OUT) += snd-soc-spdif-out.o
+
+# SPEAr Machine Support
+snd-soc-evb-objs := spear_evb.o
+
+obj-$(CONFIG_SND_SOC_SPEAR_EVM) += snd-soc-evb.o
+obj-$(CONFIG_SND_SOC_SPEAR1340_EVM) += snd-soc-evb.o
-- 
1.7.2.2
