From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000435]: No current support for the ICH6R & ALC880 devices
Date: Mon, 23 Aug 2004 06:33:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040823043347.634B41102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8B972BB
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 06:33:47 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000435
======================================================================
Reported By:                snaketails
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     435
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-12-2004 02:50 CEST
Last Modified:              08-23-2004 06:33 CEST
======================================================================
Summary:                    No current support for the ICH6R & ALC880 devices
Description: 
As this is a new mobo, there is no driver configuration that supports this
newer buss interface devices, so there is no sound from the mobo.
The inability for the mobo to run SATA under Linux is not an issue here,
as I am using the SiS SATA driver, only issue is sound
======================================================================

----------------------------------------------------------------------
 pzad - 08-12-2004 07:32 CEST 
----------------------------------------------------------------------
I think in ALSA 1.0.6rc2 is driver for HD audio (azx module). Try it.

----------------------------------------------------------------------
 snaketails - 08-13-2004 02:03 CEST 
----------------------------------------------------------------------
Thank you, but I am currently using "Compiled-in" ALSA support.
I guess I will have to remove the Alsa support from the Kernel to be able
to compile? I may look at doing this, this weekend.

----------------------------------------------------------------------
 snaketails - 08-16-2004 06:01 CEST 
----------------------------------------------------------------------
I recompiled the kernel to allow me to compile the azx module as
suggested.
I found I had to change the audio out plug to another location on the rear
of my system, but the sound is crackly??
But, at least I do have sound output, and the crackles are only a slight
annoyance.
I only have controls for "Master" and "Capture", nothing more.

----------------------------------------------------------------------
 snaketails - 08-18-2004 04:28 CEST 
----------------------------------------------------------------------
Ok, I have the driver installed

the sound is working, but I have crackles, whistles and pops only when
there is talking or audio above a certain level, it seems there is some
kind of feedback that is happening as when it does get louder I get more
and more echo and reverberation in the soundstream, would this be related
to the drived being in its infancy stages?

----------------------------------------------------------------------
 tiwai - 08-18-2004 11:53 CEST 
----------------------------------------------------------------------
I guess yes, the driver is still in the test stage.
The mixer code is pretty primitive yet.

----------------------------------------------------------------------
 snaketails - 08-23-2004 06:33 CEST 
----------------------------------------------------------------------
Is there any way I could help with this driver?

I will test any mods that have been done, unfortunatly I guess I don't
know enough about doing C programming (only what I did for school in the
late '80s)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-12-04 02:50 snaketails     New Bug                                      
08-12-04 02:50 snaketails     Distribution              => Gentoo          
08-12-04 02:50 snaketails     Kernel Version            => 2.6.7           
08-12-04 07:32 pzad           Bugnote Added: 0001551                       
08-13-04 02:03 snaketails     Bugnote Added: 0001560                       
08-16-04 06:01 snaketails     Bugnote Added: 0001569                       
08-18-04 04:28 snaketails     Bugnote Added: 0001575                       
08-18-04 11:53 tiwai          Bugnote Added: 0001576                       
08-23-04 06:33 snaketails     Bugnote Added: 0001610                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
