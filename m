From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001929]: Sound clips over 80% of volume from non clipped source
Date: Wed, 29 Mar 2006 19:26:46 +0200
Message-ID: <bb317b2deea877c69a3a4015dd521897@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E8BC193
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 19:26:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1929> 
======================================================================
Reported By:                specialboy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1929
Category:                   CORE OSS - mixer
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-15-2006 23:38 CET
Last Modified:              03-29-2006 19:26 CEST
======================================================================
Summary:                    Sound clips over 80% of volume from non clipped
source
Description: 
Was playing a video in VLC when I noticed that the sound was clipping when
the player volume was full.  Reduced Alsa volume to <80% and increased
player to full and the problem went away.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 19:26 
----------------------------------------------------------------------
It's no bug.  With some codecs, the volume over a certain value (about 80%)
means the gain over 0dB.  In 100% volume, it becmes +12dB or so.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 23:38 specialboy     New Issue                                    
03-29-06 19:26 tiwai          Status                   new => resolved     
03-29-06 19:26 tiwai          Resolution               open => not an issue
03-29-06 19:26 tiwai          Assigned To               => tiwai           
03-29-06 19:26 tiwai          Note Added: 0009016                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
