From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v7 05/10] soundwire: Initialize completion for
	defer messages
Date: Thu, 26 Jul 2018 17:12:37 +0530
Message-ID: <1532605362-19282-6-git-send-email-shreyas.nc@intel.com>
References: <1532605362-19282-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A2204267783
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 13:44:36 +0200 (CEST)
In-Reply-To: <1532605362-19282-1-git-send-email-shreyas.nc@intel.com>
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
index dcc0ff9..dbabd5e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -175,6 +175,7 @@ static inline int do_transfer_defer(struct sdw_bus *bus,
 
 	defer->msg = msg;
 	defer->length = msg->len;
+	init_completion(&defer->complete);
 
 	for (i = 0; i <= retry; i++) {
 		resp = bus->ops->xfer_msg_defer(bus, msg, defer);
-- 
2.7.4
