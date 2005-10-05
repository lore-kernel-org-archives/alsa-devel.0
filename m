From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001468]: Revolution7+1,module loaded, no proc info, no sound
Date: Wed, 5 Oct 2005 18:38:10 +0200
Message-ID: <73937e105b07c45537ec8a037ff4a5cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC60A190
	for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2005 18:38:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1468> 
======================================================================
Reported By:                goldenfish
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1468
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian testing
Kernel Version:             2.6.13-rc6
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-29-2005 21:34 CEST
Last Modified:              10-05-2005 18:38 CEST
======================================================================
Summary:                    Revolution7+1,module loaded, no proc info, no sound
Description: 
I was purchased today M-Audio Revolution 7+1 card. I compiled kernel. I
loaded module
with modprobe snd-ice1724. by lsmod command module loaded.

But in /proc/asound/cards no card. alsaconf not found this card. No sound
from card.

thanks for help with this card.
======================================================================

----------------------------------------------------------------------
 goldenfish - 09-29-05 21:37 
----------------------------------------------------------------------
aditionall info: in the kernel.log no messages about this card.

----------------------------------------------------------------------
 goldenfish - 09-30-05 01:13 
----------------------------------------------------------------------
Close this bug please. I hear now sound from this card.
I change PCI slot location of this card.

But there is small mystery.

identification of card now:

0000:02:04.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 b4 00 00 01 b0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 12 14 30 36
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


problem is most propably similar bug number #0001403.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-29-05 21:34 goldenfish     New Issue                                    
09-29-05 21:34 goldenfish     File Added: lsmod_0                          
09-29-05 21:34 goldenfish     Distribution              => Debian testing  
09-29-05 21:34 goldenfish     Kernel Version            => 2.6.13-rc6      
09-29-05 21:37 goldenfish     Note Added: 0006423                          
09-30-05 01:13 goldenfish     Note Added: 0006428                          
10-05-05 18:38 tiwai          Status                   new => resolved     
10-05-05 18:38 tiwai          Resolution               open => not an issue
10-05-05 18:38 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
