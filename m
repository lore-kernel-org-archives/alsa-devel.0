From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000185]: Audigy2 SPDIF CDROM data
	noise after stop
Date: Tue, 18 Jul 2006 21:08:37 +0200
Message-ID: <ff5b67c3e8f706085ae4b01c2f23e205@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1D88F236
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 21:08:38 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=185> 
======================================================================
Reported By:                pavouk
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   185
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.0
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-04-2004 21:07 CEST
Last Modified:              07-18-2006 21:08 CEST
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
 pavouk - 04-09-05 20:55 
----------------------------------------------------------------------
I have now another PC VIA C3 1GHz with kernel 2.6.11.6, Mandrake10.1 but
same DVD Rom and Audigy2 card. Problem is still here, but maybe not too
often. When I made few stop/play actions, that sometimes after stop is
audio silent (which is good), but sometimes is heared constant low
frequency buzzing and strange sounds if DVDROM works with medium.
Situation was changed, but not definitely solved.

----------------------------------------------------------------------
 pavouk - 07-18-06 21:08 
----------------------------------------------------------------------
It works now for me with vanilla kernel 2.6.17.3. AUTOMUTE function
probably works now correctly.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-04 21:07 pavouk         New Issue                                    
04-04-04 21:07 pavouk         Distribution              => Mandrake 10.0   
04-04-04 21:07 pavouk         Kernel Version            => 2.6.5           
09-03-04 23:19 pavouk         Note Added: 0001698                          
04-09-05 04:38 jdthood        Note Added: 0004387                          
04-09-05 20:55 pavouk         Note Added: 0004428                          
04-09-05 22:00 jdthood        Status                   new => acknowledged 
07-18-06 14:46 jcdutton       Status                   acknowledged => assigned
07-18-06 14:46 jcdutton       Assigned To               => jcdutton        
07-18-06 21:08 pavouk         Note Added: 0011072                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
