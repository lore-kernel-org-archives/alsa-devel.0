From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001015]: Static when not playing through the OSS Emulation
Date: Sat, 26 Mar 2005 00:52:13 +0100
Message-ID: <e0a967b0fc807d478e472512c187e051@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0A1A81F7
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2005 00:52:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1015> 
======================================================================
Reported By:                wintermute77
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1015
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:              2.6.10-ck5
======================================================================
Date Submitted:             03-25-2005 04:00 CET
Last Modified:              03-26-2005 00:52 CET
======================================================================
Summary:                    Static when not playing through the OSS Emulation
Description: 
I get crackling static coming in when sound is being output to my speakers
(not when there is nothing playing) using the ice1724 driver with my
M-Audio Revolution 7.2.  The problem appears to go away if I use OSS
emulation, but of course this isn't desirable since I cannot use dmix in
this case.

I am using xmms and mplayer to produce the badness.
======================================================================

----------------------------------------------------------------------
 wintermute77 - 03-26-05 00:50 
----------------------------------------------------------------------
I appear to have resolved my problem.  

I upgraded to 2.6.11-ck2 (which I think had a newer alsa in the kernel)
and used the following dmix configuration, and it worked flawlessly (so
far):

/etc/asound.conf

pcm.ossmix {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"
        period_time 0
        period_size 1024
        buffer_size 4096 # buffer size < 6653, but pow(x, 2)
        rate 44100       # we want to play CDs only
    }
    bindings {
        0 0
        1 1
    }
}
# Everything shall be dmixed, so redefine "default":
pcm.!default {
    type plug
    slave.pcm "ossmix"
}
# OSS via aoss should d(mix)stroyed:
pcm.dsp0 {    type plug
    slave.pcm "ossmix"
}
ctl.mixer0 {
    type hw
    card 0
}

----------------------------------------------------------------------
 wintermute77 - 03-26-05 00:52 
----------------------------------------------------------------------
Also, it appears the static comes back if I remove the "rate 44100" line.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 04:00 wintermute77   New Issue                                    
03-25-05 04:00 wintermute77   Distribution              => Gentoo          
03-25-05 04:00 wintermute77   Kernel Version            =>  2.6.10-ck5     
03-25-05 14:57 daspooky       Note Added: 0004207                          
03-25-05 14:58 daspooky       Note Edited: 0004207                         
03-26-05 00:09 wintermute77   Note Added: 0004214                          
03-26-05 00:50 wintermute77   Note Added: 0004215                          
03-26-05 00:52 wintermute77   Note Added: 0004216                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
