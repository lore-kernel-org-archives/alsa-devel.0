From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH alsa-lib] move page helpers to common code
Date: Tue, 27 Oct 2015 17:27:55 -0400
Message-ID: <1445981275-2132-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F16C260636
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 22:28:04 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 77AAF340845
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 21:28:02 +0000 (UTC)
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

From: Mike Frysinger <vapier@chromium.org>

If you build with --disable-pcm, the rawmidi code fails to link because
it uses the page_size helper declared in local.h, but the page_* funcs
are in the pcm mmap module.  Move these funcs into conf.c so that they
are always available to the rest of the system.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 src/conf.c         | 36 ++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_mmap.c | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index 91fca25..a4f2a4f 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -4876,3 +4876,39 @@ static void _snd_config_end(void)
 	files_info_count = 0;
 }
 #endif
+
+size_t page_size(void)
+{
+	long s = sysconf(_SC_PAGE_SIZE);
+	assert(s > 0);
+	return s;
+}
+
+size_t page_align(size_t size)
+{
+	size_t r;
+	long psz = page_size();
+	r = size % psz;
+	if (r)
+		return size + psz - r;
+	return size;
+}
+
+size_t page_ptr(size_t object_offset, size_t object_size, size_t *offset, size_t *mmap_offset)
+{
+	size_t r;
+	long psz = page_size();
+	assert(offset);
+	assert(mmap_offset);
+	*mmap_offset = object_offset;
+	object_offset %= psz;
+	*mmap_offset -= object_offset;
+	object_size += object_offset;
+	r = object_size % psz;
+	if (r)
+		r = object_size + psz - r;
+	else
+		r = object_size;
+	*offset = object_offset;
+	return r;
+}
diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 83e74e5..470bd04 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -26,42 +26,6 @@
 #include <sys/shm.h>
 #include "pcm_local.h"
 
-size_t page_size(void)
-{
-	long s = sysconf(_SC_PAGE_SIZE);
-	assert(s > 0);
-	return s;
-}
-
-size_t page_align(size_t size)
-{
-	size_t r;
-	long psz = page_size();
-	r = size % psz;
-	if (r)
-		return size + psz - r;
-	return size;
-}
-
-size_t page_ptr(size_t object_offset, size_t object_size, size_t *offset, size_t *mmap_offset)
-{
-	size_t r;
-	long psz = page_size();
-	assert(offset);
-	assert(mmap_offset);
-	*mmap_offset = object_offset;
-	object_offset %= psz;
-	*mmap_offset -= object_offset;
-	object_size += object_offset;
-	r = object_size % psz;
-	if (r)
-		r = object_size + psz - r;
-	else
-		r = object_size;
-	*offset = object_offset;
-	return r;
-}
-
 void snd_pcm_mmap_appl_backward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_sframes_t appl_ptr = *pcm->appl.ptr;
-- 
2.5.2
