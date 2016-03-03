From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 2/5] Add more compatibility defines.
Date: Thu,  3 Mar 2016 15:08:01 +0100
Message-ID: <1457014084-27694-2-git-send-email-tk@giga.or.at>
References: <1457014084-27694-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe01-2.mx.upcmail.net
 (vie01a-dmta-pe01-2.mx.upcmail.net [62.179.121.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4F1260535
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 15:08:50 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe01.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1abTvu-0002iT-IM
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
 include/type_compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/type_compat.h b/include/type_compat.h
index 9cc209f..0c10aed 100644
--- a/include/type_compat.h
+++ b/include/type_compat.h
@@ -25,6 +25,9 @@
 #ifndef EBADFD
 #define EBADFD EBADF
 #endif
+#ifndef ESTRPIPE
+#define ESTRPIPE EPIPE
+#endif
 
 #ifndef __u16
 #define __u16	uint16_t
@@ -63,4 +66,8 @@
 #define __kernel_off_t	off_t
 #endif
 
+#ifndef __bitwise
+#define __bitwise
+#endif
+
 #endif
-- 
2.7.1
