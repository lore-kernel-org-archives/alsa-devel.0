From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001078]: intel8x0 does not work on any (?) 2.6 kernel
Date: Fri, 6 May 2005 09:13:44 +0200
Message-ID: <6ccc3570b65551f059cfa75a67eaee57@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4CD661E6
	for <alsa-devel@alsa-project.org>; Fri,  6 May 2005 09:13:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1078> 
======================================================================
Reported By:                columbo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1078
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware Linux 10.1
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-26-2005 21:29 CEST
Last Modified:              05-06-2005 09:13 CEST
======================================================================
Summary:                    intel8x0 does not work on any (?) 2.6 kernel
Description: 
After compilation of ALSA drivers, libs, utilities, and after alsaconf ALSA
modules loads correctly, they are visible in lsmod and so on, but all
programs can't see sound card, /dev/dsp and so on. With kernels 2.4.x
everything is OK.
======================================================================

----------------------------------------------------------------------
 pzad - 05-06-05 09:00 
----------------------------------------------------------------------
When you you do 

modprobe -r snd-intel8x0m
modprobe -r snd-intel8x0
modprobe snd-intel8x0

sound should work again.
Do not load snd-intel8x0m module !!!!

----------------------------------------------------------------------
 gem7 - 05-06-05 09:13 
----------------------------------------------------------------------
>Do not use snd-intel8x0m. This is source of your problems. If you load 
> snd-intel8x0m then it will stop your soundcard. Your modem will not work
with it >anyway.

Read my note again.  I already mentioned that I added intel8x0m to my
blacklist and already deleted that module.

Just to be sure I just tried your modprobe remove/add and no change.

RGAD
GARY

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-05 21:29 columbo        New Issue                                    
04-26-05 21:29 columbo        Distribution              => Slackware Linux 10.1
04-26-05 21:29 columbo        Kernel Version            => 2.6.11.7        
04-29-05 21:06 columbo        Issue Monitored: columbo                     
05-06-05 08:50 gem7           Note Added: 0004590                          
05-06-05 08:59 pzad           Note Added: 0004591                          
05-06-05 09:00 pzad           Note Added: 0004592                          
05-06-05 09:13 gem7           Note Added: 0004593                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
