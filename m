From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001786]: Speaker produce sound even head phone is plugged in
Date: Thu, 2 Mar 2006 10:51:31 +0100
Message-ID: <3510a512102e74e85e1e2f8ef7a82784@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F5F71CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 10:51:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1786> 
======================================================================
Reported By:                siukamming
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1786
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debain unstable
Kernel Version:             2.6.14(Debain version) , 2.6.15(customized version)
======================================================================
Date Submitted:             01-27-2006 04:10 CET
Last Modified:              03-02-2006 10:51 CET
======================================================================
Summary:                    Speaker produce sound even head phone is plugged in
Description: 
On my notebook Dell 630M(915GM + sigmatel 9200), the speaker still produce
sound even headphone is plugged in. Now the speaker and headphone produce
sound simultaneously. Suppose the speaker stop to produce sound as
headphone is plugged in. 
I tested Windows. The speaker really stop produce sound as headphone is
plugged in. So it should be the driver problem. 
======================================================================

----------------------------------------------------------------------
 siukamming - 03-01-06 05:32 
----------------------------------------------------------------------


----------------------------------------------------------------------
 adoroar - 03-02-06 10:51 
----------------------------------------------------------------------
Got a url for that patch toshio for, whle we wait? :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-06 04:10 siukamming     New Issue                                    
01-27-06 04:10 siukamming     File Added: codec#0                          
01-27-06 04:10 siukamming     Distribution              => Debain unstable 
01-27-06 04:10 siukamming     Kernel Version            => 2.6.14(Debain
version) , 2.6.15(customized version)
02-20-06 08:26 toshio         Note Added: 0008143                          
02-20-06 08:29 toshio         Issue Monitored: toshio                      
02-25-06 08:15 toshio         Note Added: 0008185                          
03-01-06 05:32 siukamming     Note Added: 0008270                          
03-02-06 10:51 adoroar        Note Added: 0008295                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
