From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000168]: Two sound blaster mp3+ USB
	sound cards cause applications and OS to start core dumping (crash).
Date: Tue, 1 Aug 2006 13:58:19 +0200
Message-ID: <eb7ebcb35bf5a83b55549a8606927022@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5389176
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 13:58:19 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Mandrake 10.0
Kernel Version:             2.6.5 rc2 mm5 (and 2.6 kernel version)
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-30-2004 07:17 CEST
Last Modified:              08-01-2006 13:58 CEST
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
08-01-06 13:58 Adrian Bunk    Status                   assigned => closed  
08-01-06 13:58 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
