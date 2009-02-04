From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 5/5] snd-usb-caiaq: Increase version number to
	1.3.12
Date: Wed,  4 Feb 2009 22:34:34 +0000
Message-ID: <1233786874-16373-5-git-send-email-mark@pogo.org.uk>
References: <1233786874-16373-1-git-send-email-mark@pogo.org.uk>
	<1233786874-16373-2-git-send-email-mark@pogo.org.uk>
	<1233786874-16373-3-git-send-email-mark@pogo.org.uk>
	<1233786874-16373-4-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id BCA662440D
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 23:34:35 +0100 (CET)
In-Reply-To: <1233786874-16373-4-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Indicates fixes affecting control messages and switching of input mode
on Audio 8 DJ and Audio 4 DJ.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 usb/caiaq/caiaq-device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/usb/caiaq/caiaq-device.c b/usb/caiaq/caiaq-device.c
index 769321d..5cf841e 100644
--- a/usb/caiaq/caiaq-device.c
+++ b/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.11");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.12");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
-- 
1.6.1.2
