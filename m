From: noreply@alsa-project.org
Subject: [ALSA - driver 0000392]: feature requests
Date: Fri, 16 Jul 2004 09:07:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716070708.7D35625009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CEC62260
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 09:07:08 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 8D1881258C
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 09:07:08 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000392
======================================================================
Reported By:                gblack
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     392
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.4.25
======================================================================
Date Submitted:             07-16-2004 09:07 CEST
Last Modified:              07-16-2004 09:07 CEST
======================================================================
Summary:                    feature requests
Description: 
I'm not sure if this is the right place to post this, but there are several
features that my integrated audio has that don't seem to be supported by
the alsa driver. My sound chip is the Sigmatel STAC9758 running under an
intel chipset.

1. When headphones are plugged into the headphone jack, the built in
speakers don't turn off, which they do under that other OS.

2. I've done some research into being able to play several sounds
simultaneously, and found that this can either be done in hardware on the
soundcard, or in software. On my desktop (also gentoo), which has a
soundblaster, I didn't need to configure anything special to get mixing,
and on my laptop I did. From that, I think that there isn't support for
hardware mixing in the intel8x0 driver, and I would like to request that
it be added, please.

3. I don't know if this should be done through alsa or not, but the output
jacks on my laptop are supposed to be configurable to provide different
functions, ie 5 channel surround, or stereo, mic, and headphones, etc. If
this can be done through alsa or another program, please let me know.

I'd like to try to help fix these problems, but I don't know much about
sound cards, and even less about kernel drivers. If you could suggest a
good starting point, that would also be appreciated.

A discussion about getting the sound to work, as well as other issues with
this laptop, can be found at:
http://www.linuxquestions.org/questions/history/145832

Thanks!
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-16-04 09:07 gblack         New Bug                                      
07-16-04 09:07 gblack         Distribution              => Gentoo          
07-16-04 09:07 gblack         Kernel Version            => 2.4.25          
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
