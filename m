From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000472]: Built-in soundcard on Soltek SL-75DRV5 motherboard works only with ac97_quirk=0 option.
Date: Thu,  2 Sep 2004 12:45:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040902104522.E25D113002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E01B290
	for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2004 12:45:23 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000472
======================================================================
Reported By:                Dawid Gajownik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     472
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
======================================================================
Date Submitted:             08-29-2004 21:34 CEST
Last Modified:              09-02-2004 12:45 CEST
======================================================================
Summary:                    Built-in soundcard on Soltek SL-75DRV5 motherboard works only with ac97_quirk=0 option.
Description: 
Built-in soundcard on Soltek SL-75DRV5 motherboard works only with
ac97_quirk=0 option. This mobo has VIA VT8233A southbridge (snd-via82xx
ALSA kernel module).

Is there any possibility, that it would be set up automatically by the
alsa driver? (I'm not a programmer, but I've seen some ac97_quirk
structure in via82xx.c source file).
======================================================================

----------------------------------------------------------------------
 tiwai - 08-31-2004 13:36 CEST 
----------------------------------------------------------------------
The same PCI subsystem ID is already used for ASrock board, so
I don't see the solution, so far.

----------------------------------------------------------------------
 tiwai - 09-01-2004 22:49 CEST 
----------------------------------------------------------------------
Could you attach the output of /proc/asound/card0/codec97#0/* files?
It might be possible to distinguish two machines from the difference
of AC97 codec chips.

----------------------------------------------------------------------
 Dawid Gajownik - 09-02-2004 12:45 CEST 
----------------------------------------------------------------------
Sorry for misleading you. I noticed that this card also works with
ac97_quirk set to 2, 3 or 4.

When it's set to 2 <Line-Out> in alsamixer works as <Master> and Master
does not have any effect.

3 and 4 works the same (I think so) as 0. Channels in alsamixer also look
the same.

Then ac97_quirk is set to -1 or 1 there is no sound (in this states
alsamixer channels look the same).

I haven't tested recording (should I?). Does this option have any inluence
on it? And which value is better - 0, 3 or 4?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 21:34 Dawid Gajownik New Bug                                      
08-29-04 21:34 Dawid Gajownik Distribution              => Fedora Core 2   
08-29-04 21:34 Dawid Gajownik Kernel Version            => 2.6.8-1.521     
08-31-04 13:36 tiwai          Bugnote Added: 0001673                       
09-01-04 22:49 tiwai          Bugnote Added: 0001677                       
09-02-04 12:30 Dawid Gajownik File Added: ac97.txt                         
09-02-04 12:45 Dawid Gajownik Bugnote Added: 0001682                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
