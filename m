From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V4 4/5] sound: asoc: Adding Kconfig and
	Makefile to support SPEAr13XX ASoC driver
Date: Mon, 6 Jun 2011 11:27:35 +0530
Message-ID: <1307339856-30656-5-git-send-email-rajeev-dlh.kumar@st.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-4-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 43C7324141
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 07:59:04 +0200 (CEST)
In-Reply-To: <1307339856-30656-4-git-send-email-rajeev-dlh.kumar@st.com>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds Kconfig and Makefile to support SPEAr13XX ASoC driver

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/Kconfig  |   19 +++++++++++++++++++
 sound/soc/spear/Makefile |   12 ++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
new file mode 100644
index 0000000..666f95f
--- /dev/null
+++ b/sound/soc/spear/Kconfig
@@ -0,0 +1,19 @@
+config SND_SOC_SPEAR_PCM
+	tristate "SoC Audio for the ST chip"
+	help
+	 Say Y or M if you want to add support for codecs attached to
+	 the I2S interface. You will also need
+	 to select the audio interfaces to support below.
+
+config SND_SOC_SPEAR_I2S
+	tristate
+
+config SND_SOC_SPEAR_EVM
+	tristate "SoC Audio support for Spear EVM"
+	depends on SND_SOC_SPEAR_PCM
+	select SND_SOC_SPEAR_I2S
+	select SND_SOC_STA529
+	help
+	 A driver for the EVM machine.
+	 Say Y if you want to select audio on ST SPEAR board
+
diff --git a/sound/soc/spear/Makefile b/sound/soc/spear/Makefile
new file mode 100644
index 0000000..cc0972e
--- /dev/null
+++ b/sound/soc/spear/Makefile
@@ -0,0 +1,12 @@
+# SPEAR Platform Support
+snd-soc-pcm-objs := spear13xx-pcm.o
+snd-soc-i2s-objs := spear13xx-i2s.o
+
+obj-$(CONFIG_SND_SOC_SPEAR_PCM) += snd-soc-pcm.o
+obj-$(CONFIG_SND_SOC_SPEAR_I2S) += snd-soc-i2s.o
+
+# SPEAR Machine Support
+snd-soc-evb-objs := evb_sta529.o
+
+obj-$(CONFIG_SND_SOC_SPEAR_EVM) += snd-soc-evb.o
+
-- 
1.6.0.2
