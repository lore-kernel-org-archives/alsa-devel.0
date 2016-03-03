From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 4/5] Use alphasort where versionsort is not
	available.
Date: Thu,  3 Mar 2016 15:08:03 +0100
Message-ID: <1457014084-27694-4-git-send-email-tk@giga.or.at>
References: <1457014084-27694-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-3.mx.upcmail.net
 (vie01a-dmta-pe04-3.mx.upcmail.net [62.179.121.165])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCE62606D2
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 15:08:50 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1abTvu-0006Kl-ML
 for alsa-devel@alsa-project.org; Thu, 03 Mar 2016 15:08:50 +0100
In-Reply-To: <1457014084-27694-1-git-send-email-tk@giga.or.at>
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
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

---
 src/conf.c       | 2 +-
 src/ucm/parser.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index a4f2a4f..f8b7a66 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3549,7 +3549,7 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 			int n;
 
 #ifndef DOC_HIDDEN
-#ifdef _GNU_SOURCE
+#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 9e1cb41..8405bd2 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -1264,7 +1264,7 @@ int uc_mgr_scan_master_configs(const char **_list[])
 		"%s", env ? env : ALSA_USE_CASE_DIR);
 	filename[MAX_FILE-1] = '\0';
 
-#ifdef _GNU_SOURCE
+#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
-- 
2.7.1
