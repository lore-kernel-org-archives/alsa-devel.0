From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0002136]: ice1724gt support for Envy24Control
Date: Fri, 19 May 2006 23:55:09 +0200
Message-ID: <e5ac6478e4f1e960eaa59582f3c7e440@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19245191
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2006 23:55:09 +0200 (MEST)
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
Last Modified:              05-19-2006 23:55 CEST
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
 gineera - 05-19-06 23:55 
----------------------------------------------------------------------
Envy24control just provides a convenient way to access the Alsa controls. 
If sound is not working, use alsamixer (from a terminal window) and you
should have all the controls available.  Channels are usually muted and at
zero level by default.  If it doesn't work using alsamixer, the underlying
driver may be at fault (may then be worth trying alsa 1.0.11).

Envy24control does not add any more controls although it gives signal
meters and is easier to use, and is quite separate from the sound driver. 
It is quite possible that it doesn't support 1724 chips (yet?).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-06 21:21 hlabs          New Issue                                    
05-19-06 21:22 hlabs          Issue Monitored: hlabs                       
05-19-06 23:55 gineera        Note Added: 0009880                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
