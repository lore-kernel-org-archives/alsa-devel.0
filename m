From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] mixer: Don't install smixer modules unless
	python is enabled
Date: Mon, 14 Nov 2016 11:50:39 +0100
Message-ID: <20161114105039.11111-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 477D8265DF3
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 11:50:40 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E03CABD3
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 10:50:40 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Currently the whole smixer stuff depends on python, so it doesn't make
sense to install plugins partially when the python support is
disabled.

This patch changes Makefile.am not to install the smixer stuff at all
when the python support is disabled via configure script.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 modules/mixer/simple/Makefile.am | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/modules/mixer/simple/Makefile.am b/modules/mixer/simple/Makefile.am
index cb64ee8ca665..c21dd07d5180 100644
--- a/modules/mixer/simple/Makefile.am
+++ b/modules/mixer/simple/Makefile.am
@@ -1,3 +1,4 @@
+if BUILD_PYTHON
 alsaplugindir = @ALSA_PLUGIN_DIR@
 pkglibdir = $(alsaplugindir)/smixer
 
@@ -9,9 +10,7 @@ pkglib_LTLIBRARIES = smixer-sbase.la \
 		     smixer-ac97.la \
 		     smixer-hda.la
 
-if BUILD_PYTHON
 pkglib_LTLIBRARIES += smixer-python.la
-endif
 
 noinst_HEADERS = sbase.h
 
@@ -27,7 +26,6 @@ smixer_hda_la_SOURCES = hda.c sbasedl.c
 smixer_hda_la_LDFLAGS = -module -avoid-version $(LDFLAGS_NOUNDEFINED)
 smixer_hda_la_LIBADD = ../../../src/libasound.la -ldl
 
-if BUILD_PYTHON
 smixer_python_la_SOURCES = python.c
 smixer_python_la_LDFLAGS = -module -avoid-version $(LDFLAGS_NOUNDEFINED)
 smixer_python_la_CFLAGS = $(PYTHON_INCLUDES)
-- 
2.10.2
