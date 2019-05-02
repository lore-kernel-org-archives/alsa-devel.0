From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 14/14] soundwire: remove multiple blank lines
Date: Thu,  2 May 2019 16:29:30 +0530
Message-ID: <20190502105930.9889-15-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA6AF89756
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:49 +0200 (CEST)
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

Multi-blank lines do not help readability so remove them

Checkpatch complains:
CHECK: Please don't use multiple blank lines

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/soundwire/sdw_registers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index e75b2e3cf93d..a686f7988156 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -73,7 +73,6 @@
 #define SDW_SCP_INTSTAT2_SCP3_CASCADE		BIT(7)
 #define SDW_SCP_INTSTAT2_PORT4_10		GENMASK(6, 0)
 
-
 #define SDW_SCP_INTSTAT3			0x43
 #define SDW_SCP_INTSTAT3_PORT11_14		GENMASK(3, 0)
 
-- 
2.20.1
