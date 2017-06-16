From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 2/7] ASoC: stm32: change SAI configuration flag
Date: Fri, 16 Jun 2017 14:15:29 +0200
Message-ID: <1497615334-7156-3-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Use a specific flag for SAI interface instead
of common stm32 asoc flag.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig  | 10 +++++++---
 sound/soc/stm/Makefile |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 972970f..d747993 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -1,8 +1,12 @@
-menuconfig SND_SOC_STM32
-	tristate "STMicroelectronics STM32 SOC audio support"
+menu "STMicroelectronics STM32 SOC audio support"
+
+config SND_SOC_STM32_SAI
+	tristate "STM32 SAI interface (Serial Audio Interface) support"
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
-	  Say Y if you want to enable ASoC-support for STM32
+	  Say Y if you want to enable SAI for STM32
+
+endmenu
diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
index e466a47..386ce4b 100644
--- a/sound/soc/stm/Makefile
+++ b/sound/soc/stm/Makefile
@@ -1,6 +1,6 @@
 # SAI
 snd-soc-stm32-sai-sub-objs := stm32_sai_sub.o
-obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai-sub.o
+obj-$(CONFIG_SND_SOC_STM32_SAI) += snd-soc-stm32-sai-sub.o
 
 snd-soc-stm32-sai-objs := stm32_sai.o
-obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai.o
+obj-$(CONFIG_SND_SOC_STM32_SAI) += snd-soc-stm32-sai.o
-- 
1.9.1
