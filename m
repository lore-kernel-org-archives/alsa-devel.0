From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: alsaconf usefulness
Date: Sun, 20 Jan 2008 20:19:29 +0500
Message-ID: <c072ca310801200719o48509a73t199285720ac8cc82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 40BCE2436D
	for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2008 16:19:31 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3036928wag.8
	for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2008 07:19:29 -0800 (PST)
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

Hello developers,

Debian applies the following patch to alsaconf:

Index: alsa-utils-1.0.15/alsaconf/alsaconf.in
===================================================================
--- alsa-utils-1.0.15.orig/alsaconf/alsaconf.in	2007-10-21
14:57:02.000000000 +0200
+++ alsa-utils-1.0.15/alsaconf/alsaconf.in	2007-10-21 14:57:02.000000000 +0200
@@ -458,8 +458,16 @@
     Advanced Linux Sound Architecture (ALSA) driver.


-  You should stop all sound applications now." $version)
-  $DIALOG --msgbox "$msg" 20 63 || acex 0
+  You should stop all sound applications now.
+
+  Please notice, that sound configuration with this script
+  is not needed if you are running testing/sid with an up
+  to date kernel and your sound device is a supported PCI
+  one. In that case *udev* is predestinated to load your
+  driver ;)
+  But any way, you can finish this procedure with a working
+  PCI-Sound at the end." $version)
+  $DIALOG --msgbox "$msg" 24 63 || acex 0
 }

 # FAREWELL

The added note is completely valid: in most cases, there is nothing to
do, even for ISA-PnP cards (because all self-respecting distributions
already contain a rule for loading ISA-PnP drivers). However, the very
presence of alsaconf generates a lot of support traffic on forums in
the form "I have tried alsaconf and it didn't help" (or worse, ruined
a working setup). Also, it cannot deal with more than one sound card.

Could you please either apply the above patch (of course, replacing
the wording with a distro-neutral one), or just drop this obsolete
program and replace it with the "alsa-unmute" script which essentially
contains the same as the set_mixers() function (but allows to specify
the card to unmute)?

-- 
Alexander E. Patrakov
