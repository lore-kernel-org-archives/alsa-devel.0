From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000185]: Audigy2 SPDIF CDROM data noise after stop
Date: Sat, 9 Apr 2005 20:55:58 +0200
Message-ID: <51f695a6ab6334d1b6b5e22f526f50be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0061D236
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 20:55:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=185> 
======================================================================
Reported By:                pavouk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   185
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrake 10.0
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-04-2004 21:07 CEST
Last Modified:              04-09-2005 20:55 CEST
======================================================================
Summary:                    Audigy2 SPDIF CDROM data noise after stop
Description: 
My DVDROM DV-5700B is connected through digital SPDIF input to Audigy2 PCI
card. When I play AudioCD, that after STOP or end of CD is heard from
speakers loud purl or something like data noise. Same hardware with
Soundblaster Live! card works great.
This problem was visible with older kernel and Alsa versions too.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 04:38 
----------------------------------------------------------------------
Submitter: Is there any improvement in later ALSA releases?

----------------------------------------------------------------------
 pavouk - 04-09-05 20:55 
----------------------------------------------------------------------
I have now another PC VIA C3 1GHz with kernel 2.6.11.6, Mandrake10.1 but
same DVD Rom and Audigy2 card. Problem is still here, but maybe not too
often. When I made few stop/play actions, that sometimes after stop is
audio silent (which is good), but sometimes is heared constant low
frequency buzzing and strange sounds if DVDROM works with medium.
Situation was changed, but not definitely solved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-04 21:07 pavouk         New Issue                                    
04-04-04 21:07 pavouk         Distribution              => Mandrake 10.0   
04-04-04 21:07 pavouk         Kernel Version            => 2.6.5           
09-03-04 23:19 pavouk         Note Added: 0001698                          
04-09-05 04:38 jdthood        Note Added: 0004387                          
04-09-05 20:55 pavouk         Note Added: 0004428                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
