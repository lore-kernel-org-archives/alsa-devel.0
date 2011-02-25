From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: [PATCH] ASOC: missing files in alsa-driver
Date: Fri, 25 Feb 2011 16:42:42 +0100
Message-ID: <4D67CDF2.3030207@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout4.mailmx.agnat.pl
	[193.239.44.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 1083D244E4
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 16:42:46 +0100 (CET)
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.74)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1PszoY-0002Wl-Sc
	for alsa-devel@alsa-project.org; Fri, 25 Feb 2011 16:42:42 +0100
Received: from [78.133.172.40] (helo=[192.168.1.79])
	by smtp.agnat.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.71) (envelope-from <g.daniluk@elproma.com.pl>)
	id 1PszoY-0002Wc-QW
	for alsa-devel@alsa-project.org; Fri, 25 Feb 2011 16:42:42 +0100
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
List-Id: alsa-devel@alsa-project.org

This patch adds few files missing in soc/codecs and soc/sh. Without them 
the compilation of alsa-driver with those soc-s is impossible.

Signed-off-by: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
---

diff -uprN a/soc/codecs/da7210.c b/soc/codecs/da7210.c
--- a/soc/codecs/da7210.c       1970-01-01 00:00:00.000000000 +0000
+++ b/soc/codecs/da7210.c       2011-02-25 13:48:26.000000000 +0000
@@ -0,0 +1,2 @@
+#include "adriver.h"
+#include "../../alsa-kernel/soc/codecs/da7210.c"
diff -uprN a/soc/sh/fsi-da7210.c b/soc/sh/fsi-da7210.c
--- a/soc/sh/fsi-da7210.c       1970-01-01 00:00:00.000000000 +0000
+++ b/soc/sh/fsi-da7210.c       2011-02-25 14:38:05.485218100 +0000
@@ -0,0 +1,2 @@
+#include "adriver.h"
+#include "../../alsa-kernel/soc/sh/fsi-da7210.c"
diff -uprN a/soc/sh/fsi.c b/soc/sh/fsi.c
--- a/soc/sh/fsi.c      1970-01-01 00:00:00.000000000 +0000
+++ b/soc/sh/fsi.c      2011-02-25 13:51:21.000000000 +0000
@@ -0,0 +1,2 @@
+#include "adriver.h"
+#include "../../alsa-kernel/soc/sh/fsi.c"
