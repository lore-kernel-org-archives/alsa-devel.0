From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] MAINTAINERS: ASoC: add maintainer for Intel
	BDW/HSW ASoC driver
Date: Mon,  2 Feb 2015 16:55:27 +0800
Message-ID: <1422867327-9443-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A10B2604BB
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 09:53:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Adding myself as the Intel BDW/HSW ASoC driver maintainer.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Acked-by: Liam Girdwood <lgirdwood@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc1e9a8..78a0913 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4943,6 +4943,16 @@ F:	Documentation/input/multi-touch-protocol.txt
 F:	drivers/input/input-mt.c
 K:	\b(ABS|SYN)_MT_
 
+INTEL ASoC BDW/HSW DRIVERS
+M:	Jie Yang <yang.jie@linux.intel.com>
+L:	alsa-devel@alsa-project.org
+S:	Supported
+F:	sound/soc/intel/sst-haswell*
+F:	sound/soc/intel/sst-dsp*
+F:	sound/soc/intel/sst-firmware.c
+F:	sound/soc/intel/broadwell.c
+F:	sound/soc/intel/haswell.c
+
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
 M:	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
-- 
1.9.1
