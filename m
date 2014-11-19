From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 1/9] MAINTAINERS: Add QCOM audio ASoC maintainer
Date: Wed, 19 Nov 2014 10:52:41 -0800
Message-ID: <1416423169-21865-2-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Change-Id: I3e33dcff96e85c7be790f9b84d7755858a52644e
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f712785554a691f7f31dba57b600102b32554e..fe9b336a3b91e641abc8cbaab3fdcf6a2696026a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5093,6 +5093,13 @@ F:	drivers/char/ipmi/
 F:	include/linux/ipmi*
 F:	include/uapi/linux/ipmi*
 
+QCOM AUDIO (ASoC) DRIVERS
+M:     Patrick Lai <plai@codeaurora.org>
+M:     Banajit Goswami <bgoswami@codeaurora.org>
+L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:     Supported
+F:     sound/soc/qcom/
+
 IPS SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi@vger.kernel.org
-- 
1.8.2.1
