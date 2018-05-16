From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] MAINTAINERS: update sound/soc/intel maintainers
Date: Wed, 16 May 2018 14:48:49 -0500
Message-ID: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The information for Intel SoC drivers was not updated for several
years. Add myself, Liam and Keyon (Jie) as maintainers to get notified
of contributions and bug reports. As discussed with Mark and Takashi,
I'll also monitor alsa-devel and ack Intel patches as necessary.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e83cee26e195..d70add4c253b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7030,14 +7030,13 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
-INTEL ASoC BDW/HSW DRIVERS
+INTEL ASoC DRIVERS
+M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Jie Yang <yang.jie@linux.intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-F:	sound/soc/intel/common/sst-dsp*
-F:	sound/soc/intel/common/sst-firmware.c
-F:	sound/soc/intel/boards/broadwell.c
-F:	sound/soc/intel/haswell/
+F:	sound/soc/intel/
 
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
-- 
2.14.1
