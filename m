From: noreply@alsa-project.org
Subject: [ALSA - driver 0000096]: no stereo-sound after using AC3-Passthrough using Mplayer or Xine
Date: Fri, 16 Jul 2004 14:33:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123305.9429D2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1A231CC
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:33:05 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000096
======================================================================
Reported By:                nils
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     96
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.18-3-k7, 2.4.24-1-k7
======================================================================
Date Submitted:             02-27-2004 21:19 CET
Last Modified:              07-16-2004 14:33 CEST
======================================================================
Summary:                    no stereo-sound after using AC3-Passthrough using Mplayer or Xine
Description: 
the stereo-sound doesn't work anymore after viewing a DVD using
AC3-passthrough.
I tried alsa version 1.0.1 and 1.0.2.
Using 0.9.0 does work.
======================================================================

----------------------------------------------------------------------
 nils - 02-27-2004 22:02 CET 
----------------------------------------------------------------------
hi,

this seems to be a _alsa-lib_ problem. I just downgraded my kernel to
2.4.20 leaving alsa-lib 1.0.1 - and nothing! but downgrading to alsa-lib
0.9+0beta12-3 makes it work again.

please change the queue of this bug to lib.

thanx.

----------------------------------------------------------------------
 perex - 02-29-2004 14:11 CET 
----------------------------------------------------------------------
Can you try toggle mixer settings in alsamixer and see what helps to fix
your problem?

----------------------------------------------------------------------
 nils - 02-29-2004 19:18 CET 
----------------------------------------------------------------------
toggling mixer settings doesn't help. the only thing that helps is
restarting alsa using /etc/init.d/alsa restart.

----------------------------------------------------------------------
 perex - 02-29-2004 20:16 CET 
----------------------------------------------------------------------
Can you try to do (> means command):

...check if standard stereo output works here...
> alsactl -f test.ok.conf store
...reproduce the problematic state...
> alsactl -f test.broken.conf store
> alsactl -f test.ok.conf restore
...check if stereo output works...

And send me test.ok.conf and test.broken.conf files with result (if stereo
output
works again after last command).

----------------------------------------------------------------------
 jcdutton - 03-12-2004 03:14 CET 
----------------------------------------------------------------------
I have observed this problem.
The problem I saw was that after playing AC3 non-audio data from the spdif
digital output, sometimes, if the application exited unexpectedly, the
default settings for the spdif changed. E.g. default normally is non-audio
bit not set. but after the fault, the non-audio bit is stuck on.
So, when someone goes to play a normal stereo PCM signal, the application
does not bother to reset any spdif non-audio bits, and just outputs the
PCM signal, but as the external receiver still sees the non-audio bit set,
but no valid AC3 frames, no sound comes from the external receiver.
This has been a long standing problem for about 1.5 years now, but I just
do "/etc/init.d/alsasound restart" to fix it. Of course, this fix is not
really a good idea if one was using alsa on an embedded system.

----------------------------------------------------------------------
 perex - 03-13-2004 16:23 CET 
----------------------------------------------------------------------
It's not a real bug. You have to terminate your application correctly, so
snd_pcm_close() is called. Then the S/PDIF bits are recovered. Otherwise
S/PDIF bits stay set to non-audio stream.

You may use iecset utility from alsa-utils to recover S/PDIF status bits.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-27-04 21:19 nils           New Bug                                      
02-27-04 21:23 nils           Bug Monitored: nils                          
02-27-04 22:02 nils           Bugnote Added: 0000384                       
02-29-04 14:11 perex          Bugnote Added: 0000390                       
02-29-04 19:18 nils           Bugnote Added: 0000392                       
02-29-04 20:16 perex          Bugnote Added: 0000394                       
02-29-04 20:16 perex          Assigned To               => perex           
02-29-04 20:16 perex          Status                   new => assigned     
03-12-04 03:14 jcdutton       Bugnote Added: 0000573                       
03-13-04 16:23 perex          Bugnote Added: 0000593                       
03-13-04 16:23 perex          Resolution               open => fixed       
03-13-04 16:23 perex          Status                   assigned => resolved
07-16-04 14:33 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
