From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001930]: Can`t get timidity woking in soft synth mode
Date: Mon, 20 Mar 2006 23:54:57 +0100
Message-ID: <2956b02901e2fd8c8eaae87903d09933@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1773D203
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 23:54:58 +0100 (MET)
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
Last Modified:              03-20-2006 23:54 CET
======================================================================
Summary:                    Can`t get timidity woking in soft synth mode
Description: 
Can`t get timidity woking in "soft synth mode".
======================================================================

----------------------------------------------------------------------
 fdoffizi01 - 03-20-06 23:40 
----------------------------------------------------------------------
So this is something magic?

ciccio@Vaiolo ~ $ aplaymidi -l
 Port    Client name                      Port name
128:0    FLUID Synth (5036)               Synth input port (5036:0)

Fluid synth HAS soft synth function and suffer the same exact problems as
timidity when used in this way: player plays but no sound comes out (and
only first few midi (instrument settings I think) commands are received as
I can see from fluidsynth message log).

That's why I think it's not a timidity issue. Is alsa who actually creates
port for these soft synths? May be the problem is there...

----------------------------------------------------------------------
 rlrevell - 03-20-06 23:54 
----------------------------------------------------------------------
Ah OK.  I was confused by your use of "soft synth mode", which I
interpreted to mean synthesis vs. just triggering samples, but you are
referring to the ability to receive MIDI input from a sequencer port vs. a
file.

What was the last kernel+ALSA version where this worked?

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
03-20-06 06:08 drolyk         Note Added: 0008709                          
03-20-06 06:22 rlrevell       Note Added: 0008710                          
03-20-06 07:19 Raymond        Note Added: 0008711                          
03-20-06 12:55 fdoffizi01     Note Added: 0008718                          
03-20-06 15:50 fdoffizi01     Issue Monitored: fdoffizi01                    
03-20-06 22:19 drolyk         Note Added: 0008726                          
03-20-06 22:21 drolyk         Note Edited: 0008726                         
03-20-06 22:36 fdoffizi01     Note Added: 0008727                          
03-20-06 23:29 rlrevell       Note Added: 0008729                          
03-20-06 23:40 fdoffizi01     Note Added: 0008730                          
03-20-06 23:54 rlrevell       Note Added: 0008731                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
