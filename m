From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v8 01/10] soundwire: Fix duplicate stream state
	assignment
Date: Fri, 27 Jul 2018 14:44:08 +0530
Message-ID: <1532682857-604-2-git-send-email-shreyas.nc@intel.com>
References: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F216F2677A5
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 11:14:26 +0200 (CEST)
In-Reply-To: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

For a SoundWire stream it is expected that a Slave is added to the
stream before Master is added.

So, move the stream state to CONFIGURED after the first Slave is
added and remove the stream state assignment for Master add.
Along with these changes, add additional comments to explain the same.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/stream.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 8974a0f..e6ee4ba 100644
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
2.7.4
