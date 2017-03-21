From: fuweix.tang@intel.com
Subject: [PATCH v1 1/2] conf/ucm: Remove conf files of
	broxton-rt298 platform
Date: Tue, 21 Mar 2017 11:18:57 +0800
Message-ID: <b86821141a5716f02ea0d80a39f4dddb2e32aa67.1489719806.git.fuweix.tang@intel.com>
References: <cover.1489719806.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C6E13266FBD
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 04:19:07 +0100 (CET)
In-Reply-To: <cover.1489719806.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1489719806.git.fuweix.tang@intel.com>
References: <cover.1489719806.git.fuweix.tang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

Remove conf files of broxton-rt298 platform from alsa-lib repo.
The files will be moved to alsa-ucm-conf repo.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
---
 configure.ac                                  |   1 -
 src/conf/ucm/Makefile.am                      |   2 +-
 src/conf/ucm/broxton-rt298/Hdmi1              |  22 -----
 src/conf/ucm/broxton-rt298/Hdmi2              |  14 ---
 src/conf/ucm/broxton-rt298/HiFi               | 129 --------------------------
 src/conf/ucm/broxton-rt298/Makefile.am        |   4 -
 src/conf/ucm/broxton-rt298/broxton-rt298.conf |  58 ------------
 7 files changed, 1 insertion(+), 229 deletions(-)
 delete mode 100644 src/conf/ucm/broxton-rt298/Hdmi1
 delete mode 100644 src/conf/ucm/broxton-rt298/Hdmi2
 delete mode 100644 src/conf/ucm/broxton-rt298/HiFi
 delete mode 100644 src/conf/ucm/broxton-rt298/Makefile.am
 delete mode 100644 src/conf/ucm/broxton-rt298/broxton-rt298.conf

diff --git a/configure.ac b/configure.ac
index d645ab6..71bd852 100644
--- a/configure.ac
+++ b/configure.ac
@@ -684,7 +684,6 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/topology/bxtrt298/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
-	  src/conf/ucm/broxton-rt298/Makefile \
 	  utils/Makefile utils/alsa-lib.spec utils/alsa.pc)
 
 dnl Create asoundlib.h dynamically according to configure options
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index ea9b385..a11d324 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c broxton-rt298
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c
diff --git a/src/conf/ucm/broxton-rt298/Hdmi1 b/src/conf/ucm/broxton-rt298/Hdmi1
deleted file mode 100644
index 48514f4..0000000
diff --git a/src/conf/ucm/broxton-rt298/Hdmi2 b/src/conf/ucm/broxton-rt298/Hdmi2
deleted file mode 100644
index 764f8b9..0000000
diff --git a/src/conf/ucm/broxton-rt298/HiFi b/src/conf/ucm/broxton-rt298/HiFi
deleted file mode 100644
index 2e2d6fe..0000000
diff --git a/src/conf/ucm/broxton-rt298/Makefile.am b/src/conf/ucm/broxton-rt298/Makefile.am
deleted file mode 100644
index 80f480e..0000000
diff --git a/src/conf/ucm/broxton-rt298/broxton-rt298.conf b/src/conf/ucm/broxton-rt298/broxton-rt298.conf
deleted file mode 100644
index 3f3d0be..0000000
-- 
2.7.4
