From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000497]: cdplayer and midi does'n work
Date: Wed, 13 Oct 2004 18:23:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013162348.AF00B1B006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0EE282F1
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2004 18:23:48 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000497
======================================================================
Reported By:                maciekb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     497
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             09-11-2004 16:46 CEST
Last Modified:              10-13-2004 18:23 CEST
======================================================================
Summary:                    cdplayer and midi does'n work
Description: 
I have A7V600-X motherboard with via8237 chipset
My cdplayer does'n play and i do not have midi. 
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:32 CEST 
----------------------------------------------------------------------
Make sure that you unmuted and raised the volume of CD mixer control.
Please attach /etc/asound.state.

The hardware doesn't support MIDI (playback).
Possibly, the external MIDI UART is supported by snd-mpu401.
If you want a soft MIDI synth, try the softsynth program like TiMidity.

----------------------------------------------------------------------
 maciekb - 09-15-2004 22:17 CEST 
----------------------------------------------------------------------
CD mixer control is unmuted, i also tried switch every control I have
found.
Here is asound.state:

cat /var/lib/alsa/asound.state
state.rev60 {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Master Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Master Surround Playback Volume'
                value.0 16
                value.1 16
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Center Playback Switch'
                value false
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 0
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'LFE Playback Switch'
                value false
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 0
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Surround Playback Switch'
                value.0 true
                value.1 true
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Surround Playback Volume'
                value.0 0
                value.1 0
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Master Playback Switch'
                value.0 true
                value.1 true
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 19
                value.1 19
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Master Mono Playback Switch'
                value true
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 20
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Phone Playback Switch'
                value false
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Phone Playback Volume'
                value 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Mic Playback Switch'
                value false
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 0
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Line Playback Switch'
                value.0 true
                value.1 true
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 23
                value.1 23
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'CD Playback Switch'
                value.0 true
                value.1 true
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 24
                value.1 24
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Aux Playback Switch'
                value.0 true
                value.1 true
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 27
                value.1 27
        }
        control.24 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'PCM Playback Switch'
                value.0 true
                value.1 true
        }
        control.25 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 31
                value.1 31
        }
        control.26 {
                comment.access 'read write'
                comment.type ENUMERATED
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
                value.0 CD
                value.1 CD
        }
        control.27 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Capture Switch'
                value.0 false
                value.1 false
        }
        control.28 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.29 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic1
        }
        control.30 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.31 {
                comment.access read
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
        }
        control.32 {
                comment.access 'read write'
                comment.type IEC958
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.33 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'IEC958 Playback Switch'
                value true
        }
        control.34 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 3'
                iface MIXER
                name 'IEC958 Playback AC97-SPSA'
                value 3
        }
        control.35 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 AC-Link
                comment.item.1 'A/D Converter'
                iface MIXER
                name 'IEC958 Playback Source'
                value AC-Link
        }
        control.36 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Exchange Front/Surround'
                value false
        }
        control.37 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Spread Front to Surround and Center/LFE'
                value false
        }
        control.38 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Off
                comment.item.1 '6 -> 4'
                comment.item.2 '6 -> 2'
                iface MIXER
                name Downmix
                value Off
        }
        control.39 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Surround Jack as Input'
                value false
        }
        control.40 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Center/LFE Jack as Input'
                value false
        }
        control.41 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'Stereo Mic'
                value false
        }
        control.42 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'External Amplifier'
                value true
        }
        control.43 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Input1
                comment.item.1 Input2
                iface MIXER
                name 'Input Source Select'
                value Input1
        }
        control.44 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 Input1
                comment.item.1 Input2
                iface MIXER
                name 'Input Source Select'
                index 1
                value Input1
        }
        control.45 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface MIXER
                name 'IEC958 Output Switch'
                value false
        }
        control.46 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'VIA DXS Playback Volume'
                value.0 31
                value.1 31
        }
        control.47 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'VIA DXS Playback Volume'
                index 1
                value.0 31
                value.1 31
        }
        control.48 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'VIA DXS Playback Volume'
                index 2
                value.0 31
                value.1 31
        }
        control.49 {
                comment.access 'read write'
                comment.type INTEGER
                comment.range '0 - 31'
                iface MIXER
                name 'VIA DXS Playback Volume'
                index 3
                value.0 31
                value.1 31
        }
}

----------------------------------------------------------------------
 tiwai - 09-20-2004 17:43 CEST 
----------------------------------------------------------------------
The mixer setting looks OK.  Are you sure that you connected the
"analog"-cable
from CD-ROM to your mobo?

----------------------------------------------------------------------
 maciekb - 10-13-2004 18:23 CEST 
----------------------------------------------------------------------
It was it, I bought new comp and didn't check (think) that cable is
connected.
Sorry for disturbing.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-11-04 16:46 maciekb        New Bug                                      
09-11-04 16:46 maciekb        Distribution              => Debian unstable 
09-11-04 16:46 maciekb        Kernel Version            => 2.6.7           
09-13-04 15:32 tiwai          Bugnote Added: 0001745                       
09-15-04 22:17 maciekb        Bugnote Added: 0001765                       
09-20-04 17:43 tiwai          Bugnote Added: 0001790                       
10-13-04 18:23 maciekb        Bugnote Added: 0002130                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
