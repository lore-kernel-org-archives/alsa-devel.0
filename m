From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001201]: Can't use xmms with alsa driver (hda-intel)
Date: Tue, 21 Jun 2005 12:48:38 +0200
Message-ID: <8f5fd9a479edc655d37e66ab5caf41d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1F9AD1EE
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 12:48:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1201> 
======================================================================
Reported By:                sse450
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1201
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 duplicate
Duplicate:                  1179
Fixed in Version:           
======================================================================
Date Submitted:             06-17-2005 22:50 CEST
Last Modified:              06-21-2005 12:48 CEST
======================================================================
Summary:                    Can't use xmms with alsa driver (hda-intel)
Description: 
xmms can play using OSS and eSound output plugins. If I select alsa plugin,
sound gets very cracky and noisy.

I use spdif output of the sound chip.

Here is the modprobe.conf:
alias snd-card-0 snd-hda-intel
options snd-card-0 index=0
options snd-hda-intel index=0
options snd-hda-intel model=5stack-digout
remove snd-hda-intel { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-hda-intel

cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).

I would appreciate any help.

Thanks,
Mufit Eribol
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001179 alsa-lib 1.0.9 breaks snd_hda_intel
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 22:50 sse450         New Issue                                    
06-21-05 12:48 tiwai          Relationship added       duplicate of 0001179
06-21-05 12:48 tiwai          Duplicate ID             0 => 1179           
06-21-05 12:48 tiwai          Status                   assigned => resolved
06-21-05 12:48 tiwai          Resolution               open => duplicate   
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
