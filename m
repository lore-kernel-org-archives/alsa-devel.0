From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001913]: No Sound for SB Extigy for volume below 30%
Date: Sat, 11 Mar 2006 19:51:25 +0100
Message-ID: <35ff5982a7f8ac7496f42ca1a10378d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 071E11A2
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 19:51:25 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1913> 
======================================================================
Reported By:                andersin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1913
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r4
======================================================================
Date Submitted:             03-11-2006 19:51 CET
Last Modified:              03-11-2006 19:51 CET
======================================================================
Summary:                    No Sound for SB Extigy for volume below 30%
Description: 
The volume control for the SB Extigy only works accurately for values above
50%. Below that, sound is still detectable very faintly as low as 30%
(This is with my speakers set to full output which is unbearably loud if
the volume in alsamixer gets turned up again). Below 30% there is no sound
as far as I can tell. Effectively there's only half a volume control
(50%-100%).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 19:51 andersin       New Issue                                    
03-11-06 19:51 andersin       Distribution              => Gentoo          
03-11-06 19:51 andersin       Kernel Version            => 2.6.15-gentoo-r4
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
