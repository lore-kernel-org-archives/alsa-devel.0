From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000338]: intel8x0 driver is not able to find sound card
Date: Fri, 8 Jul 2005 10:38:11 +0200
Message-ID: <0abe34d394636e85bb60189ee1f5dd62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00B911A9
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:11 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=338> 
======================================================================
Reported By:                jrh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   338
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.6 (vanilla)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-17-2004 17:55 CEST
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    intel8x0 driver is not able to find sound card
Description: 
Hi folks, 

  I've been using the intel8x0 alsa driver since kernel 2.6 without any
problems upto kernel 2.6.5 (compile from vanilla). However, since 2.6.6
and 2.6.7 came out I'm not able to listen to any audio as the driver does
not seem to recognice my card. I've made NO changes to the configuration
files of the kernel and to any other setup. Simple start 2.6.5 alsa works,
reboot with 2.6.6/7 and sound is not working.

 The modules are loaded (same modules). "alsaconf" (1.0.5) reports the
right card and loads it but for instance "alsactl restore" fails...


======================================================================

----------------------------------------------------------------------
 jrh - 07-30-04 17:13 
----------------------------------------------------------------------
Hi again,

  First of all, thanks tiwai for your time helping me find this problem. 

I've check all this again and it actually seems to be two mixed bugs.
First of all I've check my windows partition and I've seen that modem and
sound card also shared the same IRQ so as you said that shouldn't be the
problem :-(

Anyways, I've tried all possible configurations in the bios (enabling
modem, infrared, parallel port, etc.) in order to check what was happening
and it seems the parallel port is causing the trouble:

- All enabled: Soundcard is *not* detected (output from
/proc/asound/cards) shows no soundcard 

- Parallel port disabled: Soundcard is detected only if (here comes what
looks the second bug) snd_intel8x0 is loaded *before* snd_intel8x0m.
Otherwise no sound.

So now I can decide between listening to music or using the printer :-) 

What do you think it may be the problem?

----------------------------------------------------------------------
 tiwai - 07-30-04 17:51 
----------------------------------------------------------------------
There was a problem regarding the probing of chips between
intel8x0 modem and audio drivers.  I fixed it yesterday on CVS.

Please try CVS version or wait for 1.0.6-rc release.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-04 17:55 jrh            New Issue                                    
06-17-04 17:55 jrh            Kernel Version            => 2.6.6 (vanilla) 
06-18-04 08:58 jrh            Issue Monitored: jrh                         
06-30-04 16:46 tiwai          Note Added: 0001361                          
07-29-04 11:17 jrh            Note Added: 0001483                          
07-30-04 16:49 tiwai          Note Added: 0001489                          
07-30-04 17:13 jrh            Note Added: 0001497                          
07-30-04 17:51 tiwai          Note Added: 0001504                          
04-08-05 22:33 jdthood        Status                   new => resolved     
04-08-05 22:33 jdthood        Resolution               open => fixed       
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
