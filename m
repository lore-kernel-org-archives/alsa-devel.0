From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002229]: No stereo: sright channel is
	dead
Date: Mon, 26 Jun 2006 16:07:10 +0200
Message-ID: <d808bb8d16e7a12a142958766a7cdc1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E33551A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:07:10 +0200 (MEST)
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
Last Modified:              06-26-2006 16:07 CEST
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
 rshura - 06-26-06 07:15 
----------------------------------------------------------------------
I think I ruled out the broken connector on the mobo: I have a front sound
connectors on my case and the cable connecting it to the motherboard. With
using the case-based front connector, I also hear only the left channel;
the right one is completely dead.

So it must be either the driver problem, or the whole right channel
circuitry on the mobo is seriously fried. If there is a way for me to tell
which is the case, please let me know.

----------------------------------------------------------------------
 tiwai - 06-26-06 16:07 
----------------------------------------------------------------------
The status looks fine, so likely a hardware problem.
To be sure, choose "Mix" as the capture source, turn on "Capture Switch",
and raise "Capture Volume".  Then you can record the signal being played
back.

For example, run "arecord -fdat -vv foo.wav" while playing back a stereo
file.  Then open the recorded WAV file via an audio graphic editor to see
whether both stereo signals are recorded.

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
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
