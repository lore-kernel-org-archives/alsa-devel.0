From: fuweix.tang@intel.com
Subject: [PATCH v1 2/2] conf/ucm: Remove conf files of
	skylake-rt286 platform
Date: Tue, 21 Mar 2017 11:18:58 +0800
Message-ID: <c03e5d61e62808b3385bd6169cefc1a3ee3e8d11.1489719806.git.fuweix.tang@intel.com>
References: <cover.1489719806.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E906266FCB
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 04:19:08 +0100 (CET)
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

Remove conf files of skylake-rt286 platform from alsa-lib.
The files will be moved to alsa-ucm-conf repo.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
---
 configure.ac                                  |   1 -
 src/conf/ucm/Makefile.am                      |   2 +-
 src/conf/ucm/skylake-rt286/Hdmi1              |  20 ----
 src/conf/ucm/skylake-rt286/Hdmi2              |  20 ----
 src/conf/ucm/skylake-rt286/HiFi               | 129 --------------------------
 src/conf/ucm/skylake-rt286/Makefile.am        |   4 -
 src/conf/ucm/skylake-rt286/skylake-rt286.conf |  60 ------------
 7 files changed, 1 insertion(+), 235 deletions(-)
 delete mode 100644 src/conf/ucm/skylake-rt286/Hdmi1
 delete mode 100644 src/conf/ucm/skylake-rt286/Hdmi2
 delete mode 100644 src/conf/ucm/skylake-rt286/HiFi
 delete mode 100644 src/conf/ucm/skylake-rt286/Makefile.am
 delete mode 100644 src/conf/ucm/skylake-rt286/skylake-rt286.conf

diff --git a/configure.ac b/configure.ac
index 71bd852..9e916d7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -673,7 +673,6 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PAZ00/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
-	  src/conf/ucm/skylake-rt286/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index a11d324..7bf432e 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S chtrt5645 DB410c
diff --git a/src/conf/ucm/skylake-rt286/Hdmi1 b/src/conf/ucm/skylake-rt286/Hdmi1
deleted file mode 100644
index 0e00fc8..0000000
diff --git a/src/conf/ucm/skylake-rt286/Hdmi2 b/src/conf/ucm/skylake-rt286/Hdmi2
deleted file mode 100644
index 89b31aa..0000000
diff --git a/src/conf/ucm/skylake-rt286/HiFi b/src/conf/ucm/skylake-rt286/HiFi
deleted file mode 100644
index 41638f4..0000000
diff --git a/src/conf/ucm/skylake-rt286/Makefile.am b/src/conf/ucm/skylake-rt286/Makefile.am
deleted file mode 100644
index 9d6a85a..0000000
diff --git a/src/conf/ucm/skylake-rt286/skylake-rt286.conf b/src/conf/ucm/skylake-rt286/skylake-rt286.conf
deleted file mode 100644
index 3e43228..0000000
-- 
2.7.4
