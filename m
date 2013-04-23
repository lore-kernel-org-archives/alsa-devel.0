From: Mark Hills <mark@xwax.org>
Subject: Per-host .asoundrc on shared $HOME
Date: Tue, 23 Apr 2013 21:41:27 +0100 (BST)
Message-ID: <alpine.LNX.2.01.1304232118010.9238@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1722610C0
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2013 22:41:28 +0200 (CEST)
Received: from cpc5-hari13-2-0-cust67.20-2.cable.virginmedia.com
 ([82.45.173.68] helo=localhost)
 by wes.ijneb.com with esmtpa (Exim 4.77)
 (envelope-from <mark@pogo.org.uk>) id 1UUk1n-0007PJ-UX
 for alsa-devel@alsa-project.org; Tue, 23 Apr 2013 21:41:27 +0100
Received: from mark (helo=localhost) by localhost with local-esmtp (Exim 4.69)
 (envelope-from <mark@xwax.org>) id 1UUk1n-0002T1-GL
 for alsa-devel@alsa-project.org; Tue, 23 Apr 2013 21:41:27 +0100
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

There is a very old thread [1] on alsa-user on this topic which seems to 
go through some yucky solutions. I have the same use case, and post some 
findings here.

Since pre-2003 alsa-lib calls wordexp(3) on the filenames. I am using the 
patch below in /usr/share/alsa/alsa.conf

It follows a precedent set by other files such as .Xdefaults-hostname.

I'd submit a patch, except there seems to be no guarantee that HOSTNAME is 
in the environment (on Slackware it is explicitly set in /etc/profile.) 
Without it I can only see a bash local variable.

>From the old thread I imagine this function (or at least this mail) would 
be useful to others.

Would it be better to patch the C code to provide a token (eg. '\h') that 
is substituted by the hostname? Or is it enough to assume that HOSTNAME 
would be set?

I didn't consider short vs. long hostnames, I suppose $HOSTNAME gives the 
user/admin some control over this.

This:

  ~/.asoundrc-$(hostname -s)

may work, but I don't see that forking a process is an option.

[1] http://thread.gmane.org/gmane.linux.alsa.user/27532/focus=27542

-- 
Mark


--- alsa.conf.orig	2013-04-23 21:22:45.105454493 +0100
+++ alsa.conf	2013-04-23 21:16:41.707053308 +0100
@@ -17,6 +17,7 @@
 			}
 			"/etc/asound.conf"
 			"~/.asoundrc"
+			"~/.asoundrc-$HOSTNAME"
 		]
 		errors false
 	}
