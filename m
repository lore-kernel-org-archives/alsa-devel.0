From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000214]: ac3 passthrough not working
Date: Sat, 26 Feb 2005 05:42:12 +0100
Message-ID: <2159eca4046c0ee6c4bc4f6a113b3214@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 23511260
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2005 05:42:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=214> 
======================================================================
Reported By:                m_stolle
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   214
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-16-2004 05:06 CEST
Last Modified:              02-26-2005 05:42 CET
======================================================================
Summary:                    ac3 passthrough not working
Description: 
I have a Dell Inspiron 8200 with an Intel ICH3/Cirrus Logic CS4205 sound
card.  Unfortunately, the hardware AC3 passthrough does not work. 
Instead, I only get a high-pitched funny noise.

The symptoms are the same in mplayer as well as in xine.  Verbose output
of mplayer provided below:
======================================================================

----------------------------------------------------------------------
 tiwai - 02-02-05 10:59 
----------------------------------------------------------------------
Attach the output of iecset and /proc/asound/card0/codec97#0/* files
_during_ you run ac3dec -C.  Attach the ones before ac3dec for comparison,
too.

----------------------------------------------------------------------
 m_stolle - 02-26-05 05:42 
----------------------------------------------------------------------
I have attached the output of iecset, iecset +x,
/proc/asound/card0/codec97#0/ac97#0-0 and
/proc/asound/card0/codec97#0/ac97#0-0+regs

I hope that helps in implementing a more permanent solution 8-).  Sorry
for the delay.

MST

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-04 05:06 m_stolle       New Issue                                    
04-16-04 05:06 m_stolle       Distribution              => Debian          
04-16-04 05:06 m_stolle       Kernel Version            => 2.4.25          
09-11-04 05:25 m_stolle       Note Added: 0001744                          
09-13-04 15:41 tiwai          Note Added: 0001747                          
09-17-04 05:05 m_stolle       Note Added: 0001775                          
09-17-04 10:21 stoffel        Note Added: 0001776                          
09-17-04 10:42 stoffel        Note Added: 0001778                          
09-17-04 10:43 stoffel        Note Edited: 0001776                         
09-17-04 10:43 stoffel        Note Deleted: 0001778                        
09-17-04 10:45 stoffel        Note Edited: 0001776                         
09-17-04 14:12 m_stolle       Note Added: 0001779                          
09-18-04 16:52 stoffel        Note Added: 0001782                          
09-18-04 16:54 stoffel        Note Edited: 0001782                         
09-18-04 16:55 stoffel        Note Edited: 0001782                         
09-18-04 17:50 m_stolle       Note Added: 0001783                          
09-20-04 17:44 tiwai          Note Added: 0001791                          
09-20-04 19:55 stoffel        Note Added: 0001793                          
09-20-04 20:18 m_stolle       Note Added: 0001794                          
09-21-04 11:55 tiwai          Note Added: 0001797                          
09-21-04 14:44 m_stolle       Note Added: 0001803                          
09-21-04 14:47 m_stolle       Note Added: 0001804                          
09-21-04 14:53 m_stolle       Note Added: 0001805                          
09-21-04 15:07 tiwai          Note Added: 0001806                          
09-21-04 15:54 m_stolle       File Added: ac97                             
09-21-04 15:56 m_stolle       File Added: ac97+regs                        
09-21-04 15:56 m_stolle       File Added: iecset                           
09-21-04 15:56 m_stolle       File Added: asound.state                     
09-21-04 16:01 m_stolle       Note Added: 0001807                          
10-12-04 06:23 m_stolle       Note Added: 0002087                          
10-12-04 12:55 tiwai          Note Added: 0002089                          
10-12-04 20:13 sresing        File Added: dmesg.log                        
10-12-04 20:15 sresing        Note Added: 0002108                          
02-02-05 04:48 m_stolle       Note Added: 0003476                          
02-02-05 10:59 tiwai          Note Added: 0003481                          
02-26-05 05:42 m_stolle       Note Added: 0003739                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
