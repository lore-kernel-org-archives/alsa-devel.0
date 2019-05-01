From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 16/22] soundwire: intel: protect macro parameters
Date: Wed,  1 May 2019 10:57:39 -0500
Message-ID: <20190501155745.21806-17-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Extra parentheses required here

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 56d6c1dda0ff..8c653a563534 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -24,18 +24,18 @@
 #define SDW_SHIM_IPPTR			0x8
 #define SDW_SHIM_SYNC			0xC
 
-#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * x)
-#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * x)
-#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * x)
-#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * x)
-#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * x)
-#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * x)
-
-#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * x) + (0x2 * y))
-#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * x) + (0x2 * y))
-#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * x)
-#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * x)
-#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * x)
+#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
+#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * (x))
+#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * (x))
+#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * (x))
+#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * (x))
+#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * (x))
+
+#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * (x))
+#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
 
 #define SDW_SHIM_WAKEEN			0x190
 #define SDW_SHIM_WAKESTS		0x192
@@ -82,7 +82,7 @@
 #define SDW_SHIM_WAKESTS_STATUS		BIT(0)
 
 /* Intel ALH Register definitions */
-#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * x))
+#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
 
 #define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
-- 
2.17.1
