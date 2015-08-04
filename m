From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Add command line topology tool to
	build topology binaries
Date: Tue,  4 Aug 2015 15:54:27 +0100
Message-ID: <1438700067-14135-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 33D4C265906
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 16:54:38 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Add a command line tool that will parse topology text files and convert to the binary
topology data as used by the kernel.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Makefile.am          |   3 ++
 configure.ac         |   5 ++-
 topology/Makefile.am |  13 ++++++
 topology/topology.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 topology/Makefile.am
 create mode 100644 topology/topology.c

diff --git a/Makefile.am b/Makefile.am
index 5bbe588..613f62d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -25,6 +25,9 @@ endif
 if HAVE_UCM
 SUBDIRS += alsaucm
 endif
+if HAVE_TOPOLOGY
+SUBDIRS += topology
+endif
 
 EXTRA_DIST= TODO gitcompile
 AUTOMAKE_OPTIONS=foreign
diff --git a/configure.ac b/configure.ac
index f09aa54..4c279a9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -50,6 +50,8 @@ AC_CHECK_HEADERS([alsa/seq.h], [have_seq="yes"], [have_seq="no"],
   [#include <alsa/asoundlib.h>])
 AC_CHECK_HEADERS([alsa/use-case.h], [have_ucm="yes"], [have_ucm="no"],
   [#include <alsa/asoundlib.h>])
+AC_CHECK_HEADERS([alsa/topology.h], [have_topology="yes"], [have_topology="no"],
+  [#include <alsa/asoundlib.h>])
 AC_CHECK_HEADERS([samplerate.h], [have_samplerate="yes"], [have_samplerate="no"],
   [#include <samplerate.h>])
 
@@ -58,6 +60,7 @@ AM_CONDITIONAL(HAVE_MIXER, test "$have_mixer" = "yes")
 AM_CONDITIONAL(HAVE_RAWMIDI, test "$have_rawmidi" = "yes")
 AM_CONDITIONAL(HAVE_SEQ, test "$have_seq" = "yes")
 AM_CONDITIONAL(HAVE_UCM, test "$have_ucm" = "yes")
+AM_CONDITIONAL(HAVE_TOPOLOGY, test "$have_topology" = "yes")
 AM_CONDITIONAL(HAVE_SAMPLERATE, test "$have_samplerate" = "yes")
 
 dnl Check for librt
@@ -358,7 +361,7 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  m4/Makefile po/Makefile.in \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
-	  alsaucm/Makefile \
+	  alsaucm/Makefile topology/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
diff --git a/topology/Makefile.am b/topology/Makefile.am
new file mode 100644
index 0000000..f59ce01
--- /dev/null
+++ b/topology/Makefile.am
@@ -0,0 +1,13 @@
+bin_PROGRAMS = \
+	alsatplg
+
+alsatplg_SOURCES = topology.c
+
+AM_CPPFLAGS = \
+         -Wall -I$(top_srcdir)/include
+
+alsatplg_LDADD = -lasound
+
+# local build
+AM_CPPFLAGS += -I$(top_srcdir)/../alsa-lib/include
+alsatplg_LDADD = -L$(top_srcdir)/../alsa-lib/src/.libs
diff --git a/topology/topology.c b/topology/topology.c
new file mode 100644
index 0000000..7049bb7
--- /dev/null
+++ b/topology/topology.c
@@ -0,0 +1,117 @@
+/*
+  Copyright(c) 2014-2015 Intel Corporation
+  Copyright(c) 2010-2011 Texas Instruments Incorporated,
+  All rights reserved.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of version 2 of the GNU General Public License as
+  published by the Free Software Foundation.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+  The full GNU General Public License is included in this distribution
+  in the file called LICENSE.GPL.
+*/
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <dlfcn.h>
+#include <getopt.h>
+#include <alsa/asoundlib.h>
+#include <assert.h>
+
+#include "topology.h"
+#include "gettext.h"
+
+static snd_output_t *log;
+
+static void usage(char *name)
+{
+	printf(
+_("Usage: %s [OPTIONS]...\n"
+"\n"
+"-h, --help              help\n"
+"-c, --compile=FILE      compile file\n"
+"-v, --verbose=LEVEL     set verbosity level (0...1)\n"
+"-o, --output=FILE       set output file\n"
+), name);
+}
+
+int main(int argc, char *argv[])
+{
+	snd_tplg_t *snd_tplg;
+	static const char short_options[] = "hc:v:o:";
+	static const struct option long_options[] = {
+		{"help", 0, 0, 'h'},
+		{"verbose", 0, 0, 'v'},
+		{"compile", 0, 0, 'c'},
+		{"output", 0, 0, 'o'},
+		{0, 0, 0, 0},
+	};
+	char *source_file = NULL, *output_file = NULL;
+	int c, err, verbose = 0, option_index;
+
+#ifdef ENABLE_NLS
+	setlocale(LC_ALL, "");
+	textdomain(PACKAGE);
+#endif
+
+	err = snd_output_stdio_attach(&log, stderr, 0);
+	assert(err >= 0);
+
+	while ((c = getopt_long(argc, argv, short_options, long_options, &option_index)) != -1) {
+		switch (c) {
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 'v':
+			verbose = atoi(optarg);
+			break;
+		case 'c':
+			source_file = optarg;
+			break;
+		case 'o':
+			output_file = optarg;
+			break;
+		default:
+			fprintf(stderr, _("Try `%s --help' for more information.\n"), argv[0]);
+			return 1;
+		}
+	}
+
+	if (source_file == NULL || output_file == NULL) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	snd_tplg = snd_tplg_new();
+	if (snd_tplg == NULL) {
+		fprintf(stderr, _("failed to create new topology context\n"));
+		return 1;
+	}
+
+	snd_tplg_verbose(snd_tplg, verbose);
+
+	err = snd_tplg_build_file(snd_tplg, source_file, output_file);
+	if (err < 0) {
+		fprintf(stderr, _("failed to compile context %s\n"), source_file);
+		snd_tplg_free(snd_tplg);
+		return 1;
+	}
+
+	snd_tplg_free(snd_tplg);
+	return 0;
+}
+
-- 
2.1.4
