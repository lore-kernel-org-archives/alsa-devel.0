From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000183]: Mic boost boosts mic playback and not recording
Date: Fri, 16 Sep 2005 00:01:10 +0200
Message-ID: <bb3e96b0956e69a2afb145a1ffd1f00f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 93F0E173
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 00:01:10 +0200 (MEST)
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
Status:                     acknowledged
Distribution:               SuSE 8.2
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-04-2004 13:51 CEST
Last Modified:              09-16-2005 00:01 CEST
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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
