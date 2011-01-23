From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: commit 109fef9edcc100952eec980acbc2e1295627fbab ALSA:
 timer: automatically load the high-resolution timer causing MIDI playback
 tempo problems
Date: Mon, 24 Jan 2011 01:15:22 +1030
Message-ID: <4D3C3F02.7050008@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F0DFB103809
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 15:48:37 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Ph1F6-0008Q3-UL
	for alsa-devel@alsa-project.org; Sun, 23 Jan 2011 15:48:36 +0100
Received: from ppp121-45-139-71.lns21.adl2.internode.on.net ([121.45.139.71])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 15:48:36 +0100
Received: from arthur.marsh by ppp121-45-139-71.lns21.adl2.internode.on.net
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 15:48:36 +0100
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi, on an old machine I have with Intel 440BX chipset and PII-266 CPU, I 
found recent kernels causing MIDI sound output from a Soundblaster 
Audigy 2 ZS to be varying widely in tempo.

dmesg reports with recent kernels (both those that allow correct 
playback of MIDI files and those that give wide variation in playback 
tempo):

Clocksource tsc unstable (delta = 132040172 ns)
Switching to clocksource pit

After git-bisection I found:

git bisect bad
109fef9edcc100952eec980acbc2e1295627fbab is the first bad commit
commit 109fef9edcc100952eec980acbc2e1295627fbab
Author: Clemens Ladisch <clemens@ladisch.de>
Date:   Thu Nov 18 09:53:54 2010 +0100

     ALSA: timer: automatically load the high-resolution timer

     Increase the default timer limit so that snd-hrtimer.ko can be
     automatically loaded when needed, e.g., when used as the default
     sequencer timer.  This replaces the check for the obsolete
     CONFIG_SND_HPET.

     Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
     Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 c7b3b046ea99e563228f36ea4a00f9b763bf5813 
741f137a201b31bdf5eaaa58c3031b4b2a68c6d6 M      sound

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 13afb60..b3aaa60 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -34,8 +34,8 @@
  #include <sound/initval.h>
  #include <linux/kmod.h>

-#if defined(CONFIG_SND_HPET) || defined(CONFIG_SND_HPET_MODULE)
-#define DEFAULT_TIMER_LIMIT 3
+#if defined(CONFIG_SND_HRTIMER) || defined(CONFIG_SND_HRTIMER_MODULE)
+#define DEFAULT_TIMER_LIMIT 4
  #elif defined(CONFIG_SND_RTCTIMER) || defined(CONFIG_SND_RTCTIMER_MODULE)
  #define DEFAULT_TIMER_LIMIT 2
  #else

I am currently rebuilding kernel 2.6.38-rc2 with this patch reverted to 
verify that this commit triggers the problem with this machine.

Arthur.
