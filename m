From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000625]: ISA - 4232 has no CD sound
Date: Thu, 11 Nov 2004 13:47:11 +0100
Message-ID: <b665c0b7eade08574b96c6e2ffe15255@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 329D2261
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2004 13:47:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=625> 
======================================================================
Reported By:                hugovanwoerkom
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   625
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-03-2004 13:49 CET
Last Modified:              11-11-2004 13:47 CET
======================================================================
Summary:                    ISA - 4232 has no CD sound
Description: 
Switched from OSS to Alsa. Enabled sound, alsa, OSS emulation and cs4232
isa card in kernel. Tried with modules and without. Has sound but not from
the CD. System ran OSS module  with sound from the CD previous to kernel
compile, so everything that OSS needed is still there.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 18:49 
----------------------------------------------------------------------
Please attach /etc/asound.state for debugging.
I guess you didn't turn on "CD Playback Switch".

----------------------------------------------------------------------
 hugovanwoerkom - 11-11-04 13:47 
----------------------------------------------------------------------
On Debian systems:
/var/lib/alsa/asound.state
follows:

state.CS4236 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 52
		value.1 52
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 31
		value.1 31
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value.0 false
		value.1 false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 31
		value.1 31
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		index 1
		value.0 31
		value.1 31
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mono Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Mono Playback Volume'
		value 15
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mono Output Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mono Output Playback Bypass'
		value false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 11
		value.1 11
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Line
		comment.item.1 Aux
		comment.item.2 Mic
		comment.item.3 Mix
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost'
		value.0 false
		value.1 false
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Loopback Capture Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Loopback Capture Volume'
		value 63
	}
}

I would turn on CD Playback Switch if I knew how.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 13:49 hugovanwoerkom New Issue                                    
11-03-04 13:49 hugovanwoerkom Distribution              => Debian Sarge    
11-03-04 13:49 hugovanwoerkom Kernel Version            => 2.6.9           
11-09-04 18:49 tiwai          Note Added: 0002333                          
11-11-04 13:47 hugovanwoerkom Note Added: 0002384                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
