From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000963]: Sounc card is mute
Date: Thu, 17 Mar 2005 10:11:37 +0100
Message-ID: <3d46ee2b7056b92845c75abc7da14118@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A64CA22D
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2005 10:11:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=963> 
======================================================================
Reported By:                jnilles
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   963
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE
Kernel Version:             
======================================================================
Date Submitted:             03-04-2005 19:07 CET
Last Modified:              03-17-2005 10:11 CET
======================================================================
Summary:                    Sounc card is mute
Description: 
I have a Turtle Beach Santa Cruz. It worked perfectly with SuSE Linux 9.0
and still works perfectly under Windows XP. I "upgraded" to SuSE 9.2 and
the sound card is inoperative, mute, lifeless, sound-free. The only advice
I got from SuSE support was that I shouldn't have skipped from 9.0 to 9.2
without going thgrough 9.1 on the way. That sounds like pretty stupid
advice.
I have spent weeks twiddling with settings  recommended by member sof the
alsa users group, to no avail.
======================================================================

----------------------------------------------------------------------
 jnilles - 03-16-05 22:52 
----------------------------------------------------------------------
I have to assume that the cable is OK since the sound card was working
perfectly under Win XP a few minutes ago as it did before under SuSE 9.0.
No connections or settings have been changed.

I note that SuSE 9.2 has a plethora of mixers: KAMix, KMix, QAMix, gamix
and whatever YaST uses. No two of these seem to yhave the same assortment
of controls. Are their settings interconnected and/or do they all control
the same ALSA file?

Here's the output from /etc/asound.state:

state.CS46xx {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		value.0 62
		value.1 62
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Headphone Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 23
		value.1 23
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 23
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 15
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 31
		value.1 31
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 28
		value.1 28
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 31
		value.1 31
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 30
		value.1 30
	}
	control.24 {
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
		value.0 Mic
		value.1 Mic
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
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
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 6
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.32 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.34 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier'
		value false
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		index 1
		value false
	}
	control.38 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		index 1
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Center Playback Volume'
		index 1
		value 63
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'LFE Playback Switch'
		index 1
		value true
	}
	control.42 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'LFE Playback Volume'
		index 1
		value 0
	}
	control.43 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Playback Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.44 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Surround Playback Volume'
		index 1
		value.0 22
		value.1 22
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		index 1
		value false
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		index 1
		value 0
	}
	control.47 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		index 1
		value false
	}
	control.48 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		index 1
		value false
	}
	control.49 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		index 1
		value false
	}
	control.51 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.52 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		index 1
		value false
	}
	control.53 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.54 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		index 1
		value true
	}
	control.55 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		index 1
		value.0 28
		value.1 28
	}
	control.56 {
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
		index 1
		value.0 Mic
		value.1 Mic
	}
	control.57 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		index 1
		value true
	}
	control.58 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.59 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		index 1
		value 'pre 3D'
	}
	control.60 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		index 1
		value false
	}
	control.61 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		index 1
		value 0
	}
	control.62 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		index 1
		value 0
	}
	control.63 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'DAC Volume'
		value.0 32439
		value.1 32439
	}
	control.64 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'ADC Volume'
		value.0 32767
		value.1 32767
	}
	control.65 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'ADC Capture Switch'
		value false
	}
	control.66 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'DAC Capture Switch'
		value false
	}
	control.67 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.68 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Switch'
		value false
	}
	control.69 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Default'
		value
'0000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.70 {
		comment.access read
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Mask'
		value
ffff00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.71 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback PCM Stream'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
}

----------------------------------------------------------------------
 jdthood - 03-17-05 10:11 
----------------------------------------------------------------------
This doesn't look good:

    control.37 {
        comment.access 'read write'
        comment.type BOOLEAN
        iface MIXER
        name 'Master Playback Switch'
        index 1
        value false
    }
    control.38 {
        comment.access 'read write'
        comment.type INTEGER
        comment.range '0 - 63'
        iface MIXER
        name 'Master Playback Volume'
        index 1
        value.0 0
        value.1 0
    }


As an experiment you can edit asound.state and run 'alsactl restore'
to load the values into the hardware.  If you don't want to do that
then I suggest you kill all mixer applications (except gamix) and
try to raise the Master Playback levels using gamix.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 19:07 jnilles        New Issue                                    
03-04-05 19:07 jnilles        Distribution              => SuSE            
03-09-05 18:53 tiwai          Note Added: 0003840                          
03-10-05 00:21 jnilles        Note Added: 0003846                          
03-10-05 15:01 jdthood        Note Added: 0003856                          
03-10-05 20:29 jnilles        Note Added: 0003872                          
03-10-05 22:04 jdthood        Note Added: 0003874                          
03-16-05 01:33 jnilles        Note Added: 0003926                          
03-16-05 12:31 tiwai          Note Added: 0003941                          
03-16-05 22:52 jnilles        Note Added: 0003972                          
03-17-05 10:11 jdthood        Note Added: 0003980                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
