From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001585]: No sound from Soundblaster Live USB since updating kernel drivers to 1.0.10.rc3
Date: Sat, 31 Dec 2005 05:31:34 +0100
Message-ID: <6f03d9a79758d562104ed071a2be7e7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DA6316F
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 05:31:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585> 
======================================================================
Reported By:                sailfrog
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1585
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             > 2.6.14 (rc1, mm1, mm2, rc2)
======================================================================
Date Submitted:             11-21-2005 17:45 CET
Last Modified:              12-31-2005 05:31 CET
======================================================================
Summary:                    No sound from Soundblaster Live USB since updating
kernel drivers to 1.0.10.rc3
Description: 
Every kernel since 2.6.14 (I have tried rc1, mm1, mm2, and rc2) has left
my external USB sound card broken. It appears to be something in the
alsa-git-2005-11-07.patch that was posted to LKML on 11/07/05:

subject:         [ALSA UPDATE] 1.0.10rc3
message-id:        
<Pine.LNX.4.61.0511071457480.8818@tm8103.perex-int.cz>

Applying this alsa update to 2.6.14 also renders the card silent. The
card
is visible in /proc/asound/cards, alsamixer sees it and I can adjust the
volume, but I get no sound from xmms, mplayer, etc. I tried enabling alsa
debug and verbose printk but I was unable to find any additional messages
from dmesg or in any log files. The card is a Creative Labs SoundBlaster
Live 24-bit external. I'm using the SPDIF output to run sound through a
home theater system. I'm running debian unstable on a Toshiba laptop. 

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:47 
----------------------------------------------------------------------
OK it seems pretty clear that the attached ~300 line patch extracted from
alsa-git-2005-11-07 contains the change that broke it.  Does this help?

----------------------------------------------------------------------
 smithbone - 12-31-05 05:31 
----------------------------------------------------------------------
Is the patch a fix or just for reference?  If I reverse the patch then I
get unresolved symbols.  This was against 2.6.15-rc7

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-05 17:45 sailfrog       New Issue                                    
11-21-05 17:45 sailfrog       Distribution              => Debian          
11-21-05 17:45 sailfrog       Kernel Version            => > 2.6.14 (rc1, mm1,
mm2, rc2)
11-21-05 18:45 sailfrog       Issue Monitored: sailfrog                    
11-22-05 07:54 Clemens LadischNote Added: 0006785                          
12-09-05 00:51 sailfrog       Note Added: 0006965                          
12-09-05 16:46 smithbone      Note Added: 0006968                          
12-22-05 02:25 sailfrog       Note Added: 0007117                          
12-30-05 19:48 sailfrog       Note Added: 0007251                          
12-30-05 20:01 rlrevell       Note Added: 0007252                          
12-30-05 20:08 rlrevell       Note Added: 0007254                          
12-30-05 20:31 sailfrog       Note Added: 0007256                          
12-30-05 20:34 rlrevell       Note Added: 0007257                          
12-30-05 20:41 sailfrog       Note Added: 0007258                          
12-30-05 20:43 rlrevell       Note Added: 0007259                          
12-31-05 02:32 smithbone      Note Added: 0007319                          
12-31-05 03:45 rlrevell       File Added: alsa-git-2005-11-07-usbaudio.patch    
               
12-31-05 03:47 rlrevell       Note Added: 0007331                          
12-31-05 05:31 smithbone      Note Added: 0007343                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
