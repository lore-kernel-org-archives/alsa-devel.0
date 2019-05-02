From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 07/14] soundwire: add argument to function
	definition
Date: Thu,  2 May 2019 16:29:23 +0530
Message-ID: <20190502105930.9889-8-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCE84F8972A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:30 +0200 (CEST)
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

Checkpatch warns that function definition of __sdw_register_driver
misses argument, so add it

WARNING: function definition argument 'struct module *' should also have
an identifier name

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/soundwire/sdw_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index b7e198a035c9..9c756b5a0dfe 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -11,7 +11,7 @@ extern struct bus_type sdw_bus_type;
 #define sdw_register_driver(drv) \
 	__sdw_register_driver(drv, THIS_MODULE)
 
-int __sdw_register_driver(struct sdw_driver *drv, struct module *);
+int __sdw_register_driver(struct sdw_driver *drv, struct module *owner);
 void sdw_unregister_driver(struct sdw_driver *drv);
 
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
-- 
2.20.1
