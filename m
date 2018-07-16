From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v6 10/10] soundwire: Fix acquiring bus lock
	twice during master release
Date: Tue, 17 Jul 2018 00:17:13 +0530
Message-ID: <20180716184713.13356-11-sanyog.r.kale@intel.com>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 465332677A1
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 20:47:17 +0200 (CEST)
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

As part of sdw_stream_remove_master(), sdw_stream_remove_slave() is called
which ends up acquiring bus lock twice.

So, fix it by performing Slave remove operations in
sdw_release_master_stream().

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
---
 drivers/soundwire/stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 6d437eb6a2d3..515b2f68bb7d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1038,9 +1038,10 @@ static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
-	list_for_each_entry_safe(s_rt, _s_rt,
-			&m_rt->slave_rt_list, m_rt_node)
-		sdw_stream_remove_slave(s_rt->slave, stream);
+	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		sdw_slave_port_release(s_rt->slave->bus, s_rt->slave, stream);
+		sdw_release_slave_stream(s_rt->slave, stream);
+	}
 
 	list_del(&m_rt->stream_node);
 	list_del(&m_rt->bus_node);
-- 
2.13.0
