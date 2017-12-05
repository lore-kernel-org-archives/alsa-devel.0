From: "Andrew F. Davis" <afd@ti.com>
Subject: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Tue, 5 Dec 2017 12:14:46 -0600
Message-ID: <20171205181448.18513-2-afd@ti.com>
References: <20171205181448.18513-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171205181448.18513-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Platform ASoC drivers are a lot like ASoC CODEC drivers in that they
both are independent pieces of a sound device, or "machine". Platform
drivers should be free of CODEC specifics and visa-versa. Both are then
used by the the "machine" driver to form the complete sound device.
This forms a hierarchy that makes it natural to group platform drivers
into their own directory, much like we group CODEC drivers already.

With this change, we will leave machine drivers in the top-level ASoC
directory and have CODECs and Platforms below. The machine drivers may
also be moved at some point into a grouping directory to further
enforce the logical separation intended by the ASoC framework.

Create the initial directory, Kconfig, and Makefile here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/Kconfig            | 3 +++
 sound/soc/Makefile           | 1 +
 sound/soc/platforms/Kconfig  | 7 +++++++
 sound/soc/platforms/Makefile | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 sound/soc/platforms/Kconfig
 create mode 100644 sound/soc/platforms/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index d22758165496..b8064e8b2bdf 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -75,6 +75,9 @@ source "sound/soc/ux500/Kconfig"
 source "sound/soc/xtensa/Kconfig"
 source "sound/soc/zte/Kconfig"
 
+# Supported platforms
+source "sound/soc/platforms/Kconfig"
+
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 5327f4d6c668..af578273548c 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SND_SOC_ACPI) += snd-soc-acpi.o
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= generic/
+obj-$(CONFIG_SND_SOC)	+= platforms/
 obj-$(CONFIG_SND_SOC)	+= adi/
 obj-$(CONFIG_SND_SOC)	+= amd/
 obj-$(CONFIG_SND_SOC)	+= atmel/
diff --git a/sound/soc/platforms/Kconfig b/sound/soc/platforms/Kconfig
new file mode 100644
index 000000000000..620d1f292246
--- /dev/null
+++ b/sound/soc/platforms/Kconfig
@@ -0,0 +1,7 @@
+#
+# SoC Platform Support Configuration
+#
+
+menu "Platform drivers"
+
+endmenu
diff --git a/sound/soc/platforms/Makefile b/sound/soc/platforms/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/sound/soc/platforms/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
-- 
2.15.0
