From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v6 02/10] soundwire: Initialize completion for
	defer messages
Date: Tue, 17 Jul 2018 00:17:05 +0530
Message-ID: <20180716184713.13356-3-sanyog.r.kale@intel.com>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id A3717267600
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 20:46:51 +0200 (CEST)
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

Deferred messages are async messages used to synchronize
transitions mostly while doing a bank switch on multi links.
On successful transitions these messages are marked complete
and thereby confirming that all the buses performed bank switch
successfully.

So, initialize the completion structure for the same.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index dcc0ff9f0c22..dbabd5e69343 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -175,6 +175,7 @@ static inline int do_transfer_defer(struct sdw_bus *bus,
 
 	defer->msg = msg;
 	defer->length = msg->len;
+	init_completion(&defer->complete);
 
 	for (i = 0; i <= retry; i++) {
 		resp = bus->ops->xfer_msg_defer(bus, msg, defer);
-- 
2.13.0
