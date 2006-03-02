From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001794]: Change of the capture source works not like expected
Date: Thu, 2 Mar 2006 15:26:33 +0100
Message-ID: <364c8d20a9516cbf1a654b52a345b5ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F451181
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 15:26:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1794> 
======================================================================
Reported By:                Peppi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1794
Category:                   alsamixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-30-2006 02:24 CET
Last Modified:              03-02-2006 15:26 CET
======================================================================
Summary:                    Change of the capture source works not like expected
Description: 
A change from Mic to Line changes only one value.
======================================================================

----------------------------------------------------------------------
 Raymond - 02-28-06 03:50 
----------------------------------------------------------------------
No problem on 1.0.11rc3

amixer contents

numid=102,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Mic'
  ; Item #1 'CD'
  ; Item #2 'Video'
  ; Item #3 'Aux'
  ; Item #4 'Line'
  ; Item #5 'Mix'
  ; Item #6 'Mix Mono'
  ; Item #7 'Phone'
  : values=4,4

----------------------------------------------------------------------
 tiwai - 03-02-06 15:26 
----------------------------------------------------------------------
There was a bug in alsa-lib.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-06 02:24 Peppi          New Issue                                    
02-28-06 03:02 Peppi          Note Added: 0008236                          
02-28-06 03:50 Raymond        Note Added: 0008237                          
03-02-06 15:26 tiwai          Status                   new => resolved     
03-02-06 15:26 tiwai          Resolution               open => fixed       
03-02-06 15:26 tiwai          Assigned To               => tiwai           
03-02-06 15:26 tiwai          Note Added: 0008307                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
