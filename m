From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001060]: snd-azx rear speakers volume
	is too low
Date: Fri, 21 Jul 2006 02:28:14 +0200
Message-ID: <7ad2e298ca2ededbe648e41d1b4e25af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8FC891AC
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 02:28:14 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1060> 
======================================================================
Reported By:                maranik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1060
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu Linux
Kernel Version:             2.6.11.7
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             04-17-2005 23:56 CEST
Last Modified:              07-21-2006 02:28 CEST
======================================================================
Summary:                    snd-azx rear speakers volume is too low
Description: 
I have a Azalia sound chip, sound works with snd-azx module, but i can only
listen to front speakers. Rear speakers are like inesistent. 
Sound is too low. 
I set 6ch in alsamixer.

TIA.
======================================================================

----------------------------------------------------------------------
 maranik - 04-19-05 20:56 
----------------------------------------------------------------------
I installed 1.0.9rc2 and i loaded snd-hda-intel. The problem persists, and
the sound quality is worse than before.
I hope you can help me. 

TIA

----------------------------------------------------------------------
 rlrevell - 12-19-05 05:53 
----------------------------------------------------------------------
Please try 1.0.11rc1, lots of bugs have been fixed in this driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 23:56 maranik        New Issue                                    
04-17-05 23:56 maranik        Distribution              => Ubuntu Linux    
04-17-05 23:56 maranik        Kernel Version            => 2.6.11.7        
04-19-05 17:41 tiwai          Note Added: 0004525                          
04-19-05 17:41 tiwai          Category                 PCI - azx => PCI -
hda-intel
04-19-05 20:53 maranik        File Added: asound.state                     
04-19-05 20:53 maranik        File Added: codec#2                          
04-19-05 20:56 maranik        Note Added: 0004539                          
12-19-05 05:53 rlrevell       Note Added: 0007089                          
07-21-06 02:28 Adrian Bunk    Status                   new => closed       
07-21-06 02:28 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
