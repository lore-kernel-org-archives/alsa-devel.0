From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002258]: nForce4 + intel8x0 + Dolby
	Digital 5.1 + S/PDIF = crackle at start of playback
Date: Tue, 11 Jul 2006 18:34:16 +0200
Message-ID: <32d49b7938f922c6ed763c0ad9cefb64@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03A10253
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 18:34:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2258> 
======================================================================
Reported By:                Human
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2258
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               KnoppMyth
Kernel Version:             2.6.17-chw-2
======================================================================
Date Submitted:             07-05-2006 22:12 CEST
Last Modified:              07-11-2006 18:34 CEST
======================================================================
Summary:                    nForce4 + intel8x0 + Dolby Digital 5.1 + S/PDIF =
crackle at start of playback
Description: 
Playing stereo audio never causes a crackle.  However, playback of 5.1
Dobly Digital content (standalone audio or audio embedded in video) causes
a quick but very loud sub-second audio crackle before playback continues,
when the previous playback was _not_ also multi-channel content.  The
problem always happens when the card is being asked to _switch_ to
multichannel audio _from_ either stereo or a non-initialized state.  The
crackle happens on both coaxial and optical S/PDIF connections to the
nForce4 (CK804) onboard soundcard.

The same receiver has not had a problem with S/PDIF with a different card
(Chaintech AV-710 / ice1724).
======================================================================

----------------------------------------------------------------------
 Human - 07-11-06 18:34 
----------------------------------------------------------------------
I just wanted to add that while playing stereo content via the method
described above does not produce static, there is silence for the same
duration as the static when playing multichannel audio.  I only reported
this in case it helps narrow down the source of the problem - if there are
separate causes, I can submit a separate bug report.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-05-06 22:12 Human          New Issue                                    
07-05-06 22:12 Human          File Added: asound.conf                      
07-05-06 22:12 Human          Distribution              => KnoppMyth       
07-05-06 22:12 Human          Kernel Version            => 2.6.17-chw-2    
07-05-06 22:13 Human          Issue Monitored: Human                       
07-11-06 18:34 Human          Note Added: 0010977                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
