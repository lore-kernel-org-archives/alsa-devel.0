From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000999]: Right rear channel in cs46xx driver in kernel 2.6.11 doesn't work
Date: Sun, 20 Mar 2005 21:41:50 +0100
Message-ID: <a8d174a5f97e14a6bf6d8810f76f529f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A00271FA
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 21:41:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=999> 
======================================================================
Reported By:                rjmx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   999
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian testing (with locally-compiled kernel from
source)
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-19-2005 05:45 CET
Last Modified:              03-20-2005 21:41 CET
======================================================================
Summary:                    Right rear channel in cs46xx driver in kernel 2.6.11
doesn't work
Description: 
I've been using the rear channel of my Turtle Beach Santa Cruz card
(which uses the cs46xx driver) to drive an external stereo amplifier
for several years now, with no problems. However, it seems to be
broken in kernel 2.6.11: there's little or no output from the right rear
channel. Left channel works fine, and going back to a 2.6.10 kernel
gets me both rear channels working again.

I'm not sure if this is a known problem or not, but has anything changed
in the
cs46xx code between 2.6.10 and 2.6.11? 

I can see this in the changelog:


>>    A new mixer control 'Duplicate Front' is added for the board with
>>    a single codec.  This toggles the duplication of front signal to
>>    the rear speakers.


   which may have something to do with it, but I don't see any such
control in alsamixer. The system runs Debian sarge, and here's the
current software versions:


>>  alsa-base      1.0.8-7
>>  alsa-source    1.0.8-7
>>  alsa-utils     1.0.8-4


Thanks,

 .....Ron

======================================================================

----------------------------------------------------------------------
 rjmx - 03-20-05 21:41 
----------------------------------------------------------------------
This problem seems to have been fixed in kernel patch 2.6.11.5:

>From the changelog:

> <dsd@gentoo.org>
> 	[PATCH] Fix stereo mutes on Surround volume control
> 	
> 	As of 2.6.11, I have no output out of the rear right speaker of my 4.1
> 	surround sound setup. I am using snd-intel8x0 based on a Realtek
>         ALC650F chip on an nvidia motherboard.
> 	
> 	A gentoo user with completely different hardware also ran into this:
> 	http://bugs.gentoo.org/84276
> 	
> 	2.6.11-mm3 fixes this problem and I've identified the specific
>       fix, which is already in the ALSA development tree. An ALSA
>       developer asked me to submit the
> 	fix for 2.6.11.x when I'd found it, so here it is :)
> 	
> 	--
> 	AC97 Codec
> 	Fix stereo mutes on Surround volume control.
> 	
> 	Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 	Signed-off-by: Chris Wright <chrisw@osdl.org>
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 05:45 rjmx           New Issue                                    
03-19-05 05:45 rjmx           Distribution              => Debian testing (with
locally-compiled kernel from source)
03-19-05 05:45 rjmx           Kernel Version            => 2.6.11          
03-20-05 21:41 rjmx           Note Added: 0004101                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
