From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000659]: configure: error: Unsupported soundcard cs4236
Date: Tue, 23 Nov 2004 16:17:14 +0100
Message-ID: <d051f8d86fe1d5a898c1b6bd9dadaed8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E7CCE2D3
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2004 16:17:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=659> 
======================================================================
Reported By:                olivier55
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   659
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               mandrake 10.1
Kernel Version:             2.6.8.1-10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-20-2004 22:25 CET
Last Modified:              11-23-2004 16:17 CET
======================================================================
Summary:                    configure: error: Unsupported soundcard cs4236
Description: 
when i do : 
./configure --with-cards=cs4236 --with-sequencer=yes

i've this error : 
configure: error: Unsupported soundcard cs4236

my soundcard is a Crystal Audio CS4237 (cirrus logic)
i have a laptop dell inspiron 8200
======================================================================

----------------------------------------------------------------------
 olivier55 - 11-22-04 19:13 
----------------------------------------------------------------------
with the default install of mandrake 10.1, my sound card is detected. 
if i start "alsamixer", i have this : 









































































































































































































































php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org
 /alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;[A
 lsaMixer
v1.0.6 (Press Escape to







































































































































































-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-p
 roject.org/alsa-bug/view.php?id=9472;&https://bugtrack.alsa-project.org/alsa-bug/view.php?
 id=9488;
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9474; Card: Intel
82801CA-ICH3                                          
          &https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9474;
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9474; Chip: Cirrus Logic
CS4205 rev 3                                   
          &https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9474;
&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9474; Item: Master

But the cd CS4205 is not the properly sound card. However, with this
configuration, i've no midi device in Kmidi. My trouble is, how to do for
having a midi device  ?

----------------------------------------------------------------------
 tiwai - 11-23-04 16:17 
----------------------------------------------------------------------
CS4205 is AC97 codec chip.  Your driver should be snd-intel8x0.

Simply build all drivers without --with-cards option, and run alsaconf to
detect/configure the card.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-20-04 22:25 olivier55      New Issue                                    
11-20-04 22:25 olivier55      Distribution              => mandrake 10.1   
11-20-04 22:25 olivier55      Kernel Version            => 2.6.8.1-10      
11-20-04 22:30 olivier55      Issue Monitored: olivier55                    
11-20-04 22:30 olivier55      Issue End Monitor: olivier55                    
11-22-04 14:42 tiwai          Note Added: 0002502                          
11-22-04 19:13 olivier55      Note Added: 0002511                          
11-23-04 16:17 tiwai          Status                   assigned => resolved
11-23-04 16:17 tiwai          Resolution               open => not an issue
11-23-04 16:17 tiwai          Note Added: 0002521                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
