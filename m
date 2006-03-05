From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001786]: Speaker produce sound even head phone is plugged in
Date: Sun, 5 Mar 2006 08:06:43 +0100
Message-ID: <bbd27f9ce37b1fdd48f009c6944fa8e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17B0515E
	for <alsa-devel@alsa-project.org>; Sun,  5 Mar 2006 08:06:44 +0100 (MET)
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
Last Modified:              03-05-2006 08:06 CET
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
 toshio - 03-02-06 18:09 
----------------------------------------------------------------------
tiwai: I don't mind that. But, as you said, maybe it's better to discuss
this with the author, the alsa version in the latest kernel has other
issues and requires other modifications to get going. See bug id 1843 and
somehow it mutes the lines out so those need to be renabled too. Luckily
those functions are already coded so they need to be added to
initialisation code...

----------------------------------------------------------------------
 nemisis3 - 03-05-06 08:06 
----------------------------------------------------------------------
Seconded on a Dell B120. Looking online, linux-laptops, linux-questions
this
is a common problem with Dell laptops. Please fix as I can't listen to the

radio at work.

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
03-02-06 10:51 adoroar        Note Edited: 0008295                         
03-02-06 10:52 adoroar        Note Edited: 0008295                         
03-02-06 11:06 toshio         File Added: unsol-patch.tar.bz2                   

03-02-06 11:09 toshio         Note Added: 0008296                          
03-02-06 11:10 toshio         Note Deleted: 0008185                        
03-02-06 11:50 tiwai          Note Added: 0008297                          
03-02-06 12:54 toshio         Note Added: 0008300                          
03-02-06 12:58 tiwai          Note Added: 0008301                          
03-02-06 14:50 adoroar        Note Added: 0008306                          
03-02-06 18:09 toshio         Note Added: 0008324                          
03-05-06 08:06 nemisis3       Note Added: 0008356                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
