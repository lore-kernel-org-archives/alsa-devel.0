From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000092]: 2 channels on the 3 ones are totally off
Date: Sat, 19 Mar 2005 09:32:05 +0100
Message-ID: <cf3d96820555bcd592e57abfbb953746@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6D27C1F9
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:32:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=92> 
======================================================================
Reported By:                BeTa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   92
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux sid
Kernel Version:             2.6.3 (and also 2.6.2) vanilla
======================================================================
Date Submitted:             02-26-2004 22:49 CET
Last Modified:              03-19-2005 09:32 CET
======================================================================
Summary:                    2 channels on the 3 ones are totally off
Description: 
Only the rear speakers are working, and only when we set up "duplicate
front". The other ones are totally quiet.
======================================================================

----------------------------------------------------------------------
 BeTa - 03-18-04 18:11 
----------------------------------------------------------------------
I've not tested my sound card w/ real 5.1 sounds... but now, it is working
better. The only surprising thing is that rear speaker are active only if
I activated the "duplicate front" option in my alsa mixer, when I'm
playing simple 2.0 sounds.

Here are my options for my alsa modules :
options snd  device_mode=0660
alias snd-card-0 snd-via82xx
alias sound-slot-0 snd-via82xx

And it seems to have resolved my main problems... Then, I've added some
"options" to the snd-via82xx module, without any problem. ?? :cb

An other issue to the "crr crr" I used to hear sometimes, was to put away
the SPDIF wires from my AGP graphic card.

The only things which are still surprising are :
- when I use my headphones : front speakers come on the left and rear ones
on the right... :c/ even if the balance is working well on my 5.1 kit :c/
But that's not still critical.
- playing videos w/ mplayer (for example) takes lots of CPU usage :c((. On
an AMD XP1600+ (1.4GHz), it says me that the CPU is too slow to play a
XviD that I can play *really easily* on an AMD Athlon 1,2GHz...

----------------------------------------------------------------------
 jdthood - 03-19-05 09:32 
----------------------------------------------------------------------
Submitter: Do you have the same problem with current ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-04 22:49 BeTa           New Issue                                    
02-26-04 22:49 BeTa           Issue Monitored: BeTa                        
03-12-04 19:27 BeTa           Note Added: 0000581                          
03-12-04 19:29 BeTa           Note Added: 0000582                          
03-16-04 13:27 BeTa           Note Added: 0000626                          
03-17-04 14:26 BeTa           Note Deleted: 0000582                        
03-17-04 14:34 BeTa           Note Added: 0000634                          
03-17-04 14:41 BeTa           Note Edited: 0000634                         
03-17-04 14:42 BeTa           Note Deleted: 0000634                        
03-17-04 16:00 BeTa           Note Added: 0000635                          
03-18-04 18:07 BeTa           Note Deleted: 0000635                        
03-18-04 18:11 BeTa           Note Added: 0000642                          
03-19-05 09:32 jdthood        Note Added: 0004020                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
