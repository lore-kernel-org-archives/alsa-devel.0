From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001320]: CA0106 with Soundblaster 24-bit live does not allow recording
Date: Sun, 30 Oct 2005 20:57:06 +0100
Message-ID: <aff2f6dcd05347cc5fd5bf3fc328d275@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BC16170
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 20:57:07 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1320> 
======================================================================
Reported By:                ammiellodebar
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1320
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Arch Linux
Kernel Version:             
======================================================================
Date Submitted:             08-08-2005 06:03 CEST
Last Modified:              10-30-2005 20:57 CET
======================================================================
Summary:                    CA0106 with Soundblaster 24-bit live does not allow
recording
Description: 
When I use the line in on the card, it will not capture unless i crank up
the mixer to near peak, and then its garbled and distorted sound, my
capture is up all the way and i know its not a dumb mistake of mine


======================================================================

----------------------------------------------------------------------
 ammiellodebar - 08-21-05 23:56 
----------------------------------------------------------------------
I thought capture was mic but i guess not, so the mic bug for ca0106
relates to mine, actually the same bug really

thanks jc, you the man



----------------------------------------------------------------------
 jcdutton - 08-12-05 23:11 
----------------------------------------------------------------------
Please try alsa-driver 1.0.9b.


----------------------------------------------------------------------
 ammiellodebar - 08-13-05 03:40 
----------------------------------------------------------------------
Unfortunately it doesnt work with 1.0.9b, still the same problem

----------------------------------------------------------------------
 ammiellodebar - 08-21-05 23:56 
----------------------------------------------------------------------
i see jcdutton has fixed this! now..... if only the development version
would compile right without errors!!!!

----------------------------------------------------------------------
 jcdutton - 09-10-05 10:36 
----------------------------------------------------------------------
The development version compiles find without errors. You must be doing
something wrong.
One point to note when compiling alsa-driver, is that it has to be
compiled with the same version of GCC as the rest of the kernel. You might
have compiled the kernel and upgraded GCC since.
So, if you have not compiled the kernel yourself and installed that
version, alsa-driver is unlikely to compile.
So, I think a better test would be to compile and install your own kernel,
leaving all kernel sound options as MODULES. The reboot into the new
kernel and then compile alsa-driver.

----------------------------------------------------------------------
 ammiellodebar - 09-10-05 18:15 
----------------------------------------------------------------------
I got it to compile i had to go into alsa-kernel/pci/ac97/ac97_bus.c and
delete the first include and insert #include <sound/driver.h> or
something..

solved here..

----------------------------------------------------------------------
 qqtortqq - 09-15-05 06:37 
----------------------------------------------------------------------
I have updated alsa-driver alsa-lib and alsa-oss all to 1.0.10rc1 and I
don't see recording as being fixed.  On OSS and also ALSA recording
programs, I get a zero sound, but no errors.  Passthrough is working
properly though.  

In alsamixer, any sliders that I can set to capture refuse to allow me to
adjust volume.  I DO see Mic/Line In capture now, but can't make the
slider move above 0.

----------------------------------------------------------------------
 qqtortqq - 10-12-05 06:45 
----------------------------------------------------------------------
Is there anything I can provide to help? Any code I can test?

----------------------------------------------------------------------
 jcdutton - 10-23-05 19:37 
----------------------------------------------------------------------
How does the passthrough work?
On my SB live the mic is shared with the SPDIF, so one cannot do both at
the same time. Are the connections different on your sound card?

----------------------------------------------------------------------
 qqtortqq - 10-30-05 03:54 
----------------------------------------------------------------------
Passthrough works great starting with the latest version's RC1.  I have 5
jacks on my card, one is a line AND mic input, next is stereo out, then
rear out, then center/sub out, then SPDIF out.  I think that is the order.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 06:03 ammiellodebar  New Issue                                    
08-08-05 06:03 ammiellodebar  Distribution              => Arch Linux      
08-09-05 04:13 ammiellodebar  Note Added: 0005717                          
08-12-05 23:11 jcdutton       Note Added: 0005791                          
08-12-05 23:11 jcdutton       Status                   assigned => feedback
08-13-05 03:40 ammiellodebar  Note Added: 0005800                          
08-21-05 23:56 ammiellodebar  Note Added: 0005887                          
08-21-05 23:56 ammiellodebar  Note Edited: 0005717                         
09-10-05 10:36 jcdutton       Note Added: 0006108                          
09-10-05 18:15 ammiellodebar  Note Added: 0006124                          
09-15-05 06:37 qqtortqq       Note Added: 0006192                          
09-15-05 06:51 qqtortqq       Issue Monitored: qqtortqq                    
10-12-05 06:45 qqtortqq       Note Added: 0006461                          
10-23-05 19:37 jcdutton       Note Added: 0006513                          
10-30-05 03:54 qqtortqq       Note Added: 0006572                          
10-30-05 20:57 jcdutton       Status                   feedback => assigned
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
