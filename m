Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2930C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 08:33:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC7420709
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 08:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JA7Z0rFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC7420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8441171C;
	Tue, 19 May 2020 10:32:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8441171C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589877202;
	bh=VRqEGs4D+HnKJHQ4NWyc13cZsh58uhMYvgGh+NxUsiE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JA7Z0rFZo1s4ADfkJxCM64g0zvkPH4jaQUINdujXLFzVpfuN92nCSsfrwH7ajWxV9
	 w/vRM3jALktTed50PO3nqFaoqpb+nDcAC76teUMRmmcY6LVESIr87Goj4+vP74UwsC
	 3tN6CFBEodSKNZTjfsHhVhqLn1KpkmPKnLx+Y800=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 678C3F80291;
	Tue, 19 May 2020 10:30:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86239F80256; Tue, 19 May 2020 10:30:52 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E790EF80161
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 10:30:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E790EF80161
IronPort-SDR: EJc/OVcSiUzP9hyE4yIx4CiX3pkn8plduWVW7HCun7QWw83n9tWWO80VoaF9YlZ9BhMV9FVE3q
 Bt+RG1SgpPEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 01:30:45 -0700
IronPort-SDR: V5XC9tv8exP3gG6P7AtGtNEHOBH6QMa/lM81dPQnQQsHOKFyzf8vBwrwsrFs7Gm7mxMe7AeXdz
 oqkGXyk3fpJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; d="scan'208";a="264234012"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga003.jf.intel.com with ESMTP; 19 May 2020 01:30:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/3] soundwire: master: add sysfs support
Date: Tue, 19 May 2020 04:35:50 +0800
Message-Id: <20200518203551.2053-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add the master properties as attributes. The description is directly
derived from the MIPI DisCo specification.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-soundwire-master    | 23 +++++
 drivers/soundwire/master.c                    | 84 +++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-master b/Documentation/ABI/testing/sysfs-bus-soundwire-master
new file mode 100644
index 000000000000..46ef038d8722
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-master
@@ -0,0 +1,23 @@
+What:		/sys/bus/soundwire/devices/sdw-master-N/revision
+		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
+		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
+		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
+		/sys/bus/soundwire/devices/sdw-master-N/default_col
+		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
+		/sys/bus/soundwire/devices/sdw-master-N/default_row
+		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
+		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
+		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
+
+Date:		April 2020
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+		Bard Liao <yung-chuan.liao@linux.intel.com>
+		Vinod Koul <vkoul@kernel.org>
+
+Description:	SoundWire Master-N DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the Master
+		and are used by the bus to configure the Master. clk_stop_modes
+		is a bitmask for simplifications and combines the
+		clock-stop-mode0 and clock-stop-mode1 properties.
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 5411791e6aff..5f0b2189defe 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -8,6 +8,89 @@
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
 
+/*
+ * The sysfs for properties reflects the MIPI description as given
+ * in the MIPI DisCo spec
+ *
+ * Base file is:
+ *	sdw-master-N
+ *      |---- revision
+ *      |---- clk_stop_modes
+ *      |---- max_clk_freq
+ *      |---- clk_freq
+ *      |---- clk_gears
+ *      |---- default_row
+ *      |---- default_col
+ *      |---- dynamic_shape
+ *      |---- err_threshold
+ */
+
+#define sdw_master_attr(field, format_string)				\
+static ssize_t field##_show(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    char *buf)					\
+{									\
+	struct sdw_master_device *md = dev_to_sdw_master_device(dev);	\
+	return sprintf(buf, format_string, md->bus->prop.field);	\
+}									\
+static DEVICE_ATTR_RO(field)
+
+sdw_master_attr(revision, "0x%x\n");
+sdw_master_attr(clk_stop_modes, "0x%x\n");
+sdw_master_attr(max_clk_freq, "%d\n");
+sdw_master_attr(default_row, "%d\n");
+sdw_master_attr(default_col, "%d\n");
+sdw_master_attr(default_frame_rate, "%d\n");
+sdw_master_attr(dynamic_frame, "%d\n");
+sdw_master_attr(err_threshold, "%d\n");
+
+static ssize_t clock_frequencies_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct sdw_master_device *md = dev_to_sdw_master_device(dev);
+	ssize_t size = 0;
+	int i;
+
+	for (i = 0; i < md->bus->prop.num_clk_freq; i++)
+		size += sprintf(buf + size, "%8d ",
+				md->bus->prop.clk_freq[i]);
+	size += sprintf(buf + size, "\n");
+
+	return size;
+}
+static DEVICE_ATTR_RO(clock_frequencies);
+
+static ssize_t clock_gears_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sdw_master_device *md = dev_to_sdw_master_device(dev);
+	ssize_t size = 0;
+	int i;
+
+	for (i = 0; i < md->bus->prop.num_clk_gears; i++)
+		size += sprintf(buf + size, "%8d ",
+				md->bus->prop.clk_gears[i]);
+	size += sprintf(buf + size, "\n");
+
+	return size;
+}
+static DEVICE_ATTR_RO(clock_gears);
+
+static struct attribute *master_node_attrs[] = {
+	&dev_attr_revision.attr,
+	&dev_attr_clk_stop_modes.attr,
+	&dev_attr_max_clk_freq.attr,
+	&dev_attr_default_row.attr,
+	&dev_attr_default_col.attr,
+	&dev_attr_default_frame_rate.attr,
+	&dev_attr_dynamic_frame.attr,
+	&dev_attr_err_threshold.attr,
+	&dev_attr_clock_frequencies.attr,
+	&dev_attr_clock_gears.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(master_node);
+
 static void sdw_master_device_release(struct device *dev)
 {
 	struct sdw_master_device *md = dev_to_sdw_master_device(dev);
@@ -48,6 +131,7 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	md->dev.bus = &sdw_bus_type;
 	md->dev.type = &sdw_master_type;
 	md->dev.parent = parent;
+	md->dev.groups = master_node_groups;
 	md->dev.of_node = parent->of_node;
 	md->dev.fwnode = fwnode;
 	md->dev.dma_mask = parent->dma_mask;
-- 
2.17.1

