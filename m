From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] alsa-driver-build/Makefile: Support
	CONFIG_SND_KERNELDIR
Date: Fri, 20 Aug 2010 09:07:51 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE37665B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FF3F24555
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:07:55 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Some kernels define CONFIG_SND_KERNELDIR rather than CONFIG_SND_KERNELBUILD.
If the latter is not set, then use the former.

Signed-off-by: Stephen Warren <swarren@swarren-lx2.nvidia.com>
---
 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 9af188f..59c477c 100644
--- a/Makefile
+++ b/Makefile
@@ -157,6 +157,12 @@ all-deps: toplevel.config.in acinclude.m4 include/config1.h.in
 include/sndversions.h:
 	$(MAKE) dep
 
+ifdef NEW_KBUILD
+  ifeq ("$(CONFIG_SND_KERNELBUILD)", "")
+    override CONFIG_SND_KERNELBUILD := $(CONFIG_SND_KERNELDIR)
+  endif
+endif
+
 .PHONY: compile
 compile: include/sndversions.h
 ifdef NEW_KBUILD
-- 
1.6.3.3
nvpublic
