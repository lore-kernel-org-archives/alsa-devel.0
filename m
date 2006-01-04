From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001681]: (MIXER,'Front Playback Volume',0,0,0) appears twice or more
Date: Wed, 4 Jan 2006 22:03:02 +0100
Message-ID: <f56113d90f6abba40f7b5e2caf37552e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0B0B8128
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 22:03:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1681> 
======================================================================
Reported By:                jcdutton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1681
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-26-2005 17:13 CET
Last Modified:              01-04-2006 22:03 CET
======================================================================
Summary:                    (MIXER,'Front Playback Volume',0,0,0) appears twice
or more
Description: 
Reported in "mashaun".

0 [Live           ]: EMU10K1 - SB Live [Unknown]
                     SB Live [Unknown] (rev.10, serial:0x80661102) at
0xc800, irq 5

the emu10k1 gives the following error when one tries to run alsamixer
ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Front Playback
Volume',0,0,0) appears twice or more

amixer controls                                       
numid=43,iface=MIXER,name='Master Playback Switch'
numid=44,iface=MIXER,name='Master Playback Volume'
numid=91,iface=MIXER,name='Headphone +3dB Boost'
numid=89,iface=MIXER,name='Headphone Amp'
numid=40,iface=MIXER,name='Headphone Center Playback Switch',index=1
numid=41,iface=MIXER,name='Headphone LFE Playback Switch',index=1
numid=39,iface=MIXER,name='Headphone Playback Volume',index=1
numid=35,iface=MIXER,name='Tone Control - Bass'
numid=37,iface=MIXER,name='Tone Control - Switch'
numid=36,iface=MIXER,name='Tone Control - Treble'
numid=76,iface=MIXER,name='3D Control - Switch'
numid=79,iface=MIXER,name='3D Control Sigmatel - Depth'
numid=70,iface=MIXER,name='PCM Playback Switch'
numid=71,iface=MIXER,name='PCM Playback Volume'
numid=66,iface=MIXER,name='Surround Mix Playback Switch'
numid=67,iface=MIXER,name='Surround Mix Playback Volume'
numid=10,iface=MIXER,name='Surround Playback Volume'
numid=12,iface=MIXER,name='Surround Capture Switch'
numid=11,iface=MIXER,name='Surround Capture Volume'
numid=86,iface=MIXER,name='Center/LFE Jack'
numid=13,iface=MIXER,name='Center Playback Volume'
numid=14,iface=MIXER,name='LFE Playback Volume'
numid=7,iface=MIXER,name='Synth Playback Volume'
numid=9,iface=MIXER,name='Synth Capture Switch'
numid=8,iface=MIXER,name='Synth Capture Volume'
numid=3,iface=MIXER,name='Wave Center Playback Volume'
numid=4,iface=MIXER,name='Wave LFE Playback Volume'
numid=2,iface=MIXER,name='Wave Surround Playback Volume'
numid=1,iface=MIXER,name='Wave Playback Volume'
numid=6,iface=MIXER,name='Wave Capture Switch'
numid=5,iface=MIXER,name='Wave Capture Volume'
numid=88,iface=MIXER,name='Line Input Source'
numid=28,iface=MIXER,name='Line LiveDrive Capture Switch'
numid=27,iface=MIXER,name='Line LiveDrive Capture Volume'
numid=26,iface=MIXER,name='Line LiveDrive Playback Volume'
numid=34,iface=MIXER,name='Line2 LiveDrive Capture Switch',index=1
numid=33,iface=MIXER,name='Line2 LiveDrive Capture Volume',index=1
numid=32,iface=MIXER,name='Line2 LiveDrive Playback Volume',index=1
numid=83,iface=MIXER,name='LineIn Jack'
numid=62,iface=MIXER,name='Line Playback Switch'
numid=63,iface=MIXER,name='Line Playback Volume'
numid=64,iface=MIXER,name='CD Playback Switch'
numid=65,iface=MIXER,name='CD Playback Volume'
numid=61,iface=MIXER,name='Mic Boost (+20dB)'
numid=87,iface=MIXER,name='Mic Input Source'
numid=78,iface=MIXER,name='Mic Select'
numid=82,iface=MIXER,name='Mic1 Jack'
numid=59,iface=MIXER,name='Mic Playback Switch'
numid=60,iface=MIXER,name='Mic Playback Volume'
numid=57,iface=MIXER,name='Phone Playback Switch'
numid=58,iface=MIXER,name='Phone Playback Volume'
numid=55,iface=MIXER,name='PC Speaker Playback Switch'
numid=56,iface=MIXER,name='PC Speaker Playback Volume'
numid=68,iface=MIXER,name='Aux Playback Switch'
numid=69,iface=MIXER,name='Aux Playback Volume'
numid=72,iface=MIXER,name='Capture Source'
numid=73,iface=MIXER,name='Capture Switch'
numid=74,iface=MIXER,name='Capture Volume'
numid=31,iface=MIXER,name='IEC958 Coaxial Capture Switch'
numid=30,iface=MIXER,name='IEC958 Coaxial Capture Volume'
numid=29,iface=MIXER,name='IEC958 Coaxial Playback Volume'
numid=25,iface=MIXER,name='IEC958 LiveDrive Capture Switch'
numid=24,iface=MIXER,name='IEC958 LiveDrive Capture Volume'
numid=23,iface=MIXER,name='IEC958 LiveDrive Playback Volume'
numid=38,iface=MIXER,name='IEC958 Optical Raw Playback Switch'
numid=22,iface=MIXER,name='IEC958 TTL Capture Switch'
numid=21,iface=MIXER,name='IEC958 TTL Capture Volume'
numid=20,iface=MIXER,name='IEC958 TTL Playback Volume'
numid=19,iface=MIXER,name='AC97 Capture Volume'
numid=18,iface=MIXER,name='AC97 Playback Volume'
numid=90,iface=MIXER,name='Exchange Center/LFE'
numid=92,iface=MIXER,name='External Amplifier'
numid=17,iface=MIXER,name='Front Capture Switch'
numid=16,iface=MIXER,name='Front Capture Volume'
numid=84,iface=MIXER,name='Front Jack'
numid=51,iface=MIXER,name='Front Playback Switch'
numid=15,iface=MIXER,name='Front Playback Volume'
numid=52,iface=MIXER,name='Front Playback Volume'
numid=85,iface=MIXER,name='Rear Jack'
numid=245,iface=MIXER,name='SB Live Analog/Digital Output Jack'
numid=80,iface=MIXER,name='Sigmatel 4-Speaker Stereo Playback Switch'
numid=81,iface=MIXER,name='Sigmatel Surround Phase Inversion Playback '
numid=42,iface=PCM,name='Captured FX8010 Outputs',device=2
numid=241,iface=PCM,name='IEC958 Playback Default',device=2
numid=242,iface=PCM,name='IEC958 Playback Default',index=1,device=2
numid=243,iface=PCM,name='IEC958 Playback Default',index=2,device=2
numid=244,iface=PCM,name='IEC958 Playback Default',index=3,device=2
numid=237,iface=PCM,name='IEC958 Playback Mask',device=2
numid=238,iface=PCM,name='IEC958 Playback Mask',index=1,device=2
numid=239,iface=PCM,name='IEC958 Playback Mask',index=2,device=2
numid=240,iface=PCM,name='IEC958 Playback Mask',index=3,device=2

======================================================================

----------------------------------------------------------------------
 alien999999999 - 01-04-06 22:03 
----------------------------------------------------------------------
also have this problem:

[alien@queen alien-libbt]$ alsamixer -c 1
ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Front Playback
Volume',0,0,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-05 17:13 jcdutton       New Issue                                    
01-04-06 22:03 alien999999999 Note Added: 0007454                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
