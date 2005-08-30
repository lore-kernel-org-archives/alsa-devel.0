From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000168]: Two sound blaster mp3+ USB sound cards cause applications and OS to start core dumping (crash).
Date: Tue, 30 Aug 2005 18:12:31 +0200
Message-ID: <411de78fdbe2e02787b378b7617c1d82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7CC5203
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 18:12:31 +0200 (MEST)
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
Last Modified:              08-30-2005 18:12 CEST
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
 jdthood - 08-30-05 12:16 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

----------------------------------------------------------------------
 paperclip - 08-30-05 18:12 
----------------------------------------------------------------------
I have not tried it in a while but it did not work with all the way up to
2.6.10 -- I need to reinstall linux (been using windows 2k lately for
doing sound processing). I will give it a look when I get a chance. 

-R

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
