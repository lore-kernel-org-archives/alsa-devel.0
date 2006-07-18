From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001504]: Swap Front/Rear Output on
	SBLive! 5.1
Date: Tue, 18 Jul 2006 14:44:01 +0200
Message-ID: <c7fb07826d00ef3ad22260f256bd89bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 904AD176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:44:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1504> 
======================================================================
Reported By:                ripps818
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1504
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             10-25-2005 23:58 CEST
Last Modified:              07-18-2006 14:43 CEST
======================================================================
Summary:                    Swap Front/Rear Output on SBLive! 5.1
Description: 
I want to know if it's possible to make my rear output my primary master
output for my soundcard. I use KxDriver in Windows and I want to be able
to keep my setup working in linux as well. I don't too much about
programming and the driver's archetecture, but it seems like it wouldn't
be too complicated to fix.
======================================================================

----------------------------------------------------------------------
 mikma - 10-31-05 01:27 
----------------------------------------------------------------------
It's easy to swap the front and rear pcm channels, but Line-in, CD etc will
still be routed to the front output, unless you change the DSP programming
by modifing the emu10k1 driver or using ld10k1.

Add the following to your ~/.asoundrc :
#Swap front<->rear pcm channels
pcm.!front {
	type plug
	slave.pcm "cards.pcm.rear"
}

pcm.!rear {
	type plug
	slave.pcm "cards.pcm.front"
}

/Mikael



----------------------------------------------------------------------
 ripps818 - 10-31-05 04:45 
----------------------------------------------------------------------
will that allow "Master" to control my sound now?

----------------------------------------------------------------------
 rlrevell - 10-31-05 07:56 
----------------------------------------------------------------------
No, why would it?  Master controls the front speakers.  That's a completely
separate issue.

----------------------------------------------------------------------
 ripps818 - 10-31-05 21:10 
----------------------------------------------------------------------
How about ld10k1 that mikma mentioned. Is there anywhere where I can get
some more information on it? I've looked, and I haven't found alot of
helpful information on it.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 23:58 ripps818       New Issue                                    
10-25-05 23:58 ripps818       Kernel Version            => 2.6.13          
10-25-05 23:58 ripps818       Issue Monitored: ripps818                    
10-31-05 01:26 mikma          Note Added: 0006579                          
10-31-05 01:27 mikma          Note Edited: 0006579                         
10-31-05 04:45 ripps818       Note Added: 0006581                          
10-31-05 07:56 rlrevell       Note Added: 0006585                          
10-31-05 21:09 ripps818       Note Added: 0006590                          
10-31-05 21:10 ripps818       Note Edited: 0006590                         
07-18-06 14:43 jcdutton       Status                   new => assigned     
07-18-06 14:43 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
