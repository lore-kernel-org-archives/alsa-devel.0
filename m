From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCHv2] pcm.h: include sys/types.h,
	necessary for u_int_XX types
Date: Thu, 10 Oct 2013 15:24:22 +0200
Message-ID: <1381411462-15582-1-git-send-email-maillist-alsa@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AFD2655A9
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 15:28:15 +0200 (CEST)
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

fixes compilation on musl libc.

Signed-off-by: John Spencer <maillist-alsa@barfooze.de>

---
 include/pcm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index 95b8aed..7ea9e84 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -29,6 +29,8 @@
 #ifndef __ALSA_PCM_H
 #define __ALSA_PCM_H
 
+#include <sys/types.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
1.7.3.4
