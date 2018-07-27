From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v8 03/10] soundwire: Fix acquiring bus lock
	twice during master release
Date: Fri, 27 Jul 2018 14:44:10 +0530
Message-ID: <1532682857-604-4-git-send-email-shreyas.nc@intel.com>
References: <1532682857-604-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B402677AA
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 11:14:35 +0200 (CEST)
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

As part of sdw_stream_remove_master(), sdw_stream_remove_slave() is called
which results in bus lock being acquired twice.

So, fix it by performing specific Slave remove operations in
sdw_release_master_stream() instead of calling sdw_stream_remove_slave().

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index eaaa180..28d4147 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -899,9 +899,10 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
 	struct sdw_master_runtime *m_rt = stream->m_rt;
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
-	list_for_each_entry_safe(s_rt, _s_rt,
-			&m_rt->slave_rt_list, m_rt_node)
-		sdw_stream_remove_slave(s_rt->slave, stream);
+	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		sdw_slave_port_release(s_rt->slave->bus, s_rt->slave, stream);
+		sdw_release_slave_stream(s_rt->slave, stream);
+	}
 
 	list_del(&m_rt->bus_node);
 }
-- 
2.7.4
