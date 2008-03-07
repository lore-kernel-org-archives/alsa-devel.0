From: Pawel MOLL <pawel.moll@st.com>
Subject: [PATCH] Fix for alsa-lib cross-compilation problems
	with	ALSA_CONFIG_DIR and ALSA_PLUGIN_DIR
Date: Fri, 07 Mar 2008 15:56:21 +0000
Message-ID: <1204905381.22735.20.camel@bri1004.bri.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s200aog12.obsmtp.com (s200aog12.obsmtp.com [207.126.144.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 59B1010391E
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 17:11:08 +0100 (CET)
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25778DB02
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 16:11:02 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2D264C0EC
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 15:56:23 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix for alsa-lib cross-compilation problems with ALSA_CONFIG_DIR and ALSA_PLUGIN_DIR

"./configure" options for selecting ALSA configuration (default
/usr/share/alsa) and plugin (/usr/lib/alsa-lib) directories introduced
by alsa-hg/alsa-lib changeset 2284 cause problems with cross-compilation
and packaging - there is no way to redefine them in runtime, during
installation phase.

This patch adds a level of indirection between constants and their
usage - alsaconfigdir for ALSA_CONFIG_DIR and alsaplugindir for 
ALSA_PLUGIN_DIR - which can be redefined during "make install" stage.

Signed-off-by: Pawel MOLL <pawel.moll@st.com>
---
Index: alsa-lib-1.0.16/modules/mixer/simple/Makefile.am
===================================================================
--- alsa-lib-1.0.16.orig/modules/mixer/simple/Makefile.am
+++ alsa-lib-1.0.16/modules/mixer/simple/Makefile.am
@@ -1,4 +1,5 @@
-pkglibdir = @ALSA_PLUGIN_DIR@/smixer
+alsaplugindir = @ALSA_PLUGIN_DIR@
+pkglibdir = $(alsaplugindir)/smixer
 pythonlibs = @PYTHON_LIBS@
 pythonincludes = @PYTHON_INCLUDES@
 
Index: alsa-lib-1.0.16/src/conf/Makefile.am
===================================================================
--- alsa-lib-1.0.16.orig/src/conf/Makefile.am
+++ alsa-lib-1.0.16/src/conf/Makefile.am
@@ -10,5 +10,6 @@ endif
 
 EXTRA_DIST = $(cfg_files)
 
-alsadir = @ALSA_CONFIG_DIR@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+alsadir = $(alsaconfigdir)
 alsa_DATA = $(cfg_files)
Index: alsa-lib-1.0.16/src/conf/cards/Makefile.am
===================================================================
--- alsa-lib-1.0.16.orig/src/conf/cards/Makefile.am
+++ alsa-lib-1.0.16/src/conf/cards/Makefile.am
@@ -1,4 +1,5 @@
-alsadir = @ALSA_CONFIG_DIR@/cards
+alsaconfigdir = @ALSA_CONFIG_DIR@
+alsadir = $(alsaconfigdir)/cards
 cfg_files = aliases.conf \
 	AACI.conf \
 	ATIIXP.conf \
@@ -58,7 +59,7 @@ endif
 alsa_DATA = $(cfg_files)
 
 if BUILD_ALISP
-SI7018dir = @ALSA_CONFIG_DIR@/cards/SI7018
+SI7018dir = $(alsaconfigdir)/cards/SI7018
 SI7018_files = \
 	SI7018/sndoc-mixer.alisp \
 	SI7018/sndop-mixer.alisp
Index: alsa-lib-1.0.16/src/conf/pcm/Makefile.am
===================================================================
--- alsa-lib-1.0.16.orig/src/conf/pcm/Makefile.am
+++ alsa-lib-1.0.16/src/conf/pcm/Makefile.am
@@ -7,5 +7,6 @@ cfg_files = default.conf front.conf rear
 
 EXTRA_DIST = $(cfg_files)
 
-alsadir = @ALSA_CONFIG_DIR@/pcm
+alsaconfigdir = @ALSA_CONFIG_DIR@
+alsadir = $(alsaconfigdir)/pcm
 alsa_DATA = $(cfg_files)
