From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000051]: system crashes running aplay as unprivileged user on a US428. No sound except very occasional <.5 sec bursts
Date: Wed, 22 Mar 2006 03:20:19 +0100
Message-ID: <cd8612e5c3cab186e516ddcb9084b154@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D7A61A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:20:19 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=51> 
======================================================================
Reported By:                marqrdt
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   51
Category:                   USB - usb-usx2y
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 1
Kernel Version:              2.4.22-1.2115.nptl (stock Fedora kernel)
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-11-2004 15:39 CET
Last Modified:              03-22-2006 03:20 CET
======================================================================
Summary:                    system crashes running aplay as unprivileged user on
a US428. No sound except very occasional <.5 sec bursts
Description: 
running the following command will cause a system crash +50% of the time:
aplay -v -D plug:hw:USX2Y music/wav/chant-reverb.wav

It runs file using the ALSA driver for the internal ALI5451 card.

Also, no sound comes out of the US428 except for very occasional <.5
bursts (never more than once per sound file). Headphones hooked to phone
jack, ext. speaker hooked to line-out.
No audio capture.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 15:47 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:20 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-04 15:39 marqrdt        New Issue                                    
02-11-04 17:27 marqrdt        Issue Monitored: marqrdt                     
02-11-04 20:09 karsten        Note Added: 0000221                          
03-18-04 14:13 piem           Note Added: 0000641                          
10-01-04 01:28 karsten        Note Added: 0001991                          
09-14-05 15:47 jdthood        Note Added: 0006158                          
03-22-06 03:20 rlrevell       Status                   assigned => closed  
03-22-06 03:20 rlrevell       Note Added: 0008812                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
