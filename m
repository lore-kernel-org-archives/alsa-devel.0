From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?=5BPATCH=5D_aplay=3A_Fix_VU-meter_stdout/s?=
 =?utf-8?q?tderr_mess?=
Date: Fri, 13 Jun 2014 05:28:49 +0400
Message-ID: <1402622929.875823920@f438.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f438.i.mail.ru (f438.i.mail.ru [185.5.136.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E880260824
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 03:28:51 +0200 (CEST)
Received: from mail by f438.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WvGIT-0004UE-RQ
 for alsa-devel@alsa-project.org; Fri, 13 Jun 2014 05:28:50 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Commit 6bbeb78d forgot to change some of VU-meter output to stderr.
This patch makes the output of `aplay -vvv` consistent again.
---
 aplay/aplay.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 33a8ed5..77e40a3 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1774,12 +1774,12 @@ static void compute_max_peak(u_char *data, size_t count)
 		fflush(stderr);
 	}
 	else if(verbose==3) {
-		printf(_("Max peak (%li samples): 0x%08x "), (long)ocount, max_peak[0]);
+		fprintf(stderr, _("Max peak (%li samples): 0x%08x "), (long)ocount, max_peak[0]);
 		for (val = 0; val < 20; val++)
 			if (val <= perc[0] / 5)
-				putchar('#');
+				putc('#', stderr);
 			else
-				putchar(' ');
+				putc(' ', stderr);
 		fprintf(stderr, " %i%%\n", perc[0]);
 		fflush(stderr);
 	}
-- 
1.7.10.4
