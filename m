From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 8/9] ASoC: Allow for building QCOM drivers
Date: Wed, 19 Nov 2014 10:52:48 -0800
Message-ID: <1416423169-21865-9-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Allow for the QCOM LPASS drivers to build.

Change-Id: Ic870d8e9487cebe634c8bd2f1c7263c27237febc
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/Kconfig  | 1 +
 sound/soc/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 7d5d6444a83737ffa3c01acbe1925de619e0390a..b98eebf0e30bba19ec24acc7f0e6ab155e5e602b 100644
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
index 865e090c80616024a552da5e33d2796b9be1dbbd..3d78a8d874dc98dd6219b33e3f2c100ef0334bfc 100644
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
1.8.2.1
