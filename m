From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH] alsa-utils: fix wrong alias for signal.h
Date: Tue, 23 Jul 2013 03:57:54 +0200
Message-ID: <51EDE322.8040407@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030105060009000007010001"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id BF797261A9E
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 04:02:41 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------030105060009000007010001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

in POSIX, there is no <sys/signal.h>.

it's merely a legacy alias used by glibc, and the header does nothing 
else than including <signal.h>.

so let's do the right thing and use the right name, which works everywhere.

Signed-Off-By: John Spencer <maillist-alsa@barfooze.de>

--------------030105060009000007010001
Content-Type: text/x-patch;
 name="alsa-utils_signal_h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-utils_signal_h.patch"

--- alsa-utils-1.0.27.2.org/alsaloop/alsaloop.c	2013-07-23 01:48:03.592000003 +0000
+++ alsa-utils-1.0.27.2/alsaloop/alsaloop.c	2013-07-23 01:49:12.786000003 +0000
@@ -31,7 +31,7 @@
 #include <math.h>
 #include <pthread.h>
 #include <syslog.h>
-#include <sys/signal.h>
+#include <signal.h>
 #include "alsaloop.h"
 
 struct loopback_thread {

--------------030105060009000007010001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030105060009000007010001--
