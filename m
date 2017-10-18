From: Mark Brown <broonie@kernel.org>
Subject: Applied "drm/amdgpu Moving amdgpu asic types to a
	separate file" to the asoc tree
Date: Wed, 18 Oct 2017 01:09:21 +0100
Message-ID: <E1e4bvF-00043S-CP@debutante>
References: <1501270294-31153-5-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B8F9D2673BA
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 02:12:13 +0200 (CEST)
In-Reply-To: <1501270294-31153-5-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, amd-gfx@lists.freedesktop.org, rajeevkumar.linux@gmail.com, broonie@kernel.org, dri-devel@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   drm/amdgpu Moving amdgpu asic types to a separate file

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1e4448648333a8fb7830a7a4b76c86e160a79b1e Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 28 Jun 2017 14:08:09 +0530
Subject: [PATCH] drm/amdgpu Moving amdgpu asic types to a separate file

Amdgpu asic types will be required for other drivers too.
Hence, its better to keep it in a separate include file.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 29 ++----------------
 include/drm/amd_asic_type.h              | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 27 deletions(-)
 create mode 100644 include/drm/amd_asic_type.h

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 70e8c20acb2f..3a49fbd8baf8 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -23,34 +23,9 @@
 #ifndef __AMD_SHARED_H__
 #define __AMD_SHARED_H__
 
-#define AMD_MAX_USEC_TIMEOUT		200000  /* 200 ms */
+#include <drm/amd_asic_type.h>
 
-/*
- * Supported ASIC types
- */
-enum amd_asic_type {
-	CHIP_TAHITI = 0,
-	CHIP_PITCAIRN,
-	CHIP_VERDE,
-	CHIP_OLAND,
-	CHIP_HAINAN,
-	CHIP_BONAIRE,
-	CHIP_KAVERI,
-	CHIP_KABINI,
-	CHIP_HAWAII,
-	CHIP_MULLINS,
-	CHIP_TOPAZ,
-	CHIP_TONGA,
-	CHIP_FIJI,
-	CHIP_CARRIZO,
-	CHIP_STONEY,
-	CHIP_POLARIS10,
-	CHIP_POLARIS11,
-	CHIP_POLARIS12,
-	CHIP_VEGA10,
-	CHIP_RAVEN,
-	CHIP_LAST,
-};
+#define AMD_MAX_USEC_TIMEOUT		200000  /* 200 ms */
 
 /*
  * Chip flags
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
new file mode 100644
index 000000000000..599028f66585
--- /dev/null
+++ b/include/drm/amd_asic_type.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright 2017 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __AMD_ASIC_TYPE_H__
+#define __AMD_ASIC_TYPE_H__
+/*
+ * Supported ASIC types
+ */
+enum amd_asic_type {
+	CHIP_TAHITI = 0,
+	CHIP_PITCAIRN,
+	CHIP_VERDE,
+	CHIP_OLAND,
+	CHIP_HAINAN,
+	CHIP_BONAIRE,
+	CHIP_KAVERI,
+	CHIP_KABINI,
+	CHIP_HAWAII,
+	CHIP_MULLINS,
+	CHIP_TOPAZ,
+	CHIP_TONGA,
+	CHIP_FIJI,
+	CHIP_CARRIZO,
+	CHIP_STONEY,
+	CHIP_POLARIS10,
+	CHIP_POLARIS11,
+	CHIP_POLARIS12,
+	CHIP_VEGA10,
+	CHIP_RAVEN,
+	CHIP_LAST,
+};
+
+#endif /*__AMD_ASIC_TYPE_H__ */
-- 
2.14.1
