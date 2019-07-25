From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 37/40] soundwire: cadence_master: add hw_reset capability in debugfs
Date: Thu, 25 Jul 2019 18:40:29 -0500
Message-ID: <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This is to kick devices into reset and see what software does

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fa7230b0f200..53278aa2436f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -331,6 +331,25 @@ static const struct file_operations cdns_reg_fops = {
 	.llseek = default_llseek,
 };
 
+static int cdns_hw_reset(void *data, u64 value)
+{
+	struct sdw_cdns *cdns = data;
+	int ret;
+
+	if (value != 1)
+		return 0;
+
+	dev_info(cdns->dev, "starting link hw_reset\n");
+
+	ret = sdw_cdns_exit_reset(cdns);
+
+	dev_info(cdns->dev, "link hw_reset done\n");
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
+
 /**
  * sdw_cdns_debugfs_init() - Cadence debugfs init
  * @cdns: Cadence instance
@@ -339,6 +358,9 @@ static const struct file_operations cdns_reg_fops = {
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 {
 	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
+
+	debugfs_create_file_unsafe("cdns-hw-reset", 0200, root, cdns,
+				   &cdns_hw_reset_fops);
 }
 EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
 
-- 
2.20.1
