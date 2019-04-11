From: libin.yang@intel.com
Subject: [PATCH v2 01/12] ASoC: intel: boards: define some
	general functions for hdac_hdmi
Date: Thu, 11 Apr 2019 22:09:42 +0800
Message-ID: <1554991793-14851-2-git-send-email-libin.yang@intel.com>
References: <1554991793-14851-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78838F808F6
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 16:25:58 +0200 (CEST)
In-Reply-To: <1554991793-14851-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Create hdac_hdmi_common.h and define some general functions related to
hdac_hdmi codec.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/hdac_hdmi_common.h | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 sound/soc/intel/boards/hdac_hdmi_common.h

diff --git a/sound/soc/intel/boards/hdac_hdmi_common.h b/sound/soc/intel/boards/hdac_hdmi_common.h
new file mode 100644
index 0000000..9e6f07a
--- /dev/null
+++ b/sound/soc/intel/boards/hdac_hdmi_common.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2019 Intel Corporation.
+ */
+
+/*
+ * This file includes the general functions related to hdac_hdmi codec,
+ * which is used by the different boards
+ */
+
+#ifndef __SOUND_SOC_HDAC_HDMI_COMMON
+#define __SOUND_SOC_HDAC_HDMI_COMMON
+
+static int hdac_hdmi_add_device_link(struct device *consumer,
+				     struct device *supplier,
+				     struct device_link **link)
+{
+	/*
+	 * Setup a device_link between machine device and HDMI codec device.
+	 * The machine device is the consumer and the HDMI codec device is
+	 * the supplier. With this setting, we can make sure that the audio
+	 * domain in display power will be always turned on before operating
+	 * on the HDMI audio codec registers.
+	 */
+	if (!(*link))
+		*link = device_link_add(consumer, supplier, DL_FLAG_RPM_ACTIVE | \
+					DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	if (!(*link))
+		dev_warn(consumer,
+			 "failed creating device_link for HDMI codec\n");
+
+	return 0;
+}
+
+#endif /* __SOUND_SOC_HDAC_HDMI_COMMON */
-- 
2.7.4
