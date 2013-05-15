From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 2/3] Compile in the ALSA search path instead of
	relying on ld.so.conf.
Date: Wed, 15 May 2013 19:05:59 +0200
Message-ID: <1368637560-28962-3-git-send-email-jordi@debian.org>
References: <1368637560-28962-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 631532616DB
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:06:25 +0200 (CEST)
In-Reply-To: <1368637560-28962-1-git-send-email-jordi@debian.org>
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
Cc: Steve Langasek <steve.langasek@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Steve Langasek <steve.langasek@canonical.com>

The Ubuntu package currently uses ld.so.conf.d fragments to add
/usr/lib/alsa-lib and /usr/lib{32,64}/alsa-lib to the dlopen search path.
These don't *belong* on the global search path, and it becomes much more
problematic to put them there with the advent of multiarch because each
architecture then needs its own distinct config file to add the separate
path... which is then also put in the global library namespace.  Instead,
let ALSA make use of the already defined ALSA_PLUGIN_DIR to look up
plugins.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 src/dlmisc.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/dlmisc.c b/src/dlmisc.c
index 2de0234..4b8a02c 100644
--- a/src/dlmisc.c
+++ b/src/dlmisc.c
@@ -67,7 +67,25 @@ void *snd_dlopen(const char *name, int mode)
 #endif
 #endif
 #ifdef HAVE_LIBDL
-	return dlopen(name, mode);
+	/*
+	 * Handle the plugin dir not being on the default dlopen search
+	 * path, without resorting to polluting the entire system namespace
+	 * via ld.so.conf.
+	 */
+	void *handle = NULL;
+	char *filename;
+
+	if (name && name[0] != '/') {
+		filename = malloc(sizeof(ALSA_PLUGIN_DIR) + 1 + strlen(name) + 1);
+		strcpy(filename, ALSA_PLUGIN_DIR);
+		strcat(filename, "/");
+		strcat(filename, name);
+		handle = dlopen(filename, mode);
+		free(filename);
+	}
+	if (!handle)
+		handle = dlopen(name, mode);
+	return handle;
 #else
 	return NULL;
 #endif
-- 
1.7.10.4
