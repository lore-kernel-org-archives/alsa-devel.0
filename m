From: Matthieu Crapet <Matthieu.Crapet@ingenico.com>
Subject: [PATCH - alsa-utils 1/1] configure: allow contitional
	compilation of alsaucm
Date: Wed, 14 Jan 2015 15:44:19 +0100
Message-ID: <1421246659-8112-1-git-send-email-Matthieu.Crapet@ingenico.com>
References: <1421245533-7624-1-git-send-email-Matthieu.Crapet@ingenico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.ingenico.com (smtp1.ingenico.com [217.108.148.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DCB92610B7
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 15:44:09 +0100 (CET)
In-Reply-To: <1421245533-7624-1-git-send-email-Matthieu.Crapet@ingenico.com>
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

If alsa-lib have been compiled with --disable-ucm, alsaucm can't be built.
Detection is dynamic, no configure command line option is available for now.

Signed-off-by: Matthieu Crapet <Matthieu.Crapet@ingenico.com>

diff --git a/Makefile.am b/Makefile.am
index 248eb11..5bbe588 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,6 +1,6 @@
 AM_CPPFLAGS=-I$(top_srcdir)/include
 
-SUBDIRS = include alsactl alsaucm utils m4 po alsa-info
+SUBDIRS = include alsactl utils m4 po alsa-info
 if ALSAMIXER
 SUBDIRS += alsamixer
 endif
@@ -22,6 +22,9 @@ endif
 if HAVE_SEQ
 SUBDIRS += seq
 endif
+if HAVE_UCM
+SUBDIRS += alsaucm
+endif
 
 EXTRA_DIST= TODO gitcompile
 AUTOMAKE_OPTIONS=foreign
diff --git a/configure.ac b/configure.ac
index 3c7032b..d953e5c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,6 +48,8 @@ AC_CHECK_HEADERS([alsa/rawmidi.h], [have_rawmidi="yes"], [have_rawmidi="no"],
   [#include <alsa/asoundlib.h>])
 AC_CHECK_HEADERS([alsa/seq.h], [have_seq="yes"], [have_seq="no"],
   [#include <alsa/asoundlib.h>])
+AC_CHECK_HEADERS([alsa/use-case.h], [have_ucm="yes"], [have_ucm="no"],
+  [#include <alsa/asoundlib.h>])
 AC_CHECK_HEADERS([samplerate.h], [have_samplerate="yes"], [have_samplerate="no"],
   [#include <samplerate.h>])
 
@@ -55,6 +57,7 @@ AM_CONDITIONAL(HAVE_PCM, test "$have_pcm" = "yes")
 AM_CONDITIONAL(HAVE_MIXER, test "$have_mixer" = "yes")
 AM_CONDITIONAL(HAVE_RAWMIDI, test "$have_rawmidi" = "yes")
 AM_CONDITIONAL(HAVE_SEQ, test "$have_seq" = "yes")
+AM_CONDITIONAL(HAVE_UCM, test "$have_ucm" = "yes")
 AM_CONDITIONAL(HAVE_SAMPLERATE, test "$have_samplerate" = "yes")
 
 dnl Check for librt
-- 
1.8.5.4
