From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-lib] [PATCH 2/4] build: Fallback to alphasort()
	if versionsort() isn't available
Date: Tue, 17 Jul 2012 15:30:15 +0530
Message-ID: <1342519217-3668-3-git-send-email-arun.raghavan@collabora.co.uk>
References: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 98367264F93
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:02:01 +0200 (CEST)
In-Reply-To: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

versionsort() is a GNU-ism and can't be relied on for non-GNU systems.

Signed-off-by: Arun Raghavan <arun.raghavan@collabora.co.uk>
---
 src/conf.c       |    4 ++++
 src/ucm/parser.c |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index 32446a2..2a3a03c 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3505,7 +3505,11 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 			struct dirent **namelist;
 			int n;
 
+#ifdef _GNU_SOURCE
 			n = scandir(fi[idx].name, &namelist, config_filename_filter, versionsort);
+#else
+			n = scandir(fi[idx].name, &namelist, config_filename_filter, alphasort);
+#endif
 			if (n > 0) {
 				int j;
 				err = 0;
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index b93d832..e999619 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -1254,7 +1254,11 @@ int uc_mgr_scan_master_configs(const char **_list[])
 		"%s", env ? env : ALSA_USE_CASE_DIR);
 	filename[MAX_FILE-1] = '\0';
 
+#ifdef _GNU_SOURCE
 	err = scandir(filename, &namelist, filename_filter, versionsort);
+#else
+	err = scandir(filename, &namelist, filename_filter, alphasort);
+#endif
 	if (err < 0) {
 		err = -errno;
 		uc_error("error: could not scan directory %s: %s",
-- 
1.7.8.6
