From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 01/11] MAINTAINERS: Add QCOM audio ASoC maintainer
Date: Mon,  8 Dec 2014 14:01:03 -0800
Message-ID: <1418076073-12623-2-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6bff3afaeaeb84b0a4fe99fbd941c38596473f4..0d862732ae301e25f2203e684da21249ae9b4094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5148,6 +5148,13 @@ F:	drivers/char/ipmi/
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
