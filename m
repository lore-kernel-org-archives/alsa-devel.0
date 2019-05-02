From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 13/14] soundwire: add a blank line between
	functions
Date: Thu,  2 May 2019 16:29:29 +0530
Message-ID: <20190502105930.9889-14-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97287F89756
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:46 +0200 (CEST)
In-Reply-To: <20190502105930.9889-1-vkoul@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

For improving code readability it helps to have a blank line between
function so add when missing.

Checkpatch complains:
CHECK: Please use a blank line after function/struct/union/enum
declarations

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index debb67882df4..d01060dbee96 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -52,6 +52,7 @@ static int sdw_find_row_index(int row)
 	pr_warn("Requested row not found, selecting lowest row no: 48\n");
 	return 0;
 }
+
 static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 					  struct sdw_slave *slave,
 					  struct sdw_transport_params *t_params,
-- 
2.20.1
