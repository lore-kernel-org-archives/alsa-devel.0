From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002227]: Creative Audigy Platinum
	mixer problems
Date: Fri, 23 Jun 2006 18:33:53 +0200
Message-ID: <652725181bb3434baaa2fbcdbfb889e5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB99D15D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 18:33:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2227> 
======================================================================
Reported By:                lzap
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2227
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             Linux teevee 2.6.15-25-k7 #1 SMP PREEMPT Wed Jun 14
11:43:20 UTC 2006 i686 GNU/Linux
======================================================================
Date Submitted:             06-23-2006 15:39 CEST
Last Modified:              06-23-2006 18:33 CEST
======================================================================
Summary:                    Creative Audigy Platinum mixer problems
Description: 
I do not see any capture channels on my Audigy (1) Platinum. This card has
dozen of inputs, e.g. Aux 2, LineIn 2, SPIDF OUT and IN either on the card
itself or on the front panel.

Second problem is with mixer too - I can see just few playback mixer
channels.

See additional information for complete outputs.

Card works well in Windows in this computer, the playback also works for
me, the problem is just the mixer.
======================================================================

----------------------------------------------------------------------
 lzap - 06-23-06 18:31 
----------------------------------------------------------------------
I have run init_audigy and it fixes the problem, please close the
bugreport.

Should I use the ld01k1? Do I need it for normal use?

----------------------------------------------------------------------
 lzap - 06-23-06 18:33 
----------------------------------------------------------------------
I mean - when I uninstall it, will the mixer be ok? I do not need the DSP
effects...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-06 15:39 lzap           New Issue                                    
06-23-06 15:39 lzap           Distribution              => Ubuntu          
06-23-06 15:39 lzap           Kernel Version            => Linux teevee
2.6.15-25-k7 #1 SMP PREEMPT Wed Jun 14 11:43:20 UTC 2006 i686 GNU/Linux
06-23-06 18:17 pzad           Note Added: 0010457                          
06-23-06 18:22 lzap           Note Added: 0010458                          
06-23-06 18:29 pzad           Note Added: 0010460                          
06-23-06 18:31 lzap           Note Added: 0010461                          
06-23-06 18:33 lzap           Note Added: 0010462                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
