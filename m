From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001965]: Error in "Writing an ALSA driver" document
Date: Sun, 26 Mar 2006 13:49:32 +0200
Message-ID: <d170a33a12a4d5e20cfa2c37bbf76bd2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2458E19C
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 13:49:33 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1965> 
======================================================================
Reported By:                zx80user
Assigned To:                tiwai
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1965
Category:                   a typo
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-26-2006 01:54 CET
Last Modified:              03-26-2006 13:49 CEST
======================================================================
Summary:                    Error in "Writing an ALSA driver" document
Description: 
In the section on writing control code

This: struct snd_ctl_elem_info

and similar types referred to in the documentation (the how to write a
driver docs) doesn't actually exist...

snd_ctl_elem_info_t does exist as does sndrv_ctl_elem_info 
======================================================================

----------------------------------------------------------------------
 tiwai - 03-26-06 13:49 
----------------------------------------------------------------------
struct snd_ctl_elem_info _does_ exist in the recent version.
You're referring to a too old version of alsa-driver code.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-26-06 01:54 zx80user       New Issue                                    
03-26-06 13:49 tiwai          Status                   new => resolved     
03-26-06 13:49 tiwai          Resolution               open => not an issue
03-26-06 13:49 tiwai          Assigned To               => tiwai           
03-26-06 13:49 tiwai          Note Added: 0008970                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
