From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002229]: No stereo: sright channel is
	dead
Date: Tue, 27 Jun 2006 16:41:26 +0200
Message-ID: <d5eb95df0f2a543049a3c87e1fdc8241@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3413622E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 16:41:27 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2229> 
======================================================================
Reported By:                rshura
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2229
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.16 from Debian unstable
======================================================================
Date Submitted:             06-25-2006 03:55 CEST
Last Modified:              06-27-2006 16:41 CEST
======================================================================
Summary:                    No stereo: sright channel is dead
Description: 
Everything seems to work perfectly, except the right channel is dead. I
checked speakers on another machine and everything is fine. This is the
integrated sound on a new mobo and it's unlikely (although not impossible)
that the right channel is physically broken.

Is there any way to tell whether it is a driver problem or a broken mobo?
It is on warranty, so I could exchange it if that's the case.

I am not a kernel hacker, but I would be glad to provide more info, just
tell me what to do. Thanks!
======================================================================

----------------------------------------------------------------------
 tiwai - 06-27-06 12:15 
----------------------------------------------------------------------
It means that the stereo signals reach correctly at least to AC97 codec
chip.
Since the mixer setting looks OK, the problematic part is between the
codec chip and the actual I/O jack.  Hence a hardware problem is highly
suspected.
(But better to check the cable and the jack before returning your
machine...)

----------------------------------------------------------------------
 rshura - 06-27-06 16:41 
----------------------------------------------------------------------
Cable and jack are working fine with another computer. Since the right
channel fails at both regular and front panel connectors, I don't think it
is the actual I/O jack that is responsible. Because the front panel jack
is connected to the mobo through a completely different cable, yet shows
the same problem.

I'll try exchanging the mobo and see whether that helps. Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-25-06 03:55 rshura         New Issue                                    
06-25-06 03:55 rshura         Distribution              => Debian unstable 
06-25-06 03:55 rshura         Kernel Version            => 2.6.16 from Debian
unstable
06-25-06 05:26 rshura         Note Added: 0010499                          
06-25-06 05:43 Raymond        Note Added: 0010500                          
06-25-06 05:49 rshura         File Added: asound.cards                     
06-25-06 05:50 rshura         File Added: ac97#0-0                         
06-25-06 05:50 rshura         File Added: ac97#0-0+regs                    
06-25-06 05:50 rshura         File Added: amixer                           
06-25-06 05:51 rshura         Note Added: 0010501                          
06-26-06 07:15 rshura         Note Added: 0010525                          
06-26-06 16:07 tiwai          Note Added: 0010540                          
06-27-06 05:51 rshura         Note Added: 0010565                          
06-27-06 12:15 tiwai          Note Added: 0010582                          
06-27-06 16:41 rshura         Note Added: 0010596                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
