From: noreply@alsa-project.org
Subject: [ALSA - driver 0000170]: pcm.c:2344: snd_pcm_area_copy: Assertion `0' failed, usb-audio, edirol ua-5
Date: Fri, 16 Jul 2004 12:57:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105748.4BA1326009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9355C244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:57:48 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000170
======================================================================
Reported By:                bgolenko
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     170
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian testing/unstable
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-30-2004 15:40 CEST
Last Modified:              07-16-2004 12:57 CEST
======================================================================
Summary:                    pcm.c:2344: snd_pcm_area_copy: Assertion `0' failed, usb-audio, edirol ua-5
Description: 
Device Edirol UA-5 (USB)
configuration - recording, 24 bit, 96000Hz
Working correctly with arecord, but I want to have a
nice GUI ;)
I'm trying to setup snd-gtk-alsa (version 7.2-1). It is unable to work
with S24_3LE sample format natively, so I tried to setup a pcm plug to
convert it on the fly.

After selecting recording from the menu it shows a recording panel for a
moment and than crashes with the message
pcm.c:2344: snd_pcm_area_copy: Assertion `0' failed


======================================================================

----------------------------------------------------------------------
 bgolenko - 03-30-2004 15:43 CEST 
----------------------------------------------------------------------
I forgot to mention - same behaviour with the latest CVS sources

----------------------------------------------------------------------
 perex - 03-31-2004 16:29 CEST 
----------------------------------------------------------------------
Yes, it was bug in alsa-lib (unimplemented code for 24-bit samples). It's
fixed in CVS now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-30-04 15:40 bgolenko       New Bug                                      
03-30-04 15:40 bgolenko       Distribution              => Debian testing/unstable
03-30-04 15:40 bgolenko       Kernel Version            => 2.6.4           
03-30-04 15:43 bgolenko       Bugnote Added: 0000720                       
03-30-04 15:49 bgolenko       Bug Monitored: bgolenko                      
03-31-04 16:25 perex          Assigned To              Clemens Ladisch => perex
03-31-04 16:29 perex          Bugnote Added: 0000723                       
03-31-04 16:29 perex          Resolution               open => fixed       
03-31-04 16:29 perex          Status                   assigned => resolved
07-16-04 12:57 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
