From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001822]: Can't record with Hercules Fortissimo II
Date: Sun, 5 Feb 2006 16:19:46 +0100
Message-ID: <56eea4c4a2863d6f19b8dacf5aef896d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C0AE1C1
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 16:19:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1822> 
======================================================================
Reported By:                atler
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1822
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               PLD
Kernel Version:             2.6.14.7
======================================================================
Date Submitted:             02-05-2006 16:16 CET
Last Modified:              02-05-2006 16:19 CET
======================================================================
Summary:                    Can't record with Hercules Fortissimo II
Description: 
I can hear my voice from speakers but "arecord -f cd -t wav out.wav" always
produces 19K-32K file with no sound. What is weird is that I can record
through alsa oss emulation in programs that use /dev/dsp.
Similar problems already appeard here, but none of the solutions worked
for me.
======================================================================

----------------------------------------------------------------------
 atler - 02-05-06 16:19 
----------------------------------------------------------------------
state.CS46xx {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Playback Switch'
                value true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 63'
                iface MIXER
                name 'Master Playback Volume'
                value.0 51
                value.1 51
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Headphone Playback Switch'
                value true
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 63'
                iface MIXER
                name 'Headphone Playback Volume'
                value.0 51
                value.1 51
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Playback Switch'
                value false
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 0
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value true
        }
        control.8 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Line Playback Switch'
                value false
        }
        control.9 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.10 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'CD Playback Switch'
                value false
        }
        control.11 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.12 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Aux Playback Switch'
                value true
        }
        control.13 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 26
                value.1 26
        }
        control.14 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PCM Playback Switch'
                value true
        }
        control.15 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 25
                value.1 25
        }
        control.16 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 Mic
                value.1 Mic
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Capture Switch'
                value true
        }
        control.18 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 13
                value.1 13
        }
        control.19 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 'pre 3D'
                comment.item.1 'post 3D'
                iface MIXER
                name 'PCM Out Path & Mute'
                value 'pre 3D'
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name '3D Control - Switch'
                value false
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Center'
                value 0
        }
        control.22 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Depth'
                value 0
        }
        control.23 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Off-hook Switch'
                value false
        }
        control.24 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Caller ID Switch'
                value false
        }
        control.25 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 32767'
                iface MIXER
                name 'DAC Volume'
                value.0 32768
                value.1 32768
        }
        control.26 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 32767'
                iface MIXER
                name 'ADC Volume'
                value.0 32767
                value.1 32767
        }
        control.27 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'ADC Capture Switch'
                value true
        }
        control.28 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'DAC Capture Switch'
                value false
        }
        control.29 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Output Switch'
                value false
        }
        control.30 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Input Switch'
                value false
        }
        control.31 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface PCM
                device 2
                name 'IEC958 Playback Default'
                value
'0000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.32 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface PCM
                device 2
                name 'IEC958 Playback Mask'
                value
ffff00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
        }
        control.33 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface PCM
                device 2
                name 'IEC958 Playback PCM Stream'
                value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.34 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Duplicate Front'
                value true
        }
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 16:16 atler          New Issue                                    
02-05-06 16:16 atler          File Added: asound.state                     
02-05-06 16:16 atler          Distribution              => PLD             
02-05-06 16:16 atler          Kernel Version            => 2.6.14.7        
02-05-06 16:19 atler          Note Added: 0007937                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
