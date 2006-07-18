From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001499]: no MIDI output on line out
Date: Tue, 18 Jul 2006 14:44:35 +0200
Message-ID: <8570223f02a3d1e7fbd6c500ffda2ac4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F60A176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:44:35 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1499> 
======================================================================
Reported By:                comotion
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1499
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian
Kernel Version:             2.6.13.2 SMP
======================================================================
Date Submitted:             10-25-2005 11:16 CEST
Last Modified:              07-18-2006 14:44 CEST
======================================================================
Summary:                    no MIDI output on line out
Description: 
MIDI output works on the headphone jack,  but not on the second (line out)
output. 
I should mention that regular PCM output is audible through both jacks. 

This breaks the principle of least surprise, since it is reasonable to
expect that MIDI output is audible through both soundcard outputs.
Attempts were made to re-route the output, however I was told on the
mailing list that this was not possible (see below for list thread).
======================================================================

----------------------------------------------------------------------
 tiwai - 10-25-05 12:10 
----------------------------------------------------------------------
It must be a DSP programming probem.  The WaveTable output is simply not
routed to these channels, I guess.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 11:16 comotion       New Issue                                    
10-25-05 11:16 comotion       Distribution              => debian          
10-25-05 11:16 comotion       Kernel Version            => 2.6.13.2 SMP    
10-25-05 11:17 comotion       File Added: lspci                            
10-25-05 11:17 comotion       File Added: amixer                           
10-25-05 12:10 tiwai          Note Added: 0006534                          
07-18-06 14:44 jcdutton       Status                   new => assigned     
07-18-06 14:44 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
