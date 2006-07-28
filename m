From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000183]: Mic boost boosts mic playback
	and not recording
Date: Fri, 28 Jul 2006 10:54:20 +0200
Message-ID: <3b3df749d3059c3dbffa2443c8478725@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 01351102
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 10:54:20 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=183> 
======================================================================
Reported By:                Schugy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   183
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               SuSE 8.2
Kernel Version:             2.4.25
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-04-2004 13:51 CEST
Last Modified:              07-28-2006 10:54 CEST
======================================================================
Summary:                    Mic boost boosts mic playback and not recording
Description: 
I've tried to record my voice with broadcast2000. The recording level is at
-30db (maybe 2db louder than without mic boost) while mic playback seems
to be boosted up by 500% to an audiable level.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001192 Microphone doesn't work in record and/o...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-27-05 15:57 
----------------------------------------------------------------------
Try the patch in #1192.

----------------------------------------------------------------------
 Schugy - 09-16-05 00:01 
----------------------------------------------------------------------
Mic boost now works perfectly with ALSA that is included in linux 2.6.13.
Great job.
Thank you very much ;)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-04 13:51 Schugy         New Issue                                    
04-04-04 13:51 Schugy         Distribution              => SuSE 8.2        
04-04-04 13:51 Schugy         Kernel Version            => 2.4.25          
04-27-04 17:33 mlejeune       Note Added: 0000962                          
04-27-04 17:35 mlejeune       Issue Monitored: mlejeune                    
04-30-04 11:43 tiwai          Note Added: 0000982                          
05-23-04 19:45 Schugy         Note Added: 0001180                          
05-24-04 14:50 tiwai          Note Added: 0001183                          
07-24-04 19:47 thorstenhirsch Note Added: 0001471                          
04-07-05 00:12 jdthood        Status                   new => acknowledged 
04-07-05 00:12 jdthood        Resolution               open => not fixable 
04-07-05 06:25 charles_levert Note Added: 0004354                          
06-27-05 15:57 tiwai          Relationship added       related to 0001192  
06-27-05 15:57 tiwai          Note Added: 0005272                          
09-16-05 00:01 Schugy         Note Added: 0006231                          
07-28-06 10:54 Adrian Bunk    Status                   acknowledged => resolved
07-28-06 10:54 Adrian Bunk    Resolution               not fixable => fixed
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
