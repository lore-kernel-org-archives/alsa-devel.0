From: Dan Nicholson <nicholson@endlessm.com>
Subject: [PATCH] alsactl: Try to create state file directory
Date: Fri,  5 Jun 2015 15:00:47 -0700
Message-ID: <1433541647-300-1-git-send-email-nicholson@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B829266938
 for <alsa-devel@alsa-project.org>; Sat,  6 Jun 2015 00:00:57 +0200 (CEST)
Received: by qcxw10 with SMTP id w10so35071921qcx.3
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2015 15:00:56 -0700 (PDT)
Received: from midnight.endlessm-sf.com ([204.28.125.50])
 by mx.google.com with ESMTPSA id e104sm4576599qgd.29.2015.06.05.15.00.55
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2015 15:00:55 -0700 (PDT)
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

Try to create the directory for the state file when saving so we don't
depend on it being created ahead of time. This only checks for failures
on existing directories and doesn't try to create the leading
directories or workaround any other errors. This should catch the common
case where /var/lib exists, but /var/lib/alsa doesn't.

Signed-off-by: Dan Nicholson <nicholson@endlessm.com>
---
 alsactl/state.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/alsactl/state.c b/alsactl/state.c
index 3908ec4..8ca3d6e 100644
--- a/alsactl/state.c
+++ b/alsactl/state.c
@@ -27,6 +27,9 @@
 #include <stdio.h>
 #include <assert.h>
 #include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <alsa/asoundlib.h>
 #include "alsactl.h"
 
@@ -1544,6 +1547,7 @@ int save_state(const char *file, const char *cardname)
 	snd_output_t *out;
 	int stdio;
 	char *nfile = NULL;
+	char *filedir = NULL;
 	int lock_fd = -EINVAL;
 
 	err = snd_config_top(&config);
@@ -1553,6 +1557,9 @@ int save_state(const char *file, const char *cardname)
 	}
 	stdio = !strcmp(file, "-");
 	if (!stdio) {
+		char *tmp;
+		mode_t mode = S_IRWXU | S_IRWXG | S_IRWXO;
+
 		nfile = malloc(strlen(file) + 5);
 		if (nfile == NULL) {
 			error("No enough memory...");
@@ -1561,6 +1568,21 @@ int save_state(const char *file, const char *cardname)
 		}
 		strcpy(nfile, file);
 		strcat(nfile, ".new");
+		filedir = strdup(file);
+		if (filedir == NULL) {
+			error("Not enough memory...");
+			err = -ENOMEM;
+			goto out;
+		}
+		tmp = strrchr(filedir, '/');
+		if (tmp && tmp != filedir) {
+			*tmp = '\0';
+			if (mkdir(filedir, mode) != 0 && errno != EEXIST) {
+				error("Could not create directory %s: %s",
+				      filedir, strerror(errno));
+				goto out;
+			}
+		}
 		lock_fd = state_lock(file, 10);
 		if (lock_fd < 0) {
 			err = lock_fd;
@@ -1640,6 +1662,7 @@ out:
 	if (!stdio && lock_fd >= 0)
 		state_unlock(lock_fd, file);
 	free(nfile);
+	free(filedir);
 	snd_config_delete(config);
 	snd_config_update_free_global();
 	return err;
-- 
1.8.1.2
