From: noreply@alsa-project.org
Subject: [ALSA - driver 0000134]: Can not hear cd audio  from players that read cd audio from the sound card
Date: Fri, 16 Jul 2004 12:47:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104758.B29CE26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 173E8255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:47:59 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000134
======================================================================
Reported By:                5555555
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     134
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Slackware 9.1
Kernel Version:             2.4.22
======================================================================
Date Submitted:             03-15-2004 08:35 CET
Last Modified:              07-16-2004 12:47 CEST
======================================================================
Summary:                    Can not hear cd audio  from players that read cd audio from the sound card
Description: 
Compiling and installing alsa driver 1.0.3, utils, lib, oss-lib prevents cd
audio from being heard in cd players such as gnome-cd, mcd.  Players that
read audio cds direcrtly the sound card can play audio cds i.e. gxine.
======================================================================

----------------------------------------------------------------------
 perex - 03-15-2004 12:23 CET 
----------------------------------------------------------------------
Try use 'alsamixer' and unmute input channels. Also set the proper volume.
We renamed some controls, so it might be problem with the OSS mixer
emulation
only.

----------------------------------------------------------------------
 alex - 03-17-2004 21:43 CET 
----------------------------------------------------------------------
No, actually this is a signal routing bug - I noticed it 
when upgrading from Kernel 2.6.1 to 2.6.4 (I'm using the 
ALSA included with 2.6.x). While PCM-out works flawlessy
Line IN is silent with 2.6.4 - rebooting to 2.6.1 makes 
it work again. I'm using the same mixer settings so this
shouldn't be the issue here.

I'm using a
00:0d.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs SB0090 Audigy Player
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at dc00 [size=32]

Any more usefuly data I can provide?

----------------------------------------------------------------------
 alex - 03-19-2004 00:07 CET 
----------------------------------------------------------------------
I was wrong - it is indeed a mixer issue - The Line IN has no effect unless
"Analog Mix" is enabled, too - I have no idea whether this control was
available in 2.6.1, too (this card has way too many controls ;), if so it
wasn't necessary back then. So, from my point of view this is resolved.

edited on: 03-19-04 00:07

----------------------------------------------------------------------
 perex - 03-20-2004 10:54 CET 
----------------------------------------------------------------------
Mixer settings.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-15-04 08:35 5555555        New Bug                                      
03-15-04 08:35 5555555        Distribution              => Slackware 9.1   
03-15-04 08:35 5555555        Kernel Version            => 2.4.22          
03-15-04 12:23 perex          Bugnote Added: 0000611                       
03-17-04 21:43 alex           Bugnote Added: 0000636                       
03-19-04 00:04 alex           Bugnote Added: 0000644                       
03-19-04 00:07 alex           Bugnote Edited: 0000644                      
03-20-04 10:54 perex          Bugnote Added: 0000646                       
03-20-04 10:54 perex          Assigned To               => perex           
03-20-04 10:54 perex          Resolution               open => fixed       
03-20-04 10:54 perex          Status                   new => resolved     
07-16-04 12:47 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
