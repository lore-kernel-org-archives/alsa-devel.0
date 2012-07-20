From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] hda-emu: Silence warning
Date: Fri, 20 Jul 2012 14:59:51 +0200
Message-ID: <1342789192-11191-2-git-send-email-david.henningsson@canonical.com>
References: <1342789192-11191-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B9AC265346
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 15:00:06 +0200 (CEST)
In-Reply-To: <1342789192-11191-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

gcc gives a false alarm that "fp might be used uninitialized in this
function".

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-emu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hda-emu.c b/hda-emu.c
index 8bf1c81..77d5a7f 100644
--- a/hda-emu.c
+++ b/hda-emu.c
@@ -290,7 +290,7 @@ void hda_log_dump_proc(unsigned int nid, const char *file)
 	card.proc->func(card.proc, &buf);
 	hda_log_level_set(saved_level);
 	if (file)
-		fclose(fp);
+		fclose(buf.fp);
 }
 
 /*
-- 
1.7.9.5
