From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v8 06/10] soundwire: Add support to lock across
	bus instances
Date: Fri, 27 Jul 2018 14:44:13 +0530
Message-ID: <1532682857-604-7-git-send-email-shreyas.nc@intel.com>
References: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 937842677BB
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 11:14:45 +0200 (CEST)
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

From: Sanyog Kale <sanyog.r.kale@intel.com>

Currently, the stream concept is limited to single Master and one
or more Codecs.

This patch extends the concept to support multiple Master(s)
sharing the same reference clock and synchronized in the hardware.
Modify sdw_stream_runtime to support a list of sdw_master_runtime
for the same. The existing reference to a single m_rt is removed
in the next patch.

Typically to lock, one would acquire a global lock and then lock
bus instances. In this case, the caller framework(ASoC DPCM)
guarantees that stream operations on a card are always serialized.
So, there is no race condition and hence no need for global lock.

Bus lock(s) are acquired to reconfigure the bus while the stream
is set-up.
So, we add sdw_acquire_bus_lock()/sdw_release_bus_lock() APIs which
are used only to reconfigure the bus.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/bus.h       |  2 ++
 drivers/soundwire/stream.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  4 ++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 3b15c4e..b6cfbdf 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -99,6 +99,7 @@ struct sdw_slave_runtime {
  * this stream, can be zero.
  * @slave_rt_list: Slave runtime list
  * @port_list: List of Master Ports configured for this stream, can be zero.
+ * @stream_node: sdw_stream_runtime master_list node
  * @bus_node: sdw_bus m_rt_list node
  */
 struct sdw_master_runtime {
@@ -108,6 +109,7 @@ struct sdw_master_runtime {
 	unsigned int ch_count;
 	struct list_head slave_rt_list;
 	struct list_head port_list;
+	struct list_head stream_node;
 	struct list_head bus_node;
 };
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 28d4147..c6e497d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -747,6 +747,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
 		return NULL;
 
 	stream->name = stream_name;
+	INIT_LIST_HEAD(&stream->master_list);
 	stream->state = SDW_STREAM_ALLOCATED;
 
 	return stream;
@@ -1245,6 +1246,48 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 	return NULL;
 }
 
+/**
+ * sdw_acquire_bus_lock: Acquire bus lock for all Master runtime(s)
+ *
+ * @stream: SoundWire stream
+ *
+ * Acquire bus_lock for each of the master runtime(m_rt) part of this
+ * stream to reconfigure the bus.
+ * NOTE: This function is called from SoundWire stream ops and is
+ * expected that a global lock is held before acquiring bus_lock.
+ */
+static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_bus *bus = NULL;
+
+	/* Iterate for all Master(s) in Master list */
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+
+		mutex_lock(&bus->bus_lock);
+	}
+}
+
+/**
+ * sdw_release_bus_lock: Release bus lock for all Master runtime(s)
+ *
+ * @stream: SoundWire stream
+ *
+ * Release the previously held bus_lock after reconfiguring the bus.
+ */
+static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_bus *bus = NULL;
+
+	/* Iterate for all Master(s) in Master list */
+	list_for_each_entry_reverse(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		mutex_unlock(&bus->bus_lock);
+	}
+}
+
 static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt = stream->m_rt;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 962971e..ccd8dcdf 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -769,6 +769,9 @@ struct sdw_stream_params {
  * @state: Current state of the stream
  * @type: Stream type PCM or PDM
  * @m_rt: Master runtime
+ * @master_list: List of Master runtime(s) in this stream.
+ * master_list can contain only one m_rt per Master instance
+ * for a stream
  */
 struct sdw_stream_runtime {
 	char *name;
@@ -776,6 +779,7 @@ struct sdw_stream_runtime {
 	enum sdw_stream_state state;
 	enum sdw_stream_type type;
 	struct sdw_master_runtime *m_rt;
+	struct list_head master_list;
 };
 
 struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
-- 
2.7.4
