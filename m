From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH] local.h: include sys/types.h to fix issues
	with pcm.h
Date: Thu, 10 Oct 2013 18:56:22 +0200
Message-ID: <1381424182-26601-1-git-send-email-maillist-alsa@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D9EC2655ED
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 19:00:23 +0200 (CEST)
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
Cc: John Spencer <maillist-alsa@barfooze.de>
List-Id: alsa-devel@alsa-project.org

sys/types.h is required for the u_int_XX types used by pcm.h.
since a change in pcm.h is not desired, we add the inclusion
to the header that includes pcm.h during build.

Signed-off-by: John Spencer <maillist-alsa@barfooze.de>
---
 include/local.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/local.h b/include/local.h
index f0db188..9464efa 100644
--- a/include/local.h
+++ b/include/local.h
@@ -31,6 +31,7 @@
 #include <endian.h>
 #include <stdarg.h>
 #include <sys/poll.h>
+#include <sys/types.h>
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/ioctl.h>
-- 
1.7.3.4
