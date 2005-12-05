From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: [patch] alternative peak meter for aplay
Date: Tue, 06 Dec 2005 00:26:06 +0100
Message-ID: <4394CC8E.3060808@cubic.org>
References: <43917A64.20707@cubic.org> <s5h64q3mksn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090503020009000902080700"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from roasted.cubic.org (roasted.cubic.org [193.108.181.130])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6FC0F16D
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 00:26:07 +0100 (MET)
In-Reply-To: <s5h64q3mksn.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090503020009000902080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> I like this one.  I'd vote to make this one as -vv and the older one
> to -vvv.  -vvv would be useful to log to a file while -vv is prettier
> for a terminal output.

Ok, I exchanged the appropriate blocks.

> The only problem with this patch is that a linefeed is missing even
> after the playback is finished.  Could you fix it?

Yes I can fix it, although it's a very difficult request ;-)

-- 
---> Dirk Jagdmann ^ doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------090503020009000902080700
Content-Type: text/plain;
 name="aplay-verbose3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aplay-verbose3.patch"

Index: alsa-utils-1.0.10/aplay/aplay.c
===================================================================
--- alsa-utils-1.0.10.orig/aplay/aplay.c	2005-11-08 17:43:36.000000000 +0100
+++ alsa-utils-1.0.10/aplay/aplay.c	2005-12-05 23:16:19.000000000 +0100
@@ -303,6 +303,8 @@
 
 static void signal_handler(int sig)
 {
+	if (verbose==2)
+		putchar('\n');
 	if (!quiet_mode)
 		fprintf(stderr, _("Aborted by signal %s...\n"), strsignal(sig));
 	if (stream == SND_PCM_STREAM_CAPTURE) {
@@ -603,6 +605,8 @@
 		else
 			capturev(&argv[optind], argc - optind);
 	}
+	if (verbose==2)
+		putchar('\n');
 	snd_pcm_close(handle);
 	free(audiobuf);
 	snd_output_close(log);
@@ -1183,17 +1187,47 @@
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
+	else if(verbose==3) {
+		printf(_("Max peak (%li samples): 0x%08x "), (long)ocount, max_peak);
+		for (val = 0; val < 20; val++)
+			if (val <= perc / 5)
+				putchar('#');
+			else
+				putchar(' ');
+		printf(" %i%%\n", perc);
+	}
 }
 
 /*
Index: alsa-utils-1.0.10/aplay/aplay.1
===================================================================
--- alsa-utils-1.0.10.orig/aplay/aplay.1	2005-11-14 11:11:50.000000000 +0100
+++ alsa-utils-1.0.10/aplay/aplay.1	2005-12-05 23:10:36.000000000 +0100
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
+++ alsa-utils-1.0.10/aplay/arecord.1	2005-12-05 23:10:36.000000000 +0100
@@ -111,7 +111,7 @@
 \fI\-v, \-\-verbose\fP           
 Show PCM structure and setup.
 This option is accumulative.  The VU meter is displayed when this
-is given twice.
+is given twice or three times.
 .TP
 \fI\-I, \-\-separate\-channels\fP 
 One file for each channel

--------------090503020009000902080700--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
