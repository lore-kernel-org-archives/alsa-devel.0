From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000583]: xruns when playing audio or video files
Date: Thu, 15 Sep 2005 15:13:43 +0200
Message-ID: <e330019a2464534cfd04753ba67fb0c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8437A178
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:13:43 +0200 (MEST)
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


The issue 0000490 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=583> 
======================================================================
Reported By:                KAtiOS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   583
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.9_rc4
======================================================================
Date Submitted:             10-15-2004 16:27 CEST
Last Modified:              09-14-2005 21:58 CEST
======================================================================
Summary:                    xruns when playing audio or video files
Description: 
I get xruns when playing files.
I tested with lots of 2.6 kernels, up to 2.6.9_rc4 with the same results.
It seems that mplayer with sdl output works fine, but xruns with alsa.
Using acpi=off or pci=noacpi helps in mplayer but not in vdr (with
softdevice plugin - using alsa).



======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000776 desynchronization, xruns when running m...
has duplicate       0000490 &nbsp;Choppy sound when playing on Acer...
======================================================================

----------------------------------------------------------------------
 lee - 10-15-04 18:43 
----------------------------------------------------------------------
This is a kernel issue, not an ALSA bug.  If you want xrun-free operation
you HAVE to use a kernel patched for low latency.  Please close this bug.

----------------------------------------------------------------------
 KAtiOS - 10-15-04 18:51 
----------------------------------------------------------------------
Since when a low latency [so.. patched] kernel is needed to listen to music
and play video correctly?
Given that the processor isn't particulary weak and that's the only task
of the system, it shouldn't be hard to keep pace.

----------------------------------------------------------------------
 lee - 10-15-04 19:02 
----------------------------------------------------------------------
OK, you are right, you should not need to patch the kernel to avoid massive
xruns with regular AV playback.  The reason I say it's a kernel issue is
that disabling ACPI seems to fix the problem.

Do you get fewer xruns if you disable xrun debugging?  This can cause a
cascade effect where a single xrun triggers hundreds of them due to printk
overhrad.

Also, does it work OK with a 2.4 kernel?

----------------------------------------------------------------------
 KAtiOS - 10-15-04 19:12 
----------------------------------------------------------------------
Disabling ACPI seems to help with mplayer, but mplayer causes troubles only
a few times in the duration of a music, whereas VDR got several xruns a
second, whether ACPI is disabled or not. 
I tried with xrun debugging desactived but VDR acts the same (visibly at
least).

I haven't used a 2.4 in months, would it helped it I tried with one?

----------------------------------------------------------------------
 KAtiOS - 10-15-04 19:24 
----------------------------------------------------------------------
Also note that I tried in the past with and without preempt without making
a major difference that I can still think of.
(preemp activated right now btw)

----------------------------------------------------------------------
 lee - 10-15-04 19:29 
----------------------------------------------------------------------
I get the occasional xrun with mplayer even with the latest 2.6 low latency
kernels.  I figure it's a bug in mplayer's ALSA support.  VDR I don't
know.  Do other users of that program report the same issue?

There are many, many apps out there with buggy ALSA support but good OSS
support.  Try a known good app like aplay or alsaplayer.

----------------------------------------------------------------------
 KAtiOS - 10-15-04 20:28 
----------------------------------------------------------------------
Humm.. yes but since mplayer seems to be working ok with audio files, I
don't think alsaplayer will help.
I just tested, I have xrun with a video played with mplayer (acpi off)
Any video player I could test?

----------------------------------------------------------------------
 lee - 10-15-04 22:17 
----------------------------------------------------------------------
If audio plays back OK but AV playback causes xruns, then this cannot be an
ALSA issue.  Mplayer's ALSA support is known to be buggy.  I am not sure
there is a video player with known good ALSA support.  You might want to
ask on the alsa-user list.

----------------------------------------------------------------------
 KAtiOS - 10-15-04 23:49 
----------------------------------------------------------------------
Tested again with mplayer, I still get xruns with audio files, but less
often than with acpi on. Alsaplayer seems to be working ok (yet)

But what's the point of using Alsa if no third party software is able to
use it correctly?

Btw I've used mplayer and alsa on other computers and never got any xruns.
The only difference I can see is hardware, and so hardware driver (here
atiixp alsa driver)

----------------------------------------------------------------------
 lee - 10-16-04 01:11 
----------------------------------------------------------------------
There is lots of third party software that does use the ALSA API correctly.
 But mplayer is simply an incorrect design.  It's single-threaded, and
updates everything - GUI, sound, video - in one thread.  So when you move
the mouse to the bottom of the screen to bring up the control panel, you
get skips in the output.  

I tried it here and just switching windows causes a 400 ms xrun.

Please close this bug.

----------------------------------------------------------------------
 lee - 10-16-04 01:18 
----------------------------------------------------------------------
More info:

This is _definitely_ a bug in Mplayer.  It's trivial to reproduce.  I
tested here with several different video files and producing _any_ load on
the system - switching windows for example - will produce massive xruns.

Using OSS emulation (mplayer -ao oss) works fine.  So this is not an ALSA
problem.

Please ask the Mplayer developers to fix their program.  Their buggy ALSA
support is making ALSA look bad.

----------------------------------------------------------------------
 lee - 10-16-04 06:05 
----------------------------------------------------------------------
OK, I tried xine (on my Debian system this was accessible via the totem gui
frontend), and it works perfectly.  Supports ALSA, plays the same files as
mplayer, with no xruns.  Can you try xine to verify that mplayer is the
problem?

----------------------------------------------------------------------
 KAtiOS - 10-16-04 10:08 
----------------------------------------------------------------------
I'll try ASAP with xine. But please consider that I never had a single xrun
(with alsa of course) with mplayer on other computers.
Here i get some, more with acpi.
So there is a ACPI problem, plus according to you a mplayer problem, and I
get you're also saying that vdr-softdevice is guilty (but lots a xruns a
second is quite a bug that can't be hidden long if it's with any alsa
system..-remember that this soft doesn't give a choice of the sound
system).
Also I get xrun with mplayer without using the computer; and having load
(compiling or burncpu-ing) doesn't make the xruns worse (even had the
feeling that it got the things better at times)

----------------------------------------------------------------------
 KAtiOS - 10-16-04 11:39 
----------------------------------------------------------------------
Ok, tested with xine, it seems to be working, except with HDTV files but I
supposed it's normal given the load.
So, even if almost every alsa apps causes xruns on some hardware only, as
long as it's their use of alsa which is bad, that's not a problem.
How alsa can be so hard to implement correctly so that experienced
programmers can't make their software usable on every platform?

[Question : if I can test another sound card on the same computer, could I
conclude something with the result with mplayer/vdr-softdevice before
definitely closing this bug?]

----------------------------------------------------------------------
 jdthood - 09-14-05 15:52 
----------------------------------------------------------------------
Is there a consensus that this report can be closed,
because the problem is really in mplayer?

----------------------------------------------------------------------
 KAtiOS - 09-14-05 17:44 
----------------------------------------------------------------------
Well, I gave up on this months ago, but looking at my messages, I would say
that the problem, which occured *only* for me in this particular config
(chip) in both mplayer and vdr, nothing excluded a bug in alsa, but
whatever...

----------------------------------------------------------------------
 rlrevell - 09-14-05 21:58 
----------------------------------------------------------------------
Hmm, this could have been the ACPI idle latency bug.  That would explain
why generating load reduces the xruns.  This was fixed around 2.6.11.

Try kernel 2.6.13.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 16:27 KAtiOS         New Issue                                    
10-15-04 16:27 KAtiOS         Distribution              => Gentoo Linux    
10-15-04 16:27 KAtiOS         Kernel Version            => 2.6.9_rc4       
10-15-04 18:43 lee            Note Added: 0002168                          
10-15-04 18:51 KAtiOS         Note Added: 0002169                          
10-15-04 19:02 lee            Note Added: 0002170                          
10-15-04 19:12 KAtiOS         Note Added: 0002171                          
10-15-04 19:24 KAtiOS         Note Added: 0002172                          
10-15-04 19:29 lee            Note Added: 0002173                          
10-15-04 20:28 KAtiOS         Note Added: 0002174                          
10-15-04 22:17 lee            Note Added: 0002175                          
10-15-04 23:49 KAtiOS         Note Added: 0002176                          
10-16-04 01:11 lee            Note Added: 0002180                          
10-16-04 01:18 lee            Note Added: 0002181                          
10-16-04 06:05 lee            Note Added: 0002183                          
10-16-04 10:08 KAtiOS         Note Added: 0002185                          
10-16-04 11:39 KAtiOS         Note Added: 0002186                          
09-14-05 15:52 jdthood        Note Added: 0006161                          
09-14-05 16:14 jdthood        Relationship added       has duplicate 0000776
09-14-05 17:44 KAtiOS         Note Added: 0006185                          
09-14-05 21:58 rlrevell       Note Added: 0006186                          
09-15-05 15:13 jdthood        Relationship added       has duplicate 0000490
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
