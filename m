From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001231]: Sharing soundcard via dmix does
	not work when mixing 32bit and 64bit applications.
Date: Sun, 9 Jul 2006 13:44:17 +0200
Message-ID: <a8121cf7574c5297088ee6eee84c3046@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F1B6277
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 13:44:17 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1231> 
======================================================================
Reported By:                Tobias Diedrich
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1231
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-04-2005 16:30 CEST
Last Modified:              07-09-2006 13:44 CEST
======================================================================
Summary:                    Sharing soundcard via dmix does not work when mixing
32bit and 64bit applications.
Description: 
I have configured a friends AMD64-System to use dmix by default.
I also made the same configuration for the 32bit-chroot and made sure
that
/tmp is a bind-mount, so the dmix-Socket is shared between 32bit and 64bit
applications.
However while sharing between one type of applications (either all 32bit
or all 64bit) works fine, mixed sharing doesn't work.  A strace shows that
the socket is opened by apparently communication fails.
I suspect that the structures passed by dmix have problems with differntly
sized fields between 32bit and 64bit.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 12:00 
----------------------------------------------------------------------
Yes, it's incompatible between 32 and 64bits.  The struct shared in shmem
doesn't match.
snd_pcm_direct_share_t in pcm_direct.h defines the shared struct and the
size of snd_pcm_[su]frames_t is long, so it depends on architecture.
Also, we should be careful about alignment, too...

----------------------------------------------------------------------
 ikonst - 08-18-05 22:29 
----------------------------------------------------------------------
Same as bug 0001336 which I've filled and is indeed resolved in CVS (I've
just checked). Please mark as resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-05 16:30 Tobias DiedrichNew Issue                                    
07-08-05 12:00 tiwai          Note Added: 0005412                          
08-18-05 22:29 ikonst         Note Added: 0005858                          
11-18-05 03:54 mr511          Issue Monitored: mr511                       
11-18-05 03:55 mr511          Issue End Monitor: mr511                     
07-09-06 13:44 Adrian Bunk    Status                   new => resolved     
07-09-06 13:44 Adrian Bunk    Resolution               open => fixed       
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
