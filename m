From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000999]: Right rear channel in cs46xx driver in kernel 2.6.11 doesn't work
Date: Sat, 19 Mar 2005 05:45:15 +0100
Message-ID: <d283318fff99f5bb84c9827aeea53957@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 72408257
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 05:45:15 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              03-19-2005 05:45 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 05:45 rjmx           New Issue                                    
03-19-05 05:45 rjmx           Distribution              => Debian testing (with
locally-compiled kernel from source)
03-19-05 05:45 rjmx           Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
