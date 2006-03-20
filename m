From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001930]: Can`t get timidity woking in soft synth mode
Date: Mon, 20 Mar 2006 03:24:35 +0100
Message-ID: <6e2e38b0e293cdb6140ef36b4459fdf0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 847251E7
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 03:24:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1930> 
======================================================================
Reported By:                drolyk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1930
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-15-2006 23:41 CET
Last Modified:              03-20-2006 03:24 CET
======================================================================
Summary:                    Can`t get timidity woking in soft synth mode
Description: 
Can`t get timidity woking in "soft synth mode".
======================================================================

----------------------------------------------------------------------
 fdoffizi01 - 03-20-06 01:42 
----------------------------------------------------------------------
Even using timidity:
timidity -iA -B2,8 -Os1l -s 44100
Requested buffer size 2048, fragment size 1024
ALSA pcm 'default' set buffer size 60208, period size 3760 bytes
TiMidity starting in ALSA server mode
Opening sequencer port: 128:0 128:1 128:2 128:3

that creates:

 Port    Client name                      Port name
128:0    TiMidity                         TiMidity port 0
128:1    TiMidity                         TiMidity port 1
128:2    TiMidity                         TiMidity port 2
128:3    TiMidity                         TiMidity port 3

Then when I use aplaymidi, pmidi, kmid to play on one of these 4 ports I
only get this output in timidity:

Requested buffer size 2048, fragment size 1024
ALSA pcm 'default' set buffer size 60208, period size 3760 bytes


top tells me timidity seems working but I can't see nothing nor hear
nothing.

playing timidity namefile.mid works:

timidity AHardDaysNight.mid
Requested buffer size 32768, fragment size 8192
ALSA pcm 'default' set buffer size 60208, period size 3760 bytes
Playing AHardDaysNight.mid
MIDI file: AHardDaysNight.mid
Format: 1  Tracks: 11  Divisions: 384.

Same with fluidsynt and qsynth, I see just a "flash" in qsynth control
panel (when instruments are set up) and then nothing.

Kernel is 2.6.15, alsa drivers are cvs for hda-intel Vaio FE11M support
(but I told I had same problem with intel8x0 on my old notebook with
2.6.15 stable driver&kernel).

----------------------------------------------------------------------
 rlrevell - 03-20-06 03:24 
----------------------------------------------------------------------
Does this work:

fluidsynth -m alsa_seq -a alsa your_soundfont.sf2 foo.mid

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 23:41 drolyk         New Issue                                    
03-15-06 23:41 drolyk         Distribution              => Debian          
03-15-06 23:41 drolyk         Kernel Version            => 2.6.15.6        
03-19-06 23:55 fdoffizi01     Note Added: 0008700                          
03-20-06 01:28 rlrevell       Note Added: 0008702                          
03-20-06 01:42 fdoffizi01     Note Added: 0008703                          
03-20-06 03:24 rlrevell       Note Added: 0008706                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
