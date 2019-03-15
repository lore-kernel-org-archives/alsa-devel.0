From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: [PATCH 1/5] Android: avoid using versionsort
Date: Fri, 15 Mar 2019 17:17:02 +0800
Message-ID: <20190315091706.26772-2-cwhuang@linux.org.tw>
References: <20190315091706.26772-1-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78D64F89701
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 10:17:40 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id k11so6013966pgb.8
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 02:17:40 -0700 (PDT)
In-Reply-To: <20190315091706.26772-1-cwhuang@linux.org.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Chih-Wei Huang <cwhuang@linux.org.tw>
List-Id: alsa-devel@alsa-project.org

Android doesn't have versionsort yet.

Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 src/conf.c       | 2 +-
 src/ucm/parser.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index b8db490c..cda5518e 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3750,7 +3750,7 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 			int n;
 
 #ifndef DOC_HIDDEN
-#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
+#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun) && !defined(ANDROID)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 5e1a8862..ad6bcec7 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -1532,7 +1532,7 @@ int uc_mgr_scan_master_configs(const char **_list[])
 			 snd_config_topdir());
 	filename[MAX_FILE-1] = '\0';
 
-#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
+#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun) && !defined(ANDROID)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
-- 
2.20.1
