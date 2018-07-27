From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v8 08/10] soundwire: keep track of Masters in a
	stream
Date: Fri, 27 Jul 2018 14:44:15 +0530
Message-ID: <1532682857-604-9-git-send-email-shreyas.nc@intel.com>
References: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C042677BA
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 11:15:13 +0200 (CEST)
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

A multi link bankswitch can be done if the hardware supports and
the stream is handled by multiple Master(s).

This preparatory patch adds support to track m_rt in a stream.
Modifying m_rt_count and usage is added as part of the next patch.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/stream.c    | 1 +
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 0d04d84..088b939 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -759,6 +759,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
 	stream->name = stream_name;
 	INIT_LIST_HEAD(&stream->master_list);
 	stream->state = SDW_STREAM_ALLOCATED;
+	stream->m_rt_count = 0;
 
 	return stream;
 }
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
