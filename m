From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 11/14] soundwire: fix more typos
Date: Thu,  2 May 2019 16:29:27 +0530
Message-ID: <20190502105930.9889-12-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45656F8974A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:41 +0200 (CEST)
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

Found few more typos in the code, fix them

CHECK: 'and and' may be misspelled - perhaps 'and'?
CHECK: 'smaple' may be misspelled - perhaps 'sample'?

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index bffa535294ed..debb67882df4 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -89,7 +89,7 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 
 	/*
 	 * Data ports are FULL, SIMPLE and REDUCED. This function handles
-	 * FULL and REDUCED only and and beyond this point only FULL is
+	 * FULL and REDUCED only and beyond this point only FULL is
 	 * handled, so bail out if we are not FULL data port type
 	 */
 	if (type != SDW_DPN_FULL)
@@ -233,7 +233,7 @@ static int sdw_program_master_port_params(struct sdw_bus *bus,
 
 	/*
 	 * we need to set transport and port parameters for the port.
-	 * Transport parameters refers to the smaple interval, offsets and
+	 * Transport parameters refers to the sample interval, offsets and
 	 * hstart/stop etc of the data. Port parameters refers to word
 	 * length, flow mode etc of the port
 	 */
-- 
2.20.1
