From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002288]: Wierd spikes (high frequency
	glitches) in alsa output from SI7012 (intel8x0)
Date: Mon, 17 Jul 2006 01:47:57 +0200
Message-ID: <e01bb5ffbe23ce68d927753e78c99c4f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 83711222
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 01:47:57 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2288> 
======================================================================
Reported By:                jaime
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2288
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slax
Kernel Version:             2.6.16
======================================================================
Date Submitted:             07-17-2006 01:47 CEST
Last Modified:              07-17-2006 01:47 CEST
======================================================================
Summary:                    Wierd spikes (high frequency glitches) in alsa
output from SI7012 (intel8x0)
Description: 
Hi,

This is kind of related to alsa bug report 2006
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2006).

I've created a low volume sine-wave file, and then recorded the output of
playing that wave file back through both Windows 2000 and Alsa 1.0.11
(from Slax Live). The waveform from Windows shows just low volume
interference, while the waveform from Alsa shows both the same low volume
interference AND repetetive spikes which occur at the same frequency as
the original sine-wave. I've put up the wave files and graphical
screen-shots of the wave files on the web so that you can easily see what
I'm talking about:

Original wave file:
http://www.carbon.eclipse.co.uk/orig2.wav
Screenshot of the waveform:
http://www.carbon.eclipse.co.uk/orig2.gif

Recording of succesful playback under win2k:
http://www.carbon.eclipse.co.uk/win2k2.wav
Screenshot of the waveform:
http://www.carbon.eclipse.co.uk/win2k2.gif

Recording of problematic playback under alsa:
http://www.carbon.eclipse.co.uk/alsa2.wav
Screenshot of the waveform:
http://www.carbon.eclipse.co.uk/alsa2.gif

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-17-06 01:47 jaime          New Issue                                    
07-17-06 01:47 jaime          Distribution              => Slax            
07-17-06 01:47 jaime          Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
