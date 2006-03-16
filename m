From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000168]: Two sound blaster mp3+ USB sound cards cause applications and OS to start core dumping (crash).
Date: Thu, 16 Mar 2006 08:41:57 +0100
Message-ID: <e6ec32145758d8634f7b9531357aba0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 689DB1FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:41:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=168> 
======================================================================
Reported By:                paperclip
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   168
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.0
Kernel Version:             2.6.5 rc2 mm5 (and 2.6 kernel version)
======================================================================
Date Submitted:             03-30-2004 07:17 CEST
Last Modified:              03-16-2006 08:41 CET
======================================================================
Summary:                    Two sound blaster mp3+ USB sound cards cause
applications and OS to start core dumping (crash).
Description: 
USB sound works great in ALSA except when I try to run two USB sound cards.
I use it for portable sound recording for guitar fx processing. Any
application using two different DSPs will start causing applications to
crash, until the entire system is unusable. Tried different kernel
versions and alsa versions. regular OSS sound driver does not seem to work
with mp3+ so I can't even verify if it is the kernel or alsa or both. I
have been able to use the built in sound card (VIA dsp) and one USB sound
card with no problems. so it has nothing to do with 2 sound cards. but if
I compile in with just the USB driver or USB driver and VIA driver and
plug in two sound cards the system crashes. 
======================================================================

----------------------------------------------------------------------
 paperclip - 08-30-05 18:12 
----------------------------------------------------------------------
I have not tried it in a while but it did not work with all the way up to
2.6.10 -- I need to reinstall linux (been using windows 2k lately for
doing sound processing). I will give it a look when I get a chance. 

-R

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:41 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-04 07:17 paperclip      New Issue                                    
03-30-04 07:17 paperclip      File Added: config.gz                        
03-30-04 07:17 paperclip      Distribution              => Mandrake 10.0   
03-30-04 07:17 paperclip      Kernel Version            => 2.6.5 rc2 mm5 (and
2.6 kernel version)
04-01-04 19:29 paperclip      Issue Monitored: paperclip                    
04-05-04 16:11 Clemens LadischNote Added: 0000752                          
04-08-04 22:24 paperclip      Note Added: 0000770                          
04-08-04 22:31 paperclip      Note Added: 0000771                          
04-20-04 00:15 paperclip      Note Added: 0000867                          
04-22-04 15:39 Clemens LadischNote Added: 0000894                          
04-22-04 22:06 paperclip      Note Added: 0000896                          
08-30-05 12:16 jdthood        Note Added: 0005967                          
08-30-05 18:12 paperclip      Note Added: 0005979                          
03-16-06 08:41 rlrevell       Note Added: 0008597                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
