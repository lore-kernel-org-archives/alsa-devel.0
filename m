From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000413]: snd_atiixp_modem doesn't work
Date: Fri, 24 Sep 2004 13:39:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113954.4AD3A101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 99127288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:39:54 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000413
======================================================================
Reported By:                ronis
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     413
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-29-2004 19:28 CEST
Last Modified:              09-24-2004 13:39 CEST
======================================================================
Summary:                    snd_atiixp_modem doesn't work
Description: 
I install snd_atiixp and then snd_atiixp_modem.  Aplay shows
two cards, card 0 the sound card, card 1 the modem.
Sound works.

I use slmodem-2.9.9 to create a modem device, and I can connect to it (I
use kermit).  ath0 ati commands work.

However when I try to dial out I get: ERROR/NO CARRIER.

I've pasted some of the log below.

I am aware of the eariler Bug/Feature Request  0000259
and tried the asoundrc file given there.  Parts of it generated errors,
and even when the offending sections were removed I get the same behavior

Currently my .asoundrc file contains:

pcm.atiixp {
        type hw
        card 0
}

ctl.atiixp {
        type hw
        card 0
}


I used to have a declaration for card1 but it didn't seem to matter.



======================================================================

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:43 CEST 
----------------------------------------------------------------------
You need to use 'modem' PCM name (included in the recent version of
alsa-lib) so that alsa-lib can do the channel conversion.

----------------------------------------------------------------------
 ronis - 07-30-2004 19:36 CEST 
----------------------------------------------------------------------
Use it where?  In .asoundrc?   

I presume you mean something like

pcm.modem {
        modem PCM atiixp_modem
        card 1
}

edited on: 07-30-04 19:36

----------------------------------------------------------------------
 tiwai - 07-30-2004 20:36 CEST 
----------------------------------------------------------------------
No, it's included in alsa-lib pakcage.  You don't have to
write your own .asoundrc.

----------------------------------------------------------------------
 ronis - 07-30-2004 21:07 CEST 
----------------------------------------------------------------------
I'm using a CVS versions of alsa-lib so I guess it should be here.

This is what aplay -l shows:

card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 1/1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000: subdevice https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000
card 1: Modem [ATI IXP Modem], device 0: ATI IXP MC97 [ATI IXP MC97]
  Subdevices: 1/1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000: subdevice https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000

I guess I didn't understand your first suggestion.   I've tried passing 

--alsa modem 
--alsa modem.pcm.1

as options to slmodemd, but neither seems to work (it keeps saying that it
opens hw:1)

----------------------------------------------------------------------
 ronis - 08-01-2004 05:56 CEST 
----------------------------------------------------------------------
OK I think I've made some progress.  It turns out that slmodemd-2.9.9
ignores the
device setting if --alsa is given (well actually it doesn't, it changes
the device name to what is given on the command line, and then forgets
that it did and resets it to hw:1 no matter what).  I added a test to see
if it had been changed from the default value, and if so, left it.  I can
now select the device.  

Bascially I use the command:  

slmodemd --alsa modem:1  which works!

Thanks for your help.

----------------------------------------------------------------------
 tiwai - 08-02-2004 18:23 CEST 
----------------------------------------------------------------------
Ok, closing this bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-29-04 19:28 ronis          New Bug                                      
07-30-04 16:43 tiwai          Bugnote Added: 0001486                       
07-30-04 19:35 ronis          Bugnote Added: 0001505                       
07-30-04 19:36 ronis          Bugnote Edited: 0001505                      
07-30-04 19:36 ronis          Bugnote Edited: 0001505                      
07-30-04 20:36 tiwai          Bugnote Added: 0001506                       
07-30-04 21:07 ronis          Bugnote Added: 0001507                       
08-01-04 05:56 ronis          Bugnote Added: 0001511                       
08-02-04 18:23 tiwai          Bugnote Added: 0001524                       
08-02-04 18:23 tiwai          Resolution               open => fixed       
08-02-04 18:23 tiwai          Status                   assigned => resolved
09-24-04 13:39 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
