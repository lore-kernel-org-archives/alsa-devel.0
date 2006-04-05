From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001989]: cannot record on ALC880
Date: Wed, 5 Apr 2006 12:41:09 +0200
Message-ID: <18e0e39d6a9a52d81c256c24e15ec768@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 30091227
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 12:41:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1989> 
======================================================================
Reported By:                pomense
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1989
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core release 3
Kernel Version:             2.6.11.8
======================================================================
Date Submitted:             03-31-2006 23:56 CEST
Last Modified:              04-05-2006 12:41 CEST
======================================================================
Summary:                    cannot record on ALC880
Description: 
the snd_hda_intel module loads and recognize tha ALC880 sound card on my
Acer TM 8104WLMi, but I cannot record anything, neither via Front Mic or
using Mic as recording source. I can play sound very well.
======================================================================

----------------------------------------------------------------------
 pomense - 04-05-06 12:41 
----------------------------------------------------------------------
Tried model=test, set InputSource to In-2 and now the front mic speaks!!!
But I'm still not able to use the external mic.

Any ideas? I tried all the possible combinations for inputsources with no
results.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 23:56 pomense        New Issue                                    
03-31-06 23:56 pomense        File Added: lspc-nv                          
03-31-06 23:56 pomense        Distribution              => Fedora Core release 3
03-31-06 23:56 pomense        Kernel Version            => 2.6.11.8        
03-31-06 23:59 pomense        Issue Monitored: pomense                     
04-05-06 12:41 pomense        Note Added: 0009120                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
