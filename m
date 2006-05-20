From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0002136]: ice1724gt support for Envy24Control
Date: Sat, 20 May 2006 18:55:48 +0200
Message-ID: <e0414cd2ff4f5d0476f2614ec1e8f1f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 526F21A2
	for <alsa-devel@alsa-project.org>; Sat, 20 May 2006 18:55:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2136> 
======================================================================
Reported By:                hlabs
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   2136
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-19-2006 21:21 CEST
Last Modified:              05-20-2006 18:55 CEST
======================================================================
Summary:                    ice1724gt support for Envy24Control
Description: 
What about ice1724gt support for Envy24Control util ?
My card is M-Audio Revolution 5.1
Envy24Control says : no Ice1712 found.

All modules loads fine but no sound at all :(
Vanilla kernel 2.6.16 with ALSA 1.0.11 .
Trial OSS works fine .

======================================================================

----------------------------------------------------------------------
 rlrevell - 05-20-06 00:00 
----------------------------------------------------------------------
Yes, it's a known issue that envy24 control does not support ICE1724. 
However this is interesting, it sounds like it could be trivial to fix.

----------------------------------------------------------------------
 hlabs - 05-20-06 18:55 
----------------------------------------------------------------------
It doesn't work using alsamixer.
All controls unmuted and routed to PCM out.
Still no sound :( Even via oss emulation.

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Revolution51 [M Audio Revolution-5.1], device 0: ICE1724
[ICE1724]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Revolution51 [M Audio Revolution-5.1], device 1: IEC1724 IEC958
[IEC1724 IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Revolution51 [M Audio Revolution-5.1], device 2: ICE1724 Surrounds
[ICE1724 Surround PCM]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-06 21:21 hlabs          New Issue                                    
05-19-06 21:22 hlabs          Issue Monitored: hlabs                       
05-19-06 23:55 gineera        Note Added: 0009880                          
05-19-06 23:56 gineera        Note Edited: 0009880                         
05-20-06 00:00 rlrevell       Note Added: 0009881                          
05-20-06 18:55 hlabs          Note Added: 0009890                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
