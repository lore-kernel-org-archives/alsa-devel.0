From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000408]: Volume control is chaotic
Date: Mon, 22 Nov 2004 14:44:15 +0100
Message-ID: <9c198f393ce9b6bc42b45fbc8fa5a5a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8E89F2B3
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 14:44:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=408> 
======================================================================
Reported By:                skamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   408
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-27-2004 18:40 CEST
Last Modified:              11-22-2004 14:44 CET
======================================================================
Summary:                    Volume control is chaotic
Description: 
Volume control doesn't work properly, with alsa-mixer as well as with
gnome-volume-control. As I figured out that line-out volume was controled
with DAC and DAC1 (how intuitive), I noticed that while sliding the
controls up and down increased and decreased the volume as expected,
modifying the master volume control afterwards made the volume jump to a
much lower level than expected: increasing or decreasing the master volume
even just a little bit makes the overall volume drop, even though it is
not mirrored by the controls.

Thus, setting DAC and DAC1 to 100% while Master was set to 82% resulted in
a quite high volume, but modifying the master volume to 84% or 80%
resulted in the drop. Setting master volume to 60% made the sound very
low, and setting it to 40% made it almost inaudible, until I changed DAC
and DAC1 by 2%.
======================================================================

----------------------------------------------------------------------
 ungod - 10-13-04 18:51 
----------------------------------------------------------------------
Well, it is my belief that the problem i solved, but I suppose skamp is the
only one who can rightfully tell whether the problem i solved.

----------------------------------------------------------------------
 skamp - 10-14-04 21:08 
----------------------------------------------------------------------
Problem solved, as far as I'm concerned. Thanks a lot!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 18:40 skamp          New Issue                                    
07-27-04 18:40 skamp          File Added: aadebug                          
07-27-04 18:40 skamp          Distribution              => LFS 5.1.1, BLFS 5.1
07-27-04 18:40 skamp          Kernel Version            => 2.4.26          
07-27-04 18:52 skamp          Issue Monitored: skamp                       
08-17-04 04:33 skamp          Note Added: 0001571                          
08-18-04 13:47 tiwai          Status                   new => assigned     
08-18-04 13:47 tiwai          Assigned To               => tiwai           
08-18-04 13:47 tiwai          Note Added: 0001578                          
08-18-04 13:48 tiwai          File Added: aureon-volfix3.dif                    
08-18-04 15:20 skamp          Note Added: 0001579                          
08-18-04 15:32 tiwai          Note Added: 0001580                          
08-18-04 15:34 skamp          Note Added: 0001581                          
08-18-04 15:36 skamp          Note Edited: 0001581                         
08-18-04 15:41 tiwai          Note Added: 0001583                          
10-06-04 22:10 ungod          Note Added: 0002026                          
10-06-04 22:10 ungod          File Added: aureon-volfix4.diff                   

10-07-04 09:50 ungod          File Added: aureon-volfix4.1.diff                 
  
10-07-04 09:52 ungod          Note Added: 0002028                          
10-07-04 14:43 tiwai          Note Added: 0002032                          
10-07-04 14:44 tiwai          File Added: aureon-volfix4.2.diff                 
  
10-07-04 18:03 ungod          Note Added: 0002035                          
10-07-04 21:26 skamp          Note Added: 0002039                          
10-08-04 04:01 ungod          Note Added: 0002042                          
10-08-04 09:31 skamp          Note Added: 0002044                          
10-08-04 12:24 tiwai          Note Added: 0002047                          
10-09-04 01:21 ungod          Note Added: 0002059                          
10-09-04 02:00 ungod          File Added: aureon-volfix4.3.diff                 
  
10-09-04 02:05 ungod          Note Added: 0002060                          
10-11-04 12:16 tiwai          Note Added: 0002075                          
10-12-04 14:37 tiwai          Note Added: 0002094                          
10-13-04 18:51 ungod          Note Added: 0002132                          
10-14-04 21:08 skamp          Note Added: 0002159                          
10-19-04 16:30 tiwai          Status                   assigned => resolved
10-19-04 16:30 tiwai          Resolution               open => fixed       
11-22-04 14:44 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
