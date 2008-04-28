From: Travis Place <wishie@wishie.net>
Subject: [PATCH] alsa-info.sh - Add another distro to search for
Date: Tue, 29 Apr 2008 00:10:52 +1000
Message-ID: <200804290010.52696.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-102-010.dial.usertools.net [202.137.102.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 223EC24631
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 16:12:40 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 79AA52ECE7
	for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2008 14:33:33 +1000 (EST)
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

Just allows finding of "Pardus" distro.


diff -r e167861901c7 alsa-info.sh
--- a/alsa-info.sh	Tue Feb 26 10:55:47 2008 +0100
+++ b/alsa-info.sh	Tue Apr 29 00:09:20 2008 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.41
+SCRIPT_VERSION=0.4.42
 CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
 
 
#################################################################################
@@ -270,7 +270,7 @@ mkdir $TEMPDIR 2>/dev/null
 mkdir $TEMPDIR 2>/dev/null
 
 #Fetch the info and store in temp files/variables
-DISTRO=`grep -ihs "buntu\|SUSE\|Fedora\|PCLinuxOS\|MEPIS\|Mandriva\|Debian\|
Damn\|Sabayon\|Slackware\|KNOPPIX\|Gentoo\|Zenwalk\|Mint\|Kubuntu\|FreeBSD\|
Puppy\|Freespire\|Vector\|Dreamlinux\|CentOS\|Arch\|Xandros\|Elive\|SLAX\|
Red\|BSD\|KANOTIX\|Nexenta\|Foresight\|GeeXboX\|Frugalware\|64\|
SystemRescue\|Novell\|Solaris\|BackTrack\|
KateOS" /etc/{issue,*release,*version}`
+DISTRO=`grep -ihs "buntu\|SUSE\|Fedora\|PCLinuxOS\|MEPIS\|Mandriva\|Debian\|
Damn\|Sabayon\|Slackware\|KNOPPIX\|Gentoo\|Zenwalk\|Mint\|Kubuntu\|FreeBSD\|
Puppy\|Freespire\|Vector\|Dreamlinux\|CentOS\|Arch\|Xandros\|Elive\|SLAX\|
Red\|BSD\|KANOTIX\|Nexenta\|Foresight\|GeeXboX\|Frugalware\|64\|
SystemRescue\|Novell\|Solaris\|BackTrack\|KateOS\|
Pardus" /etc/{issue,*release,*version}`
 KERNEL_VERSION=`uname -r`
 KERNEL_PROCESSOR=`uname -p`
 KERNEL_MACHINE=`uname -m`


-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
