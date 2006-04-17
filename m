From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002006]: High frequency noise in output from SI7012 (intel8x0)
Date: Mon, 17 Apr 2006 20:18:39 +0200
Message-ID: <841ba8d19f15f00858f450f2d1c0556b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 079F91AC
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 20:18:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2006> 
======================================================================
Reported By:                jaime
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2006
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slax 5.1.0, Debian Etch, Ubuntu Dapper
Kernel Version:             2.6.16 / 2.6.15
======================================================================
Date Submitted:             04-06-2006 04:27 CEST
Last Modified:              04-17-2006 20:18 CEST
======================================================================
Summary:                    High frequency noise in output from SI7012
(intel8x0)
Description: 
Sound chip is SI7012 built into Asrock K7S8X. To demonstrate the noise,
I've played "orig.wav" throught the SI7012 and recorded the (analog)
output on
another computer. When I boot the PC into Windows 2000, the output is
clean: the recording is "win2k.wav". Then I reboot into Linux and use
"aplay -Dhw:0,0 orig.wav" and record the output again: the recording is
"alsa.wav". Ignoring the  clicks in the last half of "win2k.wav" (the
click are the hard-drive reads), I can hear a high frequency intermittent
"buzz" in the last half of "alsa.wav" that isn't present in "win2k.wav".
To hear this, I think you will need headphones, but the buzzing is
definitely there.

As the three wave files are too big to attach, I've put them on the web
here:
orig.wav:   http://www.carbon.eclipse.co.uk/orig.wav
win2k.wav:  http://www.carbon.eclipse.co.uk/win2k.wav
alsa.wav:   http://www.carbon.eclipse.co.uk/alsa.wav

The version used is 1.0.11rc2, but the same problem occurs in the older
1.0.10.

======================================================================

----------------------------------------------------------------------
 jaime - 04-17-06 20:18 
----------------------------------------------------------------------
FWIW, I've just tried the same thing on an up-to-date Gentoo ~x86
("testing" or "unstable") and the problem is still there. This is using
vanilla-sources 2.6.17-rc1 which contains alsa 1.0.11rc4 (Wed Mar 22
10:27:24 2006 UTC)

Hope this helps.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-06-06 04:27 jaime          New Issue                                    
04-06-06 04:27 jaime          Distribution              => Slax 5.1.0, Debian
Etch, Ubuntu Dapper
04-06-06 04:27 jaime          Kernel Version            => 2.6.16 / 2.6.15 
04-14-06 03:29 Ensnared       Issue Monitored: Ensnared                    
04-17-06 20:18 jaime          Note Added: 0009320                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
