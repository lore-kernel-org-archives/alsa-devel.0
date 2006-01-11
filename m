From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001734]: Multiple cards not working with jack
Date: Wed, 11 Jan 2006 21:52:42 +0100
Message-ID: <9a9398ced425ca6e61ffefd80ce31858@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DBD4160
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 21:52:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1734> 
======================================================================
Reported By:                danhien_cz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1734
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               GENTOO
Kernel Version:             2.6.12-r9
======================================================================
Date Submitted:             01-11-2006 10:33 CET
Last Modified:              01-11-2006 21:52 CET
======================================================================
Summary:                    Multiple cards not working with jack
Description: 
I've got two sound cards in my system and I'm using both of them.
After upgrading alsa-driver 1.0.8 up to 1.0.10 and upgrading
jack-audion-connection-kit from 0.99.0 to version 0.100.7 my multiple card
configuration stop working.
When I try start jack on surround51 this error message appears:
--------------------------------------------------------------
ALSA: poll time out, polled for 31973583 usecs
DRIVER NT: could not run driver cycle
--------------------------------------------------------------
When I try start jack on my multiple devices, jack crashes with
segmentation fault. Everything was working with the older versions.
This is my asound.conf file:
--------------------------------------------------------------
pcm.jack_playback {
        type multi
        slaves.a.pcm "surround51"
        slaves.a.channels 6
        slaves.b.pcm "hw:1,0"
        slaves.b.channels 2
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave a
        bindings.2.channel 2
        bindings.3.slave a
        bindings.3.channel 3
        bindings.4.slave a
        bindings.4.channel 4
        bindings.5.slave a
        bindings.5.channel 5
        bindings.6.slave b
        bindings.6.channel 0
        bindings.7.slave b
        bindings.7.channel 1
}

pcm.jack_capture {
        type multi
        slaves.a.pcm "hw:0,0"
        slaves.a.channels 2
        slaves.b.pcm "hw:1,0"
        slaves.b.channels 2
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave b
        bindings.2.channel 0
        bindings.3.slave b
        bindings.3.channel 1
}

pcm.jack12 {
        type asym
        playback.pcm {
                type route
                slave.pcm "surround51"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
                ttable.4.4 1
                ttable.5.5 1
                ttable.6.6 1
                ttable.7.7 1
        }
        capture.pcm {
                type route
                slave.pcm "jack_capture"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
        }
}

ctl.jack12 {
        type hw
        card 0
}
--------------------------------------------------------------
======================================================================

----------------------------------------------------------------------
 danhien_cz - 01-11-06 10:35 
----------------------------------------------------------------------
sound cards are:
hw0 pci soundblaster audigi 2
hw1 on board via chipset

----------------------------------------------------------------------
 johnrigg - 01-11-06 21:52 
----------------------------------------------------------------------
See bug ID 0001575.
ALSA pcm_multi plugin got broken for multi-card duplex operation in
1.0.9rc1.
Workaround is to remove the code that broke it. There's a patch that does
this
for alsa-lib-1.0.10 here:

http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 10:33 danhien_cz     New Issue                                    
01-11-06 10:33 danhien_cz     Distribution              => GENTOO          
01-11-06 10:33 danhien_cz     Kernel Version            => 2.6.12-r9       
01-11-06 10:35 danhien_cz     Note Added: 0007560                          
01-11-06 21:52 johnrigg       Note Added: 0007569                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
