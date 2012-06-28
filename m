From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V3 4/4] ASoC: SPEAr: Add Kconfig and Makefile
	to support SPEAr audio driver
Date: Thu, 28 Jun 2012 12:31:40 +0530
Message-ID: <3fcf853e01128ba9dd19c35e1ce23b08a3882896.1340862505.git.rajeev-dlh.kumar@st.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 06C94103B49
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 09:01:59 +0200 (CEST)
In-Reply-To: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
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

This patch add Kconfig and Makefile to support SPEAr Audio driver

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/Kconfig  |   22 ++++++++++++++++++++++
 sound/soc/spear/Makefile |    4 ++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/Kconfig
 create mode 100644 sound/soc/spear/Makefile

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
new file mode 100644
index 0000000..6ff9460
--- /dev/null
+++ b/sound/soc/spear/Kconfig
@@ -0,0 +1,22 @@
+config SND_SPEAR_SOC
+	tristate "SoC Audio for the ST chip"
+	depends on SND_DESIGNWARE_I2S || SND_SPEAR_SPDIF_OUT || \
+		SND_SPEAR_SPDIF_IN
+	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_STA529
+	select SND_SOC_SPDIF
+	select SND_SIMPLE_CARD
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
index 0000000..9f47bb4
--- /dev/null
+++ b/sound/soc/spear/Makefile
@@ -0,0 +1,4 @@
+# SPEAR Platform Support
+obj-$(CONFIG_SND_SPEAR_SOC) += spear_pcm.o
+obj-$(CONFIG_SND_SPEAR_SPDIF_IN) += spdif_in.o
+obj-$(CONFIG_SND_SPEAR_SPDIF_OUT) += spdif_out.o
-- 
1.7.0.4
