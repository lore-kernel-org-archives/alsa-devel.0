From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001411]: plug:jack interface not working for apps that both read and write
Date: Fri, 24 Mar 2006 05:49:38 +0100
Message-ID: <12be31158bea951939f6e987dedc2ff3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D6991AD
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 05:49:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1411> 
======================================================================
Reported By:                b0ef
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1411
Category:                   PCM - jack
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-10-2005 17:57 CEST
Last Modified:              03-24-2006 05:49 CET
======================================================================
Summary:                    plug:jack interface not working for apps that both
read and write
Description: 
This is a general problem with any app that both read and write to the
plug:jack device. It (plug:jack) however works for apps that only do one
or the other. 
======================================================================

----------------------------------------------------------------------
 b0ef - 09-10-05 18:11 
----------------------------------------------------------------------
I have applied the realtime patch to linux from
http://people.redhat.com/mingo/realtime-preempt/ but I've also tested
without and see the same problem

I'm running linux-2.6.13-rt4

ALSA apps that use both playback and capture fails to work with plug:jack

I have tested with several applications, primarily asterisk and kphone

I have not found any app that uses both playback and capture that works
with plug:jack. Normal playback and capture separate with plug:jack works
great.

----------------------------------------------------------------------
 Raymond - 03-24-06 05:49 
----------------------------------------------------------------------
arecord and aplay works concurrently with plug:jack

Do you alsa driver support full duplex ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-10-05 17:57 b0ef           New Issue                                    
09-10-05 18:11 b0ef           Note Added: 0006123                          
03-24-06 05:49 Raymond        Note Added: 0008912                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
