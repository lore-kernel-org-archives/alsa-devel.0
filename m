From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 4/5] sound: asoc: Adding Kconfig and
	Makefile to support SPEAr13XX ASoC driver
Date: Tue, 29 Mar 2011 16:47:02 +0530
Message-ID: <1301397423-4693-5-git-send-email-rajeev-dlh.kumar@st.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
	[207.126.144.147])
	by alsa0.perex.cz (Postfix) with ESMTP id AC85B243E7
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 13:18:19 +0200 (CEST)
In-Reply-To: <1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
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
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds Kconfig and Makefile to support SPEAr13XX ASoC driver

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/Kconfig  |   19 +++++++++++++++++++
 sound/soc/spear/Makefile |    6 ++++++
 2 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
new file mode 100644
index 0000000..951f4d5
--- /dev/null
+++ b/sound/soc/spear/Kconfig
@@ -0,0 +1,19 @@
+config SND_SOC_SPEAR
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
+	depends on SND_SOC_SPEAR
+	select SND_SOC_SPEAR_I2S
+	select SND_SOC_STA529
+	help
+	 A driver for the EVM machine.
+	 Say Y if you want to select audio on ST SPEAR board
+
diff --git a/sound/soc/spear/Makefile b/sound/soc/spear/Makefile
new file mode 100644
index 0000000..d144eb2
--- /dev/null
+++ b/sound/soc/spear/Makefile
@@ -0,0 +1,6 @@
+# SPEAR Platform Support
+obj-$(CONFIG_SND_SOC_SPEAR) += spear13xx-pcm.o
+obj-$(CONFIG_SND_SOC_SPEAR_I2S) += spear13xx-i2s.o
+
+# SPEAR Machine Support
+obj-$(CONFIG_SND_SOC_SPEAR_EVM) += evb_sta529.o
-- 
1.6.0.2
