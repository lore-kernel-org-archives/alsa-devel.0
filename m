From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000312]: MasterVolume & Headphone volume switched...
Date: Fri, 24 Sep 2004 13:31:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113131.D67919074@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3DFC4288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:31:32 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000312
======================================================================
Reported By:                subdude
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     312
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware Current
Kernel Version:             2.4.26
======================================================================
Date Submitted:             05-29-2004 11:11 CEST
Last Modified:              09-24-2004 13:31 CEST
======================================================================
Summary:                    MasterVolume & Headphone volume switched...
Description: 
The onboard sound chip is called a VIA 8233/8235.

I am running dxs_support=4

I have tried:

ac97_quirks=-1 thru 3 = no effect
======================================================================

----------------------------------------------------------------------
 subdude - 06-01-2004 07:19 CEST 
----------------------------------------------------------------------
The motherboard is an ECS L7VMM2 uATX with onboard VIA VT8375 Northbridge
and VT8235 Southbridge chipset.

The CPU is an AMD XP2400+ with 512 MByte 266 DDRAM.

The AGP X4 socket has a nVidia 64 MByte MX-440 gpu.

The sound chip is identified as a VIA 8233/8235.

Sound is excellent at dxs_support=4.

The ONLY problem is the Headphone Volume is really the Master Volume.

How do I fix????

----------------------------------------------------------------------
 tiwai - 06-30-2004 16:40 CEST 
----------------------------------------------------------------------
Please show the output of lspci -nv (for the entry of VIA823x only).

About the HP output - I guess you mistyped:
it's ac97_quirk (without 's').
Try ac97_quirk=1 or ac97_quirk=2.

----------------------------------------------------------------------
 subdude - 07-10-2004 04:39 CEST 
----------------------------------------------------------------------
Here is the output of 'lspci -nv' for 00:11.5 Multimedia audio controller:
VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50).

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1019:0a85
        Flags: medium devsel, IRQ 12
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2

What I meant by 'ac97_quirks=-1 thru 3' was I have tried the various
different combinations of 'ac97_quirk=-1' through to 'ac97_quirk=3', all
to no avail.

Here is my /etc/modules.conf for Slackware 10.0 custom kernel and alsa
driver 1.0.5a:

/ect/modules.conf
alias char-major-116 snd
alias snd-card-0 snd-via82xx

options snd-via82xx index=0 dxs_support=4
#options ac97_quirk=1
options ac97_quirk=2

alias char-major-14 soundcore
alias sound-slot-0 snd-card-0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias char-major-195 nvidia
#

I look forward to hearing from you.

Best regards,

Brian

----------------------------------------------------------------------
 tiwai - 07-15-2004 11:28 CEST 
----------------------------------------------------------------------
You need to _add_ ac97_quirk option to snd-via82xx line:

options snd-via82xx index=0 dxs_support=4 ac97_quirk=1

----------------------------------------------------------------------
 subdude - 07-28-2004 03:14 CEST 
----------------------------------------------------------------------
This did the trick:

options snd-via82xx index=0 dxs_support=4 ac97_quirk=1

Now the volume controls function as they should.

Thank you for your assistance.

I would hope that the documentation on this feature is improved - I
thought I had this covered.

Mission accomplished!

----------------------------------------------------------------------
 subdude - 07-28-2004 03:18 CEST 
----------------------------------------------------------------------
Reminder sent to tiwai

Thanks for your assistance!

Mission Accomplished!

ECS L7VMM2 motherboard requires this line in modules.conf to enable proper
'master volume' orientation.

Best regards,

Brian 

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:50 CEST 
----------------------------------------------------------------------
Ok, the workaround was added to CVS tree.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-29-04 11:11 subdude        New Bug                                      
05-29-04 11:11 subdude        Distribution              => Slackware Current
05-29-04 11:11 subdude        Kernel Version            => 2.4.26          
05-29-04 11:12 subdude        Bug Monitored: subdude                       
06-01-04 07:19 subdude        Bugnote Added: 0001288                       
06-30-04 16:40 tiwai          Bugnote Added: 0001359                       
07-10-04 04:39 subdude        Bugnote Added: 0001397                       
07-15-04 11:28 tiwai          Bugnote Added: 0001429                       
07-28-04 03:14 subdude        Bugnote Added: 0001480                       
07-28-04 03:18 subdude        Bug Monitored: tiwai                         
07-28-04 03:18 subdude        Bugnote Added: 0001481                       
07-30-04 16:50 tiwai          Bugnote Added: 0001490                       
07-30-04 16:50 tiwai          Assigned To               => tiwai           
07-30-04 16:50 tiwai          Resolution               open => fixed       
07-30-04 16:50 tiwai          Status                   new => resolved     
09-24-04 13:31 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
