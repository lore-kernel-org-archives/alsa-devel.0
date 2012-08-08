From: Mario Domenech Goulart <mario.goulart@gmail.com>
Subject: [PATCH] test/latency.c: Fix string argument to
	getopt_long, so now it handles -E and -B
Date: Wed, 08 Aug 2012 10:18:21 -0400
Message-ID: <85ipctzcuq.fsf@cl-t066-141cl.privatedns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 599E1266094
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 15:56:01 +0200 (CEST)
Received: by qcse14 with SMTP id e14so429635qcs.38
 for <alsa-devel@alsa-project.org>; Wed, 08 Aug 2012 07:25:46 -0700 (PDT)
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

--=-=-=

Hi,

Attached is a small patch for alsa-lib's test/latency.c to fix command
line arguments handling.

Best wishes.
Mario
-- 
http://parenteses.org/mario

--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0001-test-latency.c-Fix-string-argument-to-getopt_long-so.patch

>From 6298b47a7b76110b97a525f65faf18a8d27089b5 Mon Sep 17 00:00:00 2001
From: Mario Domenech Goulart <mario@ossystems.com.br>
Date: Wed, 8 Aug 2012 11:03:19 -0300
Subject: [PATCH] test/latency.c: Fix string argument to getopt_long, so now it handles -E and -B

---
 test/latency.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/latency.c b/test/latency.c
index e9bc6d8..f3d2eb6 100644
--- a/test/latency.c
+++ b/test/latency.c
@@ -502,7 +502,7 @@ int main(int argc, char *argv[])
 	morehelp = 0;
 	while (1) {
 		int c;
-		if ((c = getopt_long(argc, argv, "hP:C:m:M:F:f:c:r:s:bpen", long_option, NULL)) < 0)
+		if ((c = getopt_long(argc, argv, "hP:C:m:M:F:f:c:r:B:E:s:bpen", long_option, NULL)) < 0)
 			break;
 		switch (c) {
 		case 'h':
-- 
1.7.2.5


--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
