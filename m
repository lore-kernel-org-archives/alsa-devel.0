From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] INSTALL: Building from kernel tree doc fixes
Date: Fri, 20 Aug 2010 12:10:42 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE37667F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A7D742441D
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 21:10:46 +0200 (CEST)
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

Does the following patch seem reasonable? It certainly describes the
Requirements in a way I personally understand better? Hopefully, it's
Accurate in any other scenarios that I'm not familiar with:-)




Be more explicit about which versions of which components need to match when
building the ALSA modules from a complete Linux kernel tree.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 INSTALL |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/INSTALL b/INSTALL
index 9ac4a85..641f12d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -199,21 +199,27 @@ Note: Some automake packages have missing aclocal program. Use newer version
 Compilation from Linux kernel tree
 ==================================
 
-If you have the linux kernel tree containing the corresponding ALSA
-kernel codes (the version must match), you can build with that instead
-of a separate alsa-kernel tree.  In this case, run
-utils/setup-alsa-kernel script in alsa-driver directory:
+If you have a complete Linux kernel tree, you can build the ALSA drivers from
+that kernel tree instead of from an alsa-kernel tree.  Note that the ALSA
+version included in that kernel tree must match the ALSA version of this 
+alsa-driver-build tree.  The ALSA modules built from the kernel tree will be
+built for the current running kernel, and not for the kernel version or
+configuration in the kernel tree.  In other words, the currently running
+kernel version and the kernel version in the kernel tree need not be
+identical.
+
+In this case, run utils/setup-alsa-kernel script in alsa-driver directory:
 
 	utils/setup-alsa-kernel YOUR-LINUX-KERNEL-TREE-PATH
 
-Then this script will create alsa-kernel sub-directory and make
-necessary symlinks automatically.  If you would like to copy the files
-instead of symlinks (e.g. make an alsa-driver tarball), pass -c option
-to setup-alsa-kernel
+This script will create alsa-kernel sub-directory and make necessary symlinks
+automatically.  If you would like to copy the files instead of creating
+symlinks (e.g. make an alsa-driver tarball), pass the -c option to
+setup-alsa-kernel:
 
 	utils/setup-alsa-kernel -c YOUR-LINUX-KERNEL-TREE-PATH
 
-After that, run gitcompile script.
+After that, run the gitcompile script.
 
 
 Cross-compiling
-- 
1.6.3.3
nvpublic
