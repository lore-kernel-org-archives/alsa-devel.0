From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 3/3] ASoC: xlnx: enable i2s driver build
Date: Sat, 8 Dec 2018 00:02:38 +0530
Message-ID: <1544207558-72508-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Enabled i2s driver build option.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/Kconfig         | 1 +
 sound/soc/Makefile        | 1 +
 sound/soc/xilinx/Kconfig  | 8 ++++++++
 sound/soc/xilinx/Makefile | 2 ++
 4 files changed, 12 insertions(+)
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 1cf11cf..d21659f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -73,6 +73,7 @@ source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/uniphier/Kconfig"
 source "sound/soc/ux500/Kconfig"
+source "sound/soc/xilinx/Kconfig"
 source "sound/soc/xtensa/Kconfig"
 source "sound/soc/zte/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a5f87..aff7b19 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= uniphier/
 obj-$(CONFIG_SND_SOC)	+= ux500/
+obj-$(CONFIG_SND_SOC)	+= xilinx/
 obj-$(CONFIG_SND_SOC)	+= xtensa/
 obj-$(CONFIG_SND_SOC)	+= zte/
diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
new file mode 100644
index 0000000..25e287f
--- /dev/null
+++ b/sound/soc/xilinx/Kconfig
@@ -0,0 +1,8 @@
+config SND_SOC_XILINX_I2S
+	tristate "Audio support for the the Xilinx I2S"
+	help
+	  Select this option to enable Xilinx I2S Audio. This enables
+	  I2S playback and capture using xilinx soft IP. In transmitter
+	  mode, IP receives audio in AES format, extracts PCM and sends
+	  PCM data. In receiver mode, IP receives PCM audio and
+	  encapsulates PCM in AES format and sends AES data.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
new file mode 100644
index 0000000..6c1209b
--- /dev/null
+++ b/sound/soc/xilinx/Makefile
@@ -0,0 +1,2 @@
+snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
+obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
-- 
2.7.4
