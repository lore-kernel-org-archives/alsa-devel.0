From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000623]: No volume control on SPDIF on cmedia CMI8738-MC6
Date: Fri, 12 Nov 2004 14:03:57 +0100
Message-ID: <607c6be5c5273dc786d93613885342a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 600FC236
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 14:03:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=623> 
======================================================================
Reported By:                mtempels
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   623
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux 4.10
Kernel Version:             Linux bubbles 2.6.8.1-3-386
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Oct 12 12:41:57 BST
2004 i686 GNU/Linux
======================================================================
Date Submitted:             11-02-2004 11:24 CET
Last Modified:              11-12-2004 14:03 CET
======================================================================
Summary:                    No volume control on SPDIF on cmedia CMI8738-MC6
Description: 
There is no way to control the output volume on the SPDIF/out on my CMI8738
soundcard. It can just be switched on or off..
======================================================================

----------------------------------------------------------------------
 tiwai - 11-10-04 12:13 
----------------------------------------------------------------------
The volume attenuation is easy but the difficult thing is to do in the
right way.  Doing this in the kernel context is a bad idea (although we
already have such a code in the oss emulation module, but it's exceptional
- I'd love to get rid of that if allowed).

----------------------------------------------------------------------
 cltien - 11-12-04 14:03 
----------------------------------------------------------------------
tiwai,

May I know the reason  why doing PCM converting in kernel space is a bad
idea? Windows driver does this heavily (it also do sample rate convert to
48k), I am still learning using plugin.

Sincerely,
ChenLi Tien

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 11:24 mtempels       New Issue                                    
11-02-04 11:24 mtempels       Distribution              => Ubuntu Linux 4.10
11-02-04 11:24 mtempels       Kernel Version            => Linux bubbles
2.6.8.1-3-386 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Oct
12 12:41:57 BST 2004 i686 GNU/Linux
11-09-04 18:56 tiwai          Note Added: 0002337                          
11-09-04 19:01 mtempels       Note Added: 0002340                          
11-09-04 19:18 tiwai          Note Added: 0002342                          
11-09-04 20:15 mtempels       Note Added: 0002352                          
11-10-04 03:56 cltien         Note Added: 0002355                          
11-10-04 03:59 cltien         Note Added: 0002356                          
11-10-04 10:12 mtempels       Note Added: 0002359                          
11-10-04 12:13 tiwai          Note Added: 0002366                          
11-12-04 14:03 cltien         Note Added: 0002395                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
