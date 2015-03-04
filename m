From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V7 01/10] MAINTAINERS: Add QCOM audio ASoC maintainer
Date: Tue,  3 Mar 2015 16:21:50 -0800
Message-ID: <1425428519-12224-2-git-send-email-kwestfie@codeaurora.org>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add maintainers for the Qualcomm Technologies
sound drivers.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8cf9a8ac0078f8ca1bc99d9c48f8197214a..9514b794b74d7fb93072bbdbaefaaa79df38c5fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5254,6 +5254,13 @@ F:	drivers/char/ipmi/
 F:	include/linux/ipmi*
 F:	include/uapi/linux/ipmi*
 
+QCOM AUDIO (ASoC) DRIVERS
+M:	Patrick Lai <plai@codeaurora.org>
+M:	Banajit Goswami <bgoswami@codeaurora.org>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/qcom/
+
 IPS SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi@vger.kernel.org
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
