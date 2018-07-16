From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v6 03/10] soundwire: Fix duplicate stream state
	assignment
Date: Tue, 17 Jul 2018 00:17:06 +0530
Message-ID: <20180716184713.13356-4-sanyog.r.kale@intel.com>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id F0444267750
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 20:46:54 +0200 (CEST)
In-Reply-To: <20180716184713.13356-1-sanyog.r.kale@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, shreyas.nc@intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

For a SoundWire stream it is expected that a Slave is added to the
stream before Master is added.

So, move the stream state to CONFIGURED after the first Slave is
added and remove the stream state assignment for Master add.
Along with these changes, add additional comments to explain the same.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
---
 drivers/soundwire/stream.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 8974a0fcda1b..e6ee4baef0a2 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1123,8 +1123,6 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
-	stream->state = SDW_STREAM_CONFIGURED;
-
 stream_error:
 	sdw_release_master_stream(stream);
 error:
@@ -1141,6 +1139,10 @@ EXPORT_SYMBOL(sdw_stream_add_master);
  * @stream: SoundWire stream
  * @port_config: Port configuration for audio stream
  * @num_ports: Number of ports
+ *
+ * It is expected that Slave is added before adding Master
+ * to the Stream.
+ *
  */
 int sdw_stream_add_slave(struct sdw_slave *slave,
 		struct sdw_stream_config *stream_config,
@@ -1186,6 +1188,12 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	if (ret)
 		goto stream_error;
 
+	/*
+	 * Change stream state to CONFIGURED on first Slave add.
+	 * Bus is not aware of number of Slave(s) in a stream at this
+	 * point so cannot depend on all Slave(s) to be added in order to
+	 * change stream state to CONFIGURED.
+	 */
 	stream->state = SDW_STREAM_CONFIGURED;
 	goto error;
 
-- 
2.13.0
