From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v5 7/9] soundwire: keep track of Masters in a
	stream
Date: Thu,  5 Jul 2018 17:16:34 +0530
Message-ID: <1530791196-15483-8-git-send-email-shreyas.nc@intel.com>
References: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A92DB2676EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 13:48:35 +0200 (CEST)
In-Reply-To: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
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

A multi link bankswitch can be done if the hardware supports and
the stream is handled by multiple Master(s).

This preparatory patch adds support to track m_rt in a stream.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/stream.c    | 4 ++++
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index c1a2c3d..71d7e0b 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -759,6 +759,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
 	stream->name = stream_name;
 	INIT_LIST_HEAD(&stream->master_list);
 	stream->state = SDW_STREAM_ALLOCATED;
+	stream->m_rt_count = 0;
 
 	return stream;
 }
@@ -968,6 +969,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 	if (list_empty(&stream->master_list))
 		stream->state = SDW_STREAM_RELEASED;
 
+	stream->m_rt_count--;
 	mutex_unlock(&bus->bus_lock);
 
 	return 0;
@@ -1166,6 +1168,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
+	stream->m_rt_count++;
+
 	goto unlock;
 
 stream_error:
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 03df709..214e146 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -771,6 +771,7 @@ struct sdw_stream_params {
  * @master_list: List of Master runtime(s) in this stream.
  * master_list can contain only one m_rt per Master instance
  * for a stream
+ * @m_rt_count: Count of Master runtime(s) in this stream
  */
 struct sdw_stream_runtime {
 	char *name;
@@ -778,6 +779,7 @@ struct sdw_stream_runtime {
 	enum sdw_stream_state state;
 	enum sdw_stream_type type;
 	struct list_head master_list;
+	int m_rt_count;
 };
 
 struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
-- 
2.7.4
