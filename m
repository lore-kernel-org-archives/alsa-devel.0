From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001780]: alsamixer seg faults immediately after invocation
Date: Wed, 25 Jan 2006 05:10:54 +0100
Message-ID: <83fcfe2554e3013b7ec6980335d97883@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7EB6F16C
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 05:10:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1780> 
======================================================================
Reported By:                briand
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1780
Category:                   alsamixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-25-2006 05:10 CET
Last Modified:              01-25-2006 05:10 CET
======================================================================
Summary:                    alsamixer seg faults immediately after invocation
Description: 
FC3 2.6.9-1.667 (or 2.6.15.1) on Dell Inspiron 3200 D266XT.  Audio chip is
a CS4237B, driver is snd-cs4236.  See also:  0001748

----[ amixer contents
]-----------------------------------------------------
numid=2,iface=MIXER,name='Master Digital Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=1,iface=MIXER,name='Master Digital Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=3,iface=MIXER,name='Master Digital Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=71,step=0
  : values=31,31
numid=38,iface=MIXER,name='3D Control - Center'
  ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0
  : values=13
numid=40,iface=MIXER,name='3D Control - IEC958'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=39,iface=MIXER,name='3D Control - Mono'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=37,iface=MIXER,name='3D Control - Space'
  ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0
  : values=13
numid=36,iface=MIXER,name='3D Control - Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=5,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=6,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=63,step=0
  : values=57,39
numid=14,iface=MIXER,name='Synth Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=27,27
numid=13,iface=MIXER,name='Synth Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=15,iface=MIXER,name='Synth Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=16,iface=MIXER,name='Synth Capture Bypass'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=9,iface=MIXER,name='FM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=10,iface=MIXER,name='FM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=63,step=0
  : values=23,7
numid=11,iface=MIXER,name='Wavetable Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=12,iface=MIXER,name='Wavetable Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=63,step=0
  : values=51,35
numid=7,iface=MIXER,name='DSP Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=8,iface=MIXER,name='DSP Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=63,step=0
  : values=55,39
numid=22,iface=MIXER,name='Line Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=27,27
numid=21,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=23,iface=MIXER,name='Line Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=24,iface=MIXER,name='Line Capture Bypass'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=26,iface=MIXER,name='CD Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=28,28
numid=25,iface=MIXER,name='CD Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=27,iface=MIXER,name='CD Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=19,iface=MIXER,name='Mic Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=23,7
numid=20,iface=MIXER,name='Mic Playback Boost'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=17,iface=MIXER,name='Mic Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=18,iface=MIXER,name='Mic Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=28,iface=MIXER,name='Mono Output Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=29,iface=MIXER,name='Mono Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=30,iface=MIXER,name='Mono Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0
  : values=13
numid=31,iface=MIXER,name='Mono Playback Bypass'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=4,iface=MIXER,name='Capture Boost Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=3,step=0
  : values=1,1
numid=32,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=33,iface=MIXER,name='Analog Loopback Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
numid=34,iface=MIXER,name='Digital Loopback Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=35,iface=MIXER,name='Digital Loopback Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=63,step=0
  : values=27,23
numid=46,iface=MIXER,name='IEC958 Output Channel Status High'
  ; type=INTEGER,access=rw---,values=1,min=0,max=255,step=0
  : values=151
numid=45,iface=MIXER,name='IEC958 Output Channel Status Low'
  ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
  : values=121
numid=44,iface=MIXER,name='IEC958 Output CSBR'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=41,iface=MIXER,name='IEC958 Output Enable'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=43,iface=MIXER,name='IEC958 Output User'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=42,iface=MIXER,name='IEC958 Output Validity'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
----------------------------------------------------------------------------

----[ amixer scontents
]----------------------------------------------------
Simple mixer control 'Master Digital',0
  Capabilities: volume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 71
  Front Left: 31 [44%] Playback [off] Capture [off]
  Front Right: 31 [44%] Playback [off] Capture [off]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 13 [87%]
Simple mixer control '3D Control - IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control '3D Control - Mono',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control '3D Control - Space',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 13 [87%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Front Left: Playback 57 [90%] [on]
  Front Right: Playback 39 [62%] [on]
Simple mixer control 'Synth',0
  Capabilities: volume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 31
  Front Left: 27 [87%] Playback [on] Capture [off]
  Front Right: 27 [87%] Playback [on] Capture [off]
Simple mixer control 'Synth Capture Bypass',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'FM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Front Left: Playback 23 [37%] [on]
  Front Right: Playback 7 [11%] [on]
Simple mixer control 'Wavetable',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Front Left: Playback 51 [81%] [on]
  Front Right: Playback 35 [56%] [on]
Simple mixer control 'DSP',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Front Left: Playback 55 [87%] [off]
  Front Right: Playback 39 [62%] [off]
Simple mixer control 'Line',0
  Capabilities: volume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 31
  Front Left: 27 [87%] Playback [on] Capture [off]
  Front Right: 27 [87%] Playback [on] Capture [off]
Simple mixer control 'Line Capture Bypass',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'CD',0
  Capabilities: volume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 31
  Front Left: 28 [90%] Playback [on] Capture [off]
  Front Right: 28 [90%] Playback [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: volume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 31
  Front Left: 23 [74%] Playback [on] Capture [off]
  Front Right: 7 [23%] Playback [on] Capture [off]
Simple mixer control 'Mic Playback Boost',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'IEC958 Output CSBR',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Output Channel Status High',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 255
  Mono: 151 [59%]
Simple mixer control 'IEC958 Output Channel Status Low',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 121 [95%]
Simple mixer control 'IEC958 Output Enable',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Output User',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Output Validity',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 15
  Front Left: Playback 13 [87%] [on]
  Front Right: Playback 13 [87%] [on]
Simple mixer control 'Mono Output',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Mono Playback Bypass',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%]
  Front Right: Capture 0 [0%]
Simple mixer control 'Capture Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Limits: 0 - 3
  Mono: 1 [33%]
  Front Left:
  Front Right:
Simple mixer control 'Analog Loopback',0
  Capabilities: cswitch
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Digital Loopback',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 63
  Front Left: Playback 27 [43%] [off]
  Front Right: Playback 23 [37%] [off]
----------------------------------------------------------------------------

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-06 05:10 briand         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
