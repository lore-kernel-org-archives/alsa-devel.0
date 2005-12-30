From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001015]: Static when not playing through the OSS Emulation
Date: Fri, 30 Dec 2005 05:20:48 +0100
Message-ID: <ef591f36ed497b12ca9ddfee8968fc41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A0689193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:20:48 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1015> 
======================================================================
Reported By:                wintermute77
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1015
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:              2.6.10-ck5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-25-2005 04:00 CET
Last Modified:              12-30-2005 05:20 CET
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
12-30-05 05:20 rlrevell       Status                   new => resolved     
12-30-05 05:20 rlrevell       Resolution               open => fixed       
12-30-05 05:20 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
