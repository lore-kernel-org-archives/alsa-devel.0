From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000595]: No support for Audigy 2 rev 8 (Audigy 2 Value)
Date: Fri, 22 Oct 2004 16:03:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <47c5033885f7b7873631f20626e75afc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 162F1270
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2004 16:03:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=595> 
======================================================================
Reported By:                mohammed_imran
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   595
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.3,2.6.5,2.6.8
======================================================================
Date Submitted:             10-22-2004 15:47 CEST
Last Modified:              10-22-2004 16:03 CEST
======================================================================
Summary:                    No support for Audigy 2 rev 8 (Audigy 2 Value)
Description: 
Hi. I have read the alsa readme and checked support but it seems that
audigy 2 cards currently working with alsa (emu10k1 driver) have revision
4. I recently bought an Audigy 2 Value card and doing lspci lists it as:
03:02.0 Multimedia audio controller: Creative Labs: Unknown device 0008

I guess this card is revision 8 and not revision 4. I have tried to make
it work with alsa 1.0.6a to no avail.

No Linux system up to Kernel 2.6.8 detects this sound card and i haven't
tried any kernel above 2.6.8.

The Audigy 2 Value card is new (its not the ZS Value)
======================================================================

----------------------------------------------------------------------
 pzad - 10-22-04 16:03 
----------------------------------------------------------------------
AFAIK this card has new chip. This chip is not supported. There are no
specs available from Creative for now. No specs = no driver unless someone
reverse engineering original drivers. Or you can try to add this pci id to
emu10k1 driver and try if it will work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-22-04 15:47 mohammed_imran New Issue                                    
10-22-04 15:47 mohammed_imran Kernel Version            => 2.6.3,2.6.5,2.6.8
10-22-04 16:03 pzad           Note Added: 0002243                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
