From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001083]: NVIDIA CK8 ALC655 SPDIF passthrough
Date: Fri, 10 Jun 2005 18:07:23 +0200
Message-ID: <e0d6cca0b3afa3293240a96b0be9e4bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D40EB14B
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 18:07:23 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1083> 
======================================================================
Reported By:                vedran
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1083
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-ac12
======================================================================
Date Submitted:             04-29-2005 15:33 CEST
Last Modified:              06-10-2005 18:07 CEST
======================================================================
Summary:                    NVIDIA CK8 ALC655 SPDIF passthrough
Description: 
We're using a motherboard with nVidia nforce2IGP chipset, and the sound
device on this board is NVidia CK8, Realtek ALC655 rev 0. The motherboard
is MSI K7N2GM2, and SPDIF passthrough works fine on Windows XP with stock
realtek drivers.

On Linux, I'm using the latest ALSA CVS (29.04.2005.) on a 2.6.10-ac12
kernel.

I've been able to make a 2 channel  pre-decoded SPDIF output work by using
the hw:0,2 device. If I use the default device, there is no sound on
SPDIF, regardless of the SPDIF related controls in mixer. The controls in
the mixer are:

However, I'm having trouble with AC3 passthrough, I'm using ac3dec -C from
alsa-tools CVS, and I get no sound.

I'm attaching the archive with the output of iecset and
/proc/asound/card0/codec97#0/* files during the ac3dec run, and when
idle.

Maybe the fact that decoded SPDIF output is not working until I pass it
through the hw:0,2 has something to do with this, how can I make ac3dec -C
use hw:0,2?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001094 nforce4 - optical spdif out not working
======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 15:01 
----------------------------------------------------------------------
Interesting.  First of all, the SPDIF support on nForce is partial, AFAIK. 
Since the SPDIF status bits are not set up correctly on nForce, many
digital receivers can't accept the AC3 signals.  But the PCM over SPDIF
seems working.  This was the last state I tested (quite ago).

Now, you reported that there is a regression in another point.  OK, this
has to be fixed.  Could you elaborate what did you downgrade?  The
combination of 1.0.6 driver + 1.0.9 lib works, or vice versa?

For checking, use ac3dec (with -C option) in alsa-utils to reduce other
unknown factors.

If the above combinations don't work, get /proc/asound/card0/codec97#0/*
(might be a different directory name in 1.0.6) _during_ ac3 playback on
1.0.6 and 1.0.9 environment to compare.

----------------------------------------------------------------------
 Human - 06-10-05 18:07 
----------------------------------------------------------------------
Thanks very much for responding, Tiwai.  I accept that S/PDIF with nForce
is only partially covered, but if the latest driver worked as well as the
one from R5A12, it would benefit a lot of people.

I need to amend the version of ALSA I said was used in R5A12.  It looks
like the utilities are from 1.0.6, but I took a close look at the
intel8x0.c kernel module - it's actually CVS version 1.160 with 7 lines of
patches applied.  (If you want to see the diffs, please specify the diff
parameters you prefer so that I format them correctly.)  In order to
provide you with the details on where exactly the regression happens, I
was going to try building different versions of the intel8x0.c kernel
module from 1.160 up and seeing if they made S/PDIF stop working.

Technically, I didn't downgrade anything in R5A12, since R5A12 uses an
older version of ALSA.  By contrast, R5A16 uses (I think) ALSA 1.0.8.

You ask about the version of alsa-lib.  KnoppMyth R5A12 uses Debian, and
the distro's maintainer installed the non-driver parts of ALSA as binaries
via apt-get.  Here's the result of a query:

ii  alsa-base      1.0.6a-11      ALSA driver configuration files
ii  alsa-headers   1.0.6a-11      transitional package that can be safely
remo
rc  alsa-modules-2 1.0.5a-1+10.00 Advanced Linux Sound Architecture
(drivers)
ii  alsa-source    1.0.6a-11      ALSA driver sources
ii  alsa-utils     1.0.6-4        ALSA utilities

I wanted to point out that there are additional steps in my previous list
on getting digital audio working.  I had automated these steps and
forgotten about them:
3.5) Go here http://www.mythtv.info/moin.cgi/DigitalSoundHowTo and copy
the text under "The (I hope it's the definitive) .asoundrc for nForce2 and
nForce4" into /etc/asound.conf
3.6) Edit /etc/modprobe.d/alsa-base to add this line:
      options snd-pcm-oss adsp_map=2

I'll try to gather more data points for you.  I'll have to set up a
separate installation of R5A16, which uses newer versions of everything,
and try more combinations of things as well as getting you that data
during AC3 playback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-05 15:33 vedran         New Issue                                    
04-29-05 15:33 vedran         File Added: spdif_passthrough.tar.gz              
     
04-29-05 15:33 vedran         Distribution              => Debian sid      
04-29-05 15:33 vedran         Kernel Version            => 2.6.10-ac12     
05-30-05 13:21 vedran         Note Added: 0004809                          
06-01-05 16:53 tiwai          Note Added: 0004862                          
06-01-05 16:54 tiwai          Relationship added       has duplicate 0001094
06-01-05 19:19 eklarson       Issue Monitored: eklarson                    
06-03-05 00:31 Human          Note Added: 0004880                          
06-03-05 00:32 Human          Issue Monitored: Human                       
06-06-05 23:30 Human          Note Added: 0004910                          
06-08-05 15:01 tiwai          Note Added: 0004928                          
06-10-05 18:07 Human          Note Added: 0004984                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
