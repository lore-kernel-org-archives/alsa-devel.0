From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 04/14] SoundWire: Add device_id table for SoundWire bus
Date: Fri, 21 Oct 2016 18:11:02 +0530
Message-ID: <1477053673-16021-5-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Add device_id table for the SoundWire Master and Slave devices
and driver registration.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/mod_devicetable.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ed84c07..f443152 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -672,5 +672,18 @@ struct fsl_mc_device_id {
 	const char obj_type[16];
 };
 
+/* SoundWire */
+#define SOUNDWIRE_NAME_SIZE       32
+#define SOUNDWIRE_MODULE_PREFIX "sdw:"
+
+struct sdw_slave_id {
+	char name[SOUNDWIRE_NAME_SIZE];
+	kernel_ulong_t driver_data;      /* Data private to the driver */
+};
+
+struct sdw_master_id {
+	char name[SOUNDWIRE_NAME_SIZE];
+	kernel_ulong_t driver_data;     /* Data private to the driver */
+};
 
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
1.7.9.5
