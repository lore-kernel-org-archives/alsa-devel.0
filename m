From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#658762: arecord: manpage has
 typos in examples
Date: Mon, 6 Feb 2012 13:33:09 +0100
Message-ID: <20120206123308.GB2520@samweis.home.lxtec.de>
References: <20120205214220.GA394@home.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
	[83.223.95.204])
	by alsa0.perex.cz (Postfix) with ESMTP id C1B07103AC5
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 13:33:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120205214220.GA394@home.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yann Dirson <ydirson@free.fr>, 658762@bugs.debian.org
Cc: alsa-devel <alsa-devel@alsa-project.org>, control@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

forwarded 658762 alsa-devel@alsa-project.org
tags 658762 patch
thanks


* Yann Dirson [120205 22:42 +0100]:

> Package: alsa-utils
> Version: 1.0.24.2-4
> Severity: normal
> 
> The examples in manpage talk about -max-file_time, while the correct
> name is --max-file-time (2 typos packed in one option, at least twice
> in the manpage).

Patch attached

Elimar


-- 
  We all know Linux is great... it does infinite loops in 5 seconds.
        -Linus Torvalds

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="arecord.1_typo_fix.diff"

diff -Naurd alsa-utils-1.0.24.2.orig/aplay/aplay.1 alsa-utils-1.0.24.2/aplay/aplay.1
--- alsa-utils-1.0.24.2.orig/aplay/aplay.1	2012-01-27 10:15:08.000000000 +0100
+++ alsa-utils-1.0.24.2/aplay/aplay.1	2012-02-06 13:24:30.861630194 +0100
@@ -209,14 +209,14 @@
 .fi
 
 .TP
-\fBarecord \-t wav \-max-file_time 30 mon.wav\fP
+\fBarecord \-t wav \-\-max-file-time 30 mon.wav\fP
 Record from the default audio source in monaural, 8,000 samples
 per second, 8 bits per sample.  Start a new file every
 30 seconds.  File names are mon-nn.wav, where nn increases
 from 01.  The file after mon-99.wav is mon-100.wav.
 
 .TP
-\fBarecord \-f cd \-t wav \-max-file-time 3600 --use-strftime %Y/%m/%d/listen-%H-%M-%v.wav\fP
+\fBarecord \-f cd \-t wav \-\-max-file-time 3600 --use-strftime %Y/%m/%d/listen-%H-%M-%v.wav\fP
 Record in stereo from the default audio source.  Create a new file
 every hour.  The files are placed in directories based on their start dates
 and have names which include their start times and file numbers.
diff -Naurd alsa-utils-1.0.24.2.orig/aplay/arecord.1 alsa-utils-1.0.24.2/aplay/arecord.1
--- alsa-utils-1.0.24.2.orig/aplay/arecord.1	2012-01-27 10:15:08.000000000 +0100
+++ alsa-utils-1.0.24.2/aplay/arecord.1	2012-02-06 13:24:30.861630194 +0100
@@ -209,14 +209,14 @@
 .fi
 
 .TP
-\fBarecord \-t wav \-max-file_time 30 mon.wav\fP
+\fBarecord \-t wav \-\-max-file-time 30 mon.wav\fP
 Record from the default audio source in monaural, 8,000 samples
 per second, 8 bits per sample.  Start a new file every
 30 seconds.  File names are mon-nn.wav, where nn increases
 from 01.  The file after mon-99.wav is mon-100.wav.
 
 .TP
-\fBarecord \-f cd \-t wav \-max-file-time 3600 --use-strftime %Y/%m/%d/listen-%H-%M-%v.wav\fP
+\fBarecord \-f cd \-t wav \-\-max-file-time 3600 --use-strftime %Y/%m/%d/listen-%H-%M-%v.wav\fP
 Record in stereo from the default audio source.  Create a new file
 every hour.  The files are placed in directories based on their start dates
 and have names which include their start times and file numbers.

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--eJnRUKwClWJh1Khz--
