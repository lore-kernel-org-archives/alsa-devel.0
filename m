From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000383]: Audigy LS - Capturing from Mic and kernel oops
Date: Fri, 27 Aug 2004 20:14:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827181448.44B7F2C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 85E811EF
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 20:14:48 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000383
======================================================================
Reported By:                Luke
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     383
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             07-13-2004 17:45 CEST
Last Modified:              08-27-2004 20:14 CEST
======================================================================
Summary:                    Audigy LS - Capturing from Mic and kernel oops
Description: 
I just updated my cvs repository and rebuilt the snd_audigyls module to
check if my former reported bugs are fixed.
Unfortunateley, my kernel oopsed once again.

I tried to capture some voice of my mic with no success. Maybe I don't get
the explanation in the cvs log. I attached a screenshot to review my
alsamixer settings. This is what I used to configure it:

"The MIC and LINE IN use the AC97 chip.

The AC97 uses the PLAYBACK(Not CAPTURE) controls in alsamixer for
controlling CAPTURE. Then, instead of sending that output to the
speakers, it sends it to the Philips 1361T ADC. This results in high
quality ADC conversion.
E.g. For LINE IN capture, set LINE IN playback volume and unmute it.
Set MASTER volume.
There is a new control for "CAPTURE feedback into PLAYBACK". If one does
not want any feedback, leave it at it's minimum."
======================================================================

----------------------------------------------------------------------
 jcdutton - 07-13-2004 19:40 CEST 
----------------------------------------------------------------------
Fixed in latest cvs.
Fixed by:
[alsa-cvslog] CVS: alsa-kernel/core memalloc.c,1.34,1.35

----------------------------------------------------------------------
 Luke - 07-14-2004 00:13 CEST 
----------------------------------------------------------------------
Nice one!
Works like a charm now!!! *wohoo*
Thx for your quick support and double-thumbs-up!

----------------------------------------------------------------------
 jcdutton - 08-27-2004 20:14 CEST 
----------------------------------------------------------------------
Fixed in cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 17:45 Luke           New Bug                                      
07-13-04 17:45 Luke           File Added: audigyoops                       
07-13-04 17:50 Luke           File Added: audigyscreen.png                    
07-13-04 19:40 jcdutton       Bugnote Added: 0001415                       
07-14-04 00:13 Luke           Bugnote Added: 0001416                       
08-27-04 20:14 jcdutton       Bugnote Added: 0001651                       
08-27-04 20:14 jcdutton       Resolution               open => fixed       
08-27-04 20:14 jcdutton       Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
