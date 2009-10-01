From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH] ascenario: Add dump and configure utils for
	ascneario.
Date: Thu,  1 Oct 2009 11:47:16 +0200
Message-ID: <1254390436-5283-3-git-send-email-stefan@datenfreihafen.org>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 189B91038F3
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 11:48:11 +0200 (CEST)
In-Reply-To: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
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
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

ascndump is used to dump the kcontrols in a syntax that can be used with ascnctl
later. To list and set scenarios you can use ascnctl. This patch depends on the
ascenario infrstructure to be merged in alsa-lib.

CC: Ian Molton <ian@mnementh.co.uk>
CC: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 Makefile.am           |    2 +-
 ascenario/Makefile.am |   14 ++++++++
 ascenario/alsa-scn.c  |   88 +++++++++++++++++++++++++++++++++++++++++++++++++
 ascenario/dump.c      |   33 ++++++++++++++++++
 configure.in          |    1 +
 5 files changed, 137 insertions(+), 1 deletions(-)
 create mode 100644 ascenario/Makefile.am
 create mode 100644 ascenario/alsa-scn.c
 create mode 100644 ascenario/dump.c

diff --git a/Makefile.am b/Makefile.am
index 5296977..34c542f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,6 +1,6 @@
 INCLUDES=-I$(top_srcdir)/include
 
-SUBDIRS = include alsactl utils m4 po
+SUBDIRS = include alsactl ascenario utils m4 po
 if ALSAMIXER
 SUBDIRS += alsamixer
 endif
diff --git a/ascenario/Makefile.am b/ascenario/Makefile.am
new file mode 100644
index 0000000..88f5a67
--- /dev/null
+++ b/ascenario/Makefile.am
@@ -0,0 +1,14 @@
+noinst_PROGRAMS = \
+        ascnctl \
+        ascndump
+
+ascndump_SOURCES = dump.c
+
+ascnctl_SOURCES = alsa-scn.c
+
+INCLUDES = \
+         -Wall -I$(top_srcdir)/include
+
+ascndump_LDADD = -lasound
+
+ascnctl_LDADD = -lasound
diff --git a/ascenario/alsa-scn.c b/ascenario/alsa-scn.c
new file mode 100644
index 0000000..162d988
--- /dev/null
+++ b/ascenario/alsa-scn.c
@@ -0,0 +1,88 @@
+/*
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Copyright (C) 2008-2009 SlimLogic Ltd
+ *  Authors: Liam Girdwood <lrg@slimlogic.co.uk>
+ *           Stefan Schmidt <stefan@slimlogic.co.uk>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <alsa/ascenario.h>
+
+#define OP_LIST 1
+#define OP_SET  2
+
+void print_usage(char *name) {
+	printf("Usage: %s <cmd> [<scenario>]\n"
+	       " list  - list available scenarios\n"
+	       " set <name> - apply scenario <name>\n\n", name);
+}
+
+int main(int argc, char *argv[])
+{
+	struct snd_scenario *scn;
+	int num, i, op = 0, err, ret = 0;
+	const char **list;
+
+	if(argc > 2) {
+		if(!strcmp(argv[1], "set"))
+			op = OP_SET;
+	} else if(argc > 1) {
+		if(!strcmp(argv[1], "list"))
+			op = OP_LIST;
+	}
+
+	if(!op) {
+		print_usage(argv[0]);
+		exit(1);
+	}
+
+	/* open library */
+	scn = snd_scenario_open("default");
+	if (scn == NULL) {
+		printf("%s: failed to init\n", argv[0]);
+		return 0;
+	}
+
+	switch (op) {
+	case OP_LIST:
+		/* get list of scenarios */
+		num = snd_scenario_list(scn, &list);
+		if (num) {
+			for(i = 0 ; i < num ; i++)
+				printf("%s\n", list[i]);
+		} else {
+			printf("%s: no scenarios\n", argv[0]);
+			ret = 2;
+		}
+	break;
+	case OP_SET:
+		err = snd_scenario_set_scn(scn, argv[2]);
+                if (err < 0) {
+                        printf("failed to set scenario: %s\n", argv[2]);
+			ret = 3;
+		}
+	break;
+	default:
+		print_usage(argv[0]);
+	break;
+	}
+
+	snd_scenario_close(scn);
+	return ret;
+}
diff --git a/ascenario/dump.c b/ascenario/dump.c
new file mode 100644
index 0000000..b433ee6
--- /dev/null
+++ b/ascenario/dump.c
@@ -0,0 +1,33 @@
+/*
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Copyright (C) 2008-2009 SlimLogic Ltd
+ *  Authors: Liam Girdwood <lrg@slimlogic.co.uk>
+ *           Stefan Schmidt <stefan@slimlogic.co.uk>
+ */
+
+#include <stdio.h>
+#include <alsa/ascenario.h>
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		printf("usage: %s card (hw: prefix needed"
+			" e.g. hw:CARD=0 or hw:Intel)\n", argv[0]);
+		return 0;
+	}
+
+	return snd_scenario_dump(argv[1]);
+}
diff --git a/configure.in b/configure.in
index 931d034..8fcf1d3 100644
--- a/configure.in
+++ b/configure.in
@@ -270,6 +270,7 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  m4/Makefile po/Makefile.in \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
+	  ascenario/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
-- 
1.6.4.3
