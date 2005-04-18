From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000772]: Analog/Digital output not working.
Date: Mon, 18 Apr 2005 23:16:44 +0200
Message-ID: <761be2ac49ffac886f79c76b4fe120ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9C91E25A
	for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2005 23:16:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=772> 
======================================================================
Reported By:                ianw1234
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   772
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.9-1.681_FC3
======================================================================
Date Submitted:             12-31-2004 23:02 CET
Last Modified:              04-18-2005 23:16 CEST
======================================================================
Summary:                    Analog/Digital output not working.
Description: 
I've been unable to get my SB Live! to send analog pcm out through the
Analog/Digital port. It's connected through this port to my receiver, and
while AC3 over the digital port works fine, I can't get anything else to
go over the line. I have a 48kHz wave file I've been testing, and I've
tried playing it with aplay over hw0,0 (no good), hw0,1 (doesn't exist),
and hw0,2 (no effect). 

I have the master, IEC Coaxial, AC97, External amplifier, and SB Live
Analog/Digital Output Jack all either unmuted or set to max volume. I've
tried loading the snd_pcm_oss module with various snd_dsp_map settings
without success.

I've tried this on 1.0.7 and 1.0.8rc1. I dimly remember this working in
the past, so I don't know if this was broken in the upgrade to 1.0.7
(which I had to do because AC3 passthrough didn't work in the version that
came with the 2.6.9 kernel) or whether I have some strange
misconfiguration. Help is appreciated! Thanks!
======================================================================

----------------------------------------------------------------------
 jukkat - 01-02-05 19:20 
----------------------------------------------------------------------
Im running Gentoo with 2.6.9-gentoo-r9 and alsa 1.0.8rc1 (driver, tools,
lib, utils). Have also tried 1.0.7, 1.0.6a and 1.0.5a. 

I have the /etc/asound.conf copied from
/usr/share/alsa/cards/EMU10K1.conf, don't know, if I should use another
asound.conf.

The hardware is an Athlon 2600+ with Asus A7N8X-E Deluxe mb and SB Live
5.1 player sound card.

ac3 does not work. mplayer -ao alsa works fine, if i add -ac hwac3, to the
command line, the IEC958 Optical Raw gets enabled automatically, but no
audio whatsoever.   Also my amp won't show "Dolby Digital" on the display.
Same problem with xine, if I set speakers to Pass Through, Optical Raw
gets enabled, but no audio. This can be a problem with Yamaha amplifiers
being very picky on the correctness of the ac3-stream. I have also an
Nforce2 onboard audio on my computer, the symptoms are the same.
Everything else works (even DTS), no ac3 audio.



----------------------------------------------------------------------
 jdthood - 04-18-05 23:16 
----------------------------------------------------------------------
Submitter: Any improvement in more recent ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 23:02 ianw1234       New Issue                                    
12-31-04 23:02 ianw1234       Kernel Version            => 2.6.9-1.681_FC3 
01-01-05 00:33 ianw1234       Note Added: 0003028                          
01-01-05 02:28 rlrevell       Note Added: 0003030                          
01-01-05 10:01 pzad           Note Added: 0003031                          
01-01-05 22:48 ianw1234       Note Added: 0003039                          
01-01-05 23:03 pzad           Note Added: 0003041                          
01-02-05 19:15 jukkat         Note Added: 0003046                          
01-02-05 19:20 jukkat         Note Edited: 0003046                         
01-04-05 21:57 visit0r        Issue Monitored: visit0r                     
04-18-05 23:16 jdthood        Note Added: 0004516                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
