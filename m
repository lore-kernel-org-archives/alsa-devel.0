From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 02/14] soundwire: fix SPDX license for header
	files
Date: Thu,  2 May 2019 16:29:18 +0530
Message-ID: <20190502105930.9889-3-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8036BF896AA
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:18 +0200 (CEST)
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

Some more headers had C++ style SDPX line, fix that and change copyright
so that it is consistent with rest of the code in subsystem

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/soundwire/sdw.h           | 4 ++--
 include/linux/soundwire/sdw_registers.h | 4 ++--
 include/linux/soundwire/sdw_type.h      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index df313913e856..d9102af5e26c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-// Copyright(c) 2015-17 Intel Corporation.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SOUNDWIRE_H
 #define __SOUNDWIRE_H
diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index df472b1ab410..e75b2e3cf93d 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-// Copyright(c) 2015-17 Intel Corporation.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_REGISTERS_H
 #define __SDW_REGISTERS_H
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 9fd553e553e9..b7e198a035c9 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright(c) 2015-17 Intel Corporation.
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SOUNDWIRE_TYPES_H
 #define __SOUNDWIRE_TYPES_H
-- 
2.20.1
