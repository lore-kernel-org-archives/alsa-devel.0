From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001831]: envy24control does not work with Hercules Fortissimo IV
Date: Sat, 11 Feb 2006 13:17:33 +0100
Message-ID: <cc4de16e6fd74a5c86a5939181acc70e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D01221A1
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2006 13:17:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1831> 
======================================================================
Reported By:                liiwi
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1831
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-08-2006 20:03 CET
Last Modified:              02-11-2006 13:17 CET
======================================================================
Summary:                    envy24control does not work with Hercules Fortissimo
IV
Description: 
Previously I did not have any pressing need to try envy24control. However
recently
for some odd reason left channel got just about muted. So, I tried
envy24control:

>No ICE1712 cards found

So, now I'm without left channel.

>From dmesg:

ice1724: No matching model found for ID 0x81160100
ice1724: Invalid EEPROM version 1

Hrm, this might be an driver issue if envy24control asks from driver about
the card and it does not know what model... 

This happens with all the way to 1.0.11-rc3.

lspci says about the card:

>Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI >Multi-Channel Audio Controller (rev 01)


======================================================================

----------------------------------------------------------------------
 liiwi - 02-11-06 13:17 
----------------------------------------------------------------------
Hrm, after playing with envy24control sources, mainly replacing "ICE1712"
with "ICE1724", it looks like reading from card eeprom does not give
what's expected.
Just a guess, though. So, this might be driver issue.

As ICE1712 requirement is hardcoded into envy24control, are there any
plans to add  real ICE1724 support?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-06 20:03 liiwi          New Issue                                    
02-11-06 13:17 liiwi          Note Added: 0008015                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
