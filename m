From: Dirk Jagdmann <doj@cubic.org>
Subject: [patch] alternative peak meter for aplay
Date: Sat, 03 Dec 2005 11:58:44 +0100
Message-ID: <43917A64.20707@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090604010806090502030703"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from roasted.cubic.org (roasted.cubic.org [193.108.181.130])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C56A6FE
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2005 11:58:47 +0100 (MET)
Received: from c142209.adsl.hansenet.de ([213.39.142.209] helo=mrmucke.doj)
	by roasted.cubic.org with esmtp (Exim 3.36 #1)
	id 1EiV6M-0001tF-00
	for alsa-devel@alsa-project.org; Sat, 03 Dec 2005 11:58:47 +0100
Received: from [192.168.0.3] (helo=[192.168.0.3])
	by mrmucke.doj with esmtp (Exim 3.36 #1)
	id 1EiV6L-0007cQ-00
	for alsa-devel@alsa-project.org; Sat, 03 Dec 2005 11:58:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090604010806090502030703
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds an alternative peak meter for aplay/arecord which is 
enabled via three "-v" command line arguments. This new mode differs 
from the old in a larger meter, no linefeeds for every meter update and 
a static maximum peak (for 1s).

-- 
---> Dirk Jagdmann ^ doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------090604010806090502030703
Content-Type: text/plain;
 name="aplay-verbose3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aplay-verbose3.patch"

Index: alsa-utils-1.0.10/aplay/aplay.c
===================================================================
--- alsa-utils-1.0.10.orig/aplay/aplay.c	2005-11-08 17:43:36.000000000 +0100
+++ alsa-utils-1.0.10/aplay/aplay.c	2005-12-03 01:05:34.000000000 +0100
@@ -1183,17 +1183,47 @@
 	max = 1 << (bits_per_sample-1);
 	if (max <= 0)
 		max = 0x7fffffff;
-	printf(_("Max peak (%li samples): 0x%08x "), (long)ocount, max_peak);
+
 	if (bits_per_sample > 16)
 		perc = max_peak / (max / 100);
 	else
 		perc = max_peak * 100 / max;
-	for (val = 0; val < 20; val++)
-		if (val <= perc / 5)
-			putc('#', stdout);
-		else
-			putc(' ', stdout);
-	printf(" %i%%\n", perc);
+
+	if(verbose<=2) {
+		printf(_("Max peak (%li samples): 0x%08x "), (long)ocount, max_peak);
+		for (val = 0; val < 20; val++)
+			if (val <= perc / 5)
+				putchar('#');
+			else
+				putchar(' ');
+		printf(" %i%%\n", perc);
+	}
+	else if(verbose==3) {
+		static int maxperc=0;
+		static time_t t=0;
+		const time_t tt=time(NULL);
+		if(tt>t) {
+			t=tt;
+			maxperc=0;
+		}
+		if(perc>maxperc)
+			maxperc=perc;
+
+		putchar('\r');
+		for (val = 0; val <= perc / 2 && val < 50; val++)
+			putchar('#');
+		for (; val < maxperc / 2 && val < 50; val++)
+			putchar(' ');
+		putchar('+');
+		for (++val; val < 50; val++)
+			putchar(' ');
+
+		printf("| %02i%%", maxperc);
+		if (perc>99)
+			printf(_(" !clip  "));
+
+		fflush(stdout);
+	}
 }
 
 /*
Index: alsa-utils-1.0.10/aplay/aplay.1
===================================================================
--- alsa-utils-1.0.10.orig/aplay/aplay.1	2005-11-14 11:11:50.000000000 +0100
+++ alsa-utils-1.0.10/aplay/aplay.1	2005-12-03 01:06:01.000000000 +0100
@@ -111,7 +111,7 @@
 \fI\-v, \-\-verbose\fP           
 Show PCM structure and setup.
 This option is accumulative.  The VU meter is displayed when this
-is given twice.
+is given twice or three times.
 .TP
 \fI\-I, \-\-separate\-channels\fP 
 One file for each channel
Index: alsa-utils-1.0.10/aplay/arecord.1
===================================================================
--- alsa-utils-1.0.10.orig/aplay/arecord.1	2005-11-14 11:11:50.000000000 +0100
+++ alsa-utils-1.0.10/aplay/arecord.1	2005-12-03 01:06:19.000000000 +0100
@@ -111,7 +111,7 @@
 \fI\-v, \-\-verbose\fP           
 Show PCM structure and setup.
 This option is accumulative.  The VU meter is displayed when this
-is given twice.
+is given twice or three times.
 .TP
 \fI\-I, \-\-separate\-channels\fP 
 One file for each channel

--------------090604010806090502030703--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
