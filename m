From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 08/22] ALSA: hda - Replace strnicmp with
	strncasecmp
Date: Tue, 16 Sep 2014 22:51:22 +0200
Message-ID: <1410900696-6481-9-git-send-email-linux@rasmusvillemoes.dk>
References: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id BF8F1262607
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 22:52:05 +0200 (CEST)
Received: by mail-lb0-f178.google.com with SMTP id c11so596980lbj.23
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 13:52:05 -0700 (PDT)
In-Reply-To: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The kernel used to contain two functions for length-delimited,
case-insensitive string comparison, strnicmp with correct semantics
and a slightly buggy strncasecmp. The latter is the POSIX name, so
strnicmp was renamed to strncasecmp, and strnicmp made into a wrapper
for the new strncasecmp to avoid breaking existing users.

To allow the compat wrapper strnicmp to be removed at some point in
the future, and to avoid the extra indirection cost, do
s/strnicmp/strncasecmp/g.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 sound/pci/hda/hda_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index e207909..9b49f15 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -514,7 +514,7 @@ enum {
 
 static inline int strmatch(const char *a, const char *b)
 {
-	return strnicmp(a, b, strlen(b)) == 0;
+	return strncasecmp(a, b, strlen(b)) == 0;
 }
 
 /* parse the contents after the line "[codec]"
-- 
2.0.4
