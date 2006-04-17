From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001783]: My DYI BurrBrown pcm2702 usb soundcard is making a lot of noise, crackling or only noise when playing music
Date: Mon, 17 Apr 2006 17:57:29 +0200
Message-ID: <c124442f606da92efed6cbea472859ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 79016185
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 17:57:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1783> 
======================================================================
Reported By:                boniek
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1783
Category:                   USB - usb-audio
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo GNU/Linux
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-25-2006 11:51 CET
Last Modified:              04-17-2006 17:57 CEST
======================================================================
Summary:                    My DYI BurrBrown pcm2702 usb soundcard is making a
lot of noise, crackling or only noise when playing music
Description: 
Sound Card: PCM2702 BurrBrown DYI card (works perfectly in windows)
Music Player: Does not matter. It is always the same. Using alsa plugin (
I don't have oss emulation).
 Upon starting playing you will hear either ok sound, sound with a lot
background noise, or static only (like cat /dev/urandom > /dev/dsp in
oss). On start of playing music (either on beggining or after
unpause/unstop) there can be heard (almost always) a very loud crack.
Music can degradate itself to noise only too. Whole thing occurs very
often, but randomly (well I think things tend to get broken/repaired upon
restarting music stream - stop/pause and play).
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-17-06 13:45 
----------------------------------------------------------------------
Does it work with kernel 2.6.16, and/or a recent ALSA (1.0.11rc5)?

----------------------------------------------------------------------
 boniek - 04-17-06 17:57 
----------------------------------------------------------------------
Just recompiled kernel with alsa support and after some testing it seems to
work well. Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-25-06 11:51 boniek         New Issue                                    
01-25-06 11:51 boniek         Distribution              => Gentoo GNU/Linux
01-25-06 11:51 boniek         Kernel Version            => 2.6.15          
01-25-06 12:04 boniek         Note Added: 0007779                          
01-25-06 12:27 boniek         Note Added: 0007781                          
01-25-06 12:27 boniek         Note Deleted: 0007781                        
01-25-06 12:28 boniek         Note Edited: 0007779                         
04-17-06 13:45 Clemens LadischNote Added: 0009308                          
04-17-06 17:57 boniek         Note Added: 0009316                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
