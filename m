From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002121]: No Sound, No error message,
Date: Sat, 15 Jul 2006 02:02:35 +0200
Message-ID: <ebd9c13056f0883522a358501da8151a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E692321E
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 02:02:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2121> 
======================================================================
Reported By:                bringha
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2121
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Suse 9.1. (modified)
Kernel Version:             2.6.16.9
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-13-2006 16:11 CEST
Last Modified:              07-15-2006 02:02 CEST
======================================================================
Summary:                    No Sound, No error message,
Description: 
Installed new Kernel 2.6.16.9 and put ALSA 1.0.11 (compiled from source) on
it. Made alsalib and alsautils to the same version 1.0.11. No error
messages, no error in alsaconf, all rulers in alsamixer on full, but no
sound. Even cat <something> > /dev/sound/pcm... causes no noise (otherwise
I would assume that something is wrong with my KDE artsd). Sound HW OK
because it is perfectly running under Windows and Solaris on the same
machine. See attached aadebug output.

Question: How to analyse further

Thanks for ur support 
======================================================================

----------------------------------------------------------------------
 thubble - 05-14-06 06:57 
----------------------------------------------------------------------
I have the exact same problem. Occurs on 2.6.17-rc3 with -mm1 patch, but
not with 2.6.16. aadebug output attached with name "aadebug-output"

----------------------------------------------------------------------
 thubble - 05-14-06 19:56 
----------------------------------------------------------------------
Actually, on further investigation, it turns out I was forgetting to unmute
the PCM. I was just turning the volume up to 100, and didn't realize that
it was still muted. I unmuted the PCM and it works fine now.

To the original reporter, try this:
# amixer set PCM 100 unmute

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 16:11 bringha        New Issue                                    
05-13-06 16:11 bringha        File Added: xxx                              
05-13-06 16:11 bringha        Distribution              => Suse 9.1. (modified)
05-13-06 16:11 bringha        Kernel Version            => 2.6.16.9        
05-14-06 06:56 thubble        File Added: aadebug-output                    
05-14-06 06:57 thubble        Note Added: 0009807                          
05-14-06 19:56 thubble        Note Added: 0009810                          
05-24-06 14:01 fuman          Issue Monitored: fuman                       
07-15-06 02:02 Adrian Bunk    Status                   new => closed       
07-15-06 02:02 Adrian Bunk    Resolution               open => not an issue
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
