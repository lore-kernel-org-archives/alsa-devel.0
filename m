From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 03/22] soundwire: fix alignment issues in header files
Date: Wed,  1 May 2019 10:57:26 -0500
Message-ID: <20190501155745.21806-4-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

use Linux style

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.h            | 12 ++++++------
 drivers/soundwire/cadence_master.h | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 2f8436584e7f..3048ca153f22 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -16,7 +16,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 #endif
 
 void sdw_extract_slave_id(struct sdw_bus *bus,
-			u64 addr, struct sdw_slave_id *id);
+			  u64 addr, struct sdw_slave_id *id);
 
 enum {
 	SDW_MSG_FLAG_READ = 0,
@@ -116,19 +116,19 @@ struct sdw_master_runtime {
 };
 
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
-				enum sdw_data_direction direction,
-				unsigned int port_num);
+					    enum sdw_data_direction direction,
+					    unsigned int port_num);
 int sdw_configure_dpn_intr(struct sdw_slave *slave, int port,
-					bool enable, int mask);
+			   bool enable, int mask);
 
 int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
-				struct sdw_defer *defer);
+		       struct sdw_defer *defer);
 
 #define SDW_READ_INTR_CLEAR_RETRY	10
 
 int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
-		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
+		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
 
 /* Read-Modify-Write Slave register */
 static inline int
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 75f7412cfbbd..fe2af62958b1 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -160,24 +160,24 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
 int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
-			struct sdw_cdns_stream_config config);
+		      struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
 int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			struct sdw_cdns_streams *stream,
 			u32 ch, u32 dir);
 int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
-			struct sdw_cdns_streams *stream,
-			struct sdw_cdns_port *port, u32 ch, u32 dir);
+			  struct sdw_cdns_streams *stream,
+			  struct sdw_cdns_port *port, u32 ch, u32 dir);
 void sdw_cdns_config_stream(struct sdw_cdns *cdns, struct sdw_cdns_port *port,
-			u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
+			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
 void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai);
+		       struct snd_soc_dai *dai);
 int sdw_cdns_pcm_set_stream(struct snd_soc_dai *dai,
-				void *stream, int direction);
+			    void *stream, int direction);
 int sdw_cdns_pdm_set_stream(struct snd_soc_dai *dai,
-				void *stream, int direction);
+			    void *stream, int direction);
 
 enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
@@ -187,7 +187,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
 
 enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
-		struct sdw_msg *msg, struct sdw_defer *defer);
+		    struct sdw_msg *msg, struct sdw_defer *defer);
 
 enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
@@ -195,5 +195,5 @@ cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
 int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
-		void *stream, bool pcm, int direction);
+			void *stream, bool pcm, int direction);
 #endif /* __SDW_CADENCE_H */
-- 
2.17.1
