From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001754]: M-Audio Revolution 5.1: Headphone jack gets no signal
Date: Fri, 20 Jan 2006 21:04:58 +0100
Message-ID: <0340152d24fe5a8e369b39d39ba11116@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2691317B
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 21:04:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1754> 
======================================================================
Reported By:                wollschaf
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1754
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-15-2006 16:02 CET
Last Modified:              01-20-2006 21:04 CET
======================================================================
Summary:                    M-Audio Revolution 5.1: Headphone jack gets no
signal
Description: 
Whatever I tried with alsamixer, I could not get the headphone jack to
output any kind of signal.

In my understanding, it should output the line signal, but amplificated.

As it does not even output the white noise of the inputs (see Issue
0001753), I assume the headphone output is completely disabled.

If photos of the card are needed to find out how it is connected, I will
upload them...

======================================================================

----------------------------------------------------------------------
 cyan - 01-16-06 15:47 
----------------------------------------------------------------------
Same problem here. Now I use preamlifier for my headphones, but it would be
better to use directly buffered output on the card.

----------------------------------------------------------------------
 wollschaf - 01-20-06 21:04 
----------------------------------------------------------------------
Looking at the AK4358 datasheet, this chip has 8 DACs - I assume the
headphones are connected using the two unused channels (driver has 6 DACs
defined).

Maybe a photo of the card helps figuring out how to enable them:
http://www.flickr.com/photos/88892686@N00/89003057/

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 16:02 wollschaf      New Issue                                    
01-15-06 16:02 wollschaf      Kernel Version            => 2.6.15          
01-15-06 16:02 wollschaf      Issue Monitored: wollschaf                    
01-16-06 15:47 cyan           Note Added: 0007686                          
01-16-06 15:47 cyan           Issue Monitored: cyan                        
01-20-06 21:04 wollschaf      Note Added: 0007727                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
