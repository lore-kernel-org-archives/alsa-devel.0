From: noreply@alsa-project.org
Subject: [ALSA - driver 0000264]: Can not set recording source & twick line in volume
Date: Fri, 16 Jul 2004 12:41:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104155.29EBB26009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 657B6255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:41:55 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000264
======================================================================
Reported By:                teras
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     264
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable
Kernel Version:             2.6.2
======================================================================
Date Submitted:             05-08-2004 21:28 CEST
Last Modified:              07-16-2004 12:41 CEST
======================================================================
Summary:                    Can not set recording source & twick line in volume
Description: 
This problem is strange, because it does not appear in stock kernel 2.6.2
but it started to appear in later kernels, 2.6.3 up to 2.6.5 (and also in
alsa driver 1.0.4).

I am using both my PCI SB Audigy card and my on-board Intel AC'97
controller, with the modules snd-emu10k1 and snd-intel8x0. The onboard
card is wired to the line in of the SB card. WIth kernel 2.6.2 everything
works fine. I can hear the sound of the intel card through the SB card and
also increase/decrease the line in volume of the SB card.

On later kernels, as well as alsa 1.0.4 I can not longer see the selection
of the "record source" for the SB, in ANY mixer. Moreover the default
input is the microphone (which is something I don't want to. The selection
of the "recording source" for the intel card does appear.

Also the volume slider for the microphone does not work. No matter what I
do, the volume remain constant. Of course I can controll it with other
means, but this is not the point.
======================================================================

----------------------------------------------------------------------
 teras - 06-13-2004 13:11 CEST 
----------------------------------------------------------------------
Just for reference, this is the lspci for this card:

0000:02:04.0 Multimedia audio controller: Creative Labs SB Audigy (rev
03)

or (in -n mode)
0000:02:04.0 Class 0401: 1102:0004 (rev 03)

----------------------------------------------------------------------
 pzad - 06-14-2004 08:38 CEST 
----------------------------------------------------------------------
And for what you need to set capture source ????
You only need to set capture volume.

If you want capture from analog sources (Line In, CD, Aux) set Analog Mix
Capture Volume
If you dont want hear Line In while capture set Analog Mix Playback Volume
to 0

There are 2 Mic controls
Mic Playback Volume - controls playback volume
Mic Capture Volume - controls capture volume

----------------------------------------------------------------------
 teras - 06-18-2004 11:52 CEST 
----------------------------------------------------------------------
OK, now it works, the way you told me. Still it's strange that these
controls are not marked as "input" or something like that.

So, let's say it's not a bug, but a feature :P

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-08-04 21:28 teras          New Bug                                      
05-08-04 21:28 teras          Distribution              => Debian unstable 
05-08-04 21:28 teras          Kernel Version            => 2.6.2           
05-09-04 12:40 teras          Bug Monitored: teras                         
06-13-04 13:11 teras          Bugnote Added: 0001304                       
06-14-04 08:38 pzad           Bugnote Added: 0001307                       
06-18-04 11:52 teras          Bugnote Added: 0001318                       
06-22-04 14:50 tiwai          Assigned To               => tiwai           
06-22-04 14:50 tiwai          Resolution               open => not a bug   
06-22-04 14:50 tiwai          Status                   new => resolved     
07-16-04 12:41 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
