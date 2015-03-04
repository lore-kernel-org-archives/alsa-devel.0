From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V7 09/10] ASoC: Allow for building QCOM drivers
Date: Tue,  3 Mar 2015 16:21:58 -0800
Message-ID: <1425428519-12224-10-git-send-email-kwestfie@codeaurora.org>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Allow for the Qualcomm Technologies ASoC drivers
to build.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/Kconfig  | 1 +
 sound/soc/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index dcc79aa0236b548bfe5408fe56689241fc597e97..3ba52da18bc69a9bb41c84627cfc7d08f47e3bf0 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -47,6 +47,7 @@ source "sound/soc/kirkwood/Kconfig"
 source "sound/soc/intel/Kconfig"
 source "sound/soc/mxs/Kconfig"
 source "sound/soc/pxa/Kconfig"
+source "sound/soc/qcom/Kconfig"
 source "sound/soc/rockchip/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 5b3c8f67c8db7a29ff7199a6103d445428978125..974ba708b4826a03077a58251434a311542d5e3c 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
 obj-$(CONFIG_SND_SOC)	+= kirkwood/
 obj-$(CONFIG_SND_SOC)	+= pxa/
+obj-$(CONFIG_SND_SOC)	+= qcom/
 obj-$(CONFIG_SND_SOC)	+= rockchip/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
