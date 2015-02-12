From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V5 11/12] ASoC: Allow for building QCOM drivers
Date: Wed, 11 Feb 2015 18:10:14 -0800
Message-ID: <1423707015-14527-12-git-send-email-kwestfie@codeaurora.org>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
