From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000155]: Crackly / sizzly recording on VIA VT82C686 AC97 since 2.6.3
Date: Fri, 8 Apr 2005 22:23:59 +0200
Message-ID: <bc6bde427fabb5a9684f590281edd42b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 706D11F0
	for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2005 22:24:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=155> 
======================================================================
Reported By:                sim
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   155
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Debian unstable
Kernel Version:             2.6.3 through 2.6.5-rc2
======================================================================
Date Submitted:             03-24-2004 06:03 CET
Last Modified:              04-08-2005 22:23 CEST
======================================================================
Summary:                    Crackly / sizzly recording on VIA VT82C686 AC97
since 2.6.3
Description: 
Hello,

I have a mythtv box set up and recently upgraded the kernel from
2.6.0-test9 to 2.6.4.  Everything appeared to play normally, but new
recordings since the upgrade all sound crackly.  2.6.5-rc2 and 2.6.3 also
seem to be broken.  2.6.2 works as expected.

There appear to be a large number of changes to the ALSA core between
2.6.2 and 2.6.3.  How should I attempt to track the problem down further?

Athlon 1800 XP, MSI K7 Master (MS-6330), 48 KHz stereo recording and
playback.  The problem also shows up with Audacity, and as such does not
appear to be application specific.  I can send a sample of the poor sound
recording upon request.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-16-04 12:45 
----------------------------------------------------------------------
Something wrong in oss emulation...

----------------------------------------------------------------------
 jdthood - 04-08-05 22:23 
----------------------------------------------------------------------
tiwai: Can this be closed now?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 06:03 sim            New Issue                                    
03-24-04 06:03 sim            Distribution              => Debian unstable 
03-24-04 06:03 sim            Kernel Version            => 2.6.3 through
2.6.5-rc2
04-08-04 15:15 m9715936       Issue Monitored: m9715936                    
04-08-04 15:25 m9715936       Note Added: 0000767                          
04-08-04 15:29 m9715936       Note Edited: 0000767                         
04-10-04 10:13 m9715936       Note Edited: 0000767                         
04-11-04 19:28 uli            Note Added: 0000780                          
04-23-04 17:29 tiwai          Status                   new => assigned     
04-23-04 17:29 tiwai          Assigned To               => tiwai           
04-23-04 17:30 tiwai          Note Added: 0000907                          
04-23-04 18:02 m9715936       Note Added: 0000913                          
04-23-04 18:07 tiwai          Note Added: 0000914                          
04-23-04 18:36 m9715936       Note Added: 0000915                          
04-23-04 18:40 tiwai          Note Added: 0000916                          
04-23-04 18:59 m9715936       Note Added: 0000917                          
06-13-04 11:27 sim            File Added: patch-2.6.3-rc1-try2.11.works         
          
06-13-04 11:32 sim            Note Added: 0001303                          
06-20-04 11:41 uli            Note Added: 0001324                          
06-22-04 18:41 tiwai          Status                   assigned => resolved
06-22-04 18:41 tiwai          Resolution               open => fixed       
07-16-04 12:45 tiwai          Status                   resolved => feedback
07-16-04 12:45 tiwai          Resolution               fixed => reopened   
07-16-04 12:45 tiwai          Note Added: 0001450                          
04-08-05 22:23 jdthood        Note Added: 0004374                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
