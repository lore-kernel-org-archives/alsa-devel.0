From: Travis Place <wishie@wishie.net>
Subject: Re: alsa-info.sh script
Date: Mon, 18 Feb 2008 03:33:46 +1000
Message-ID: <200802180333.46134.wishie@wishie.net>
References: <200802121350.38373.wishie@wishie.net>
	<Pine.LNX.4.64.0802120905590.19448@server.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EE47243FF
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2008 18:34:08 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 32D7886BA
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2008 17:55:00 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0802120905590.19448@server.perex.cz>
Content-Disposition: inline
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

On Tue, 12 Feb 2008 6:09:33 pm Jaroslav Kysela wrote:
> On Tue, 12 Feb 2008, Travis Place wrote:
> > Is there any chance that i will be able to push updates for my script
> > back to ALSA?
> >
> > Or is this to be a no-go ?
>
> Please, send unified diff (diff -u <oldfile> <newfile>, or use hg diff if
> you work with hg repo, to this mailing list. I or other developer with
> write access to HG repository will review and commit your changes and will
> notify you.
>
> 					Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Below is the diff of my changes to alsa-info.sh .. This makes use of the new 
collapsable sections that i asked slepp (owner of pastebin.ca) to create.

Basically, just makes the output a bit more readable on first glance.



diff -r 9877b6757b24 alsa-info.sh
--- a/alsa-info.sh	Mon Feb 04 09:41:02 2008 +0100
+++ b/alsa-info.sh	Mon Feb 18 03:30:57 2008 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.36
+SCRIPT_VERSION=0.4.37
 CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
 
 
#################################################################################
@@ -123,7 +123,9 @@ withalsactl() {
         	exe=`whereis alsactl | cut -d ' ' -f 2`
         fi
 	$exe -f /tmp/alsainfo/alsactl.tmp store
+	echo "--startcollapse--" >> $FILE
 	cat /tmp/alsainfo/alsactl.tmp >> $FILE
+	echo "--endcollapse--" >> $FILE
 	echo "" >> $FILE
 	echo "" >> $FILE
 }
@@ -353,8 +355,10 @@ then
 then
 	echo "!!HDA-Intel Codec information" >> $FILE
 	echo "!!---------------------------" >> $FILE
+	echo "--startcollapse--" >> $FILE
 	echo "" >> $FILE
 	cat /tmp/alsainfo/alsa-hda-intel.tmp >> $FILE
+	echo "--endcollapse--" >> $FILE
 	echo "" >> $FILE
 	echo "" >> $FILE
 fi



-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
