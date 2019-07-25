From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 02/40] soundwire: cadence_master: add
	debugfs register dump
Date: Thu, 25 Jul 2019 18:39:54 -0500
Message-ID: <20190725234032.21152-3-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CDD1F800F5
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 01:41:03 +0200 (CEST)
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Add debugfs file to dump the Cadence master registers

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
is the use of scnprintf to avoid known issues with snprintf.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 98 ++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  2 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index ff4badc9b3de..91e8bacb83e3 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -8,6 +8,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -223,6 +224,103 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+/*
+ * debugfs
+ */
+
+#define RD_BUF (2 * PAGE_SIZE)
+
+static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
+			    char *buf, size_t pos, unsigned int reg)
+{
+	return scnprintf(buf + pos, RD_BUF - pos,
+			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
+}
+
+static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct sdw_cdns *cdns = file->private_data;
+	char *buf;
+	ssize_t ret;
+	int i, j;
+
+	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
+	for (i = 0; i < 8; i++) /* 8 MCP registers */
+		ret += cdns_sprintf(cdns, buf, ret, i * 4);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nStatus & Intr Registers\n");
+	for (i = 0; i < 13; i++) /* 13 Status & Intr registers */
+		ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_STAT + i * 4);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nSSP & Clk ctrl Registers\n");
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn B0 Registers\n");
+	for (i = 0; i < 7; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret,
+				 "\nDP-%d\n", i);
+		for (j = 0; j < 6; j++)
+			ret += cdns_sprintf(cdns, buf, ret,
+					CDNS_DPN_B0_CONFIG(i) + j * 4);
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn B1 Registers\n");
+	for (i = 0; i < 7; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret,
+				 "\nDP-%d\n", i);
+
+		for (j = 0; j < 6; j++)
+			ret += cdns_sprintf(cdns, buf, ret,
+					CDNS_DPN_B1_CONFIG(i) + j * 4);
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn Control Registers\n");
+	for (i = 0; i < 7; i++)
+		ret += cdns_sprintf(cdns, buf, ret,
+				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nPDIn Config Registers\n");
+	for (i = 0; i < 7; i++)
+		ret += cdns_sprintf(cdns, buf, ret, CDNS_PDI_CONFIG(i));
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations cdns_reg_fops = {
+	.open = simple_open,
+	.read = cdns_reg_read,
+	.llseek = default_llseek,
+};
+
+/**
+ * sdw_cdns_debugfs_init() - Cadence debugfs init
+ * @cdns: Cadence instance
+ * @root: debugfs root
+ */
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
+{
+	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
+}
+EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
+
 /*
  * IO Calls
  */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index fe2af62958b1..c0bf6ff00a44 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -163,6 +163,8 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
+
 int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			struct sdw_cdns_streams *stream,
 			u32 ch, u32 dir);
-- 
2.20.1
