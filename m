From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000392]: feature requests
Date: Wed, 10 Nov 2004 12:07:03 +0100
Message-ID: <41fe28feb29c1e43d93f7ff6147b91cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CA4A4241
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 12:07:03 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=392> 
======================================================================
Reported By:                gblack
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   392
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.4.25
======================================================================
Date Submitted:             07-16-2004 09:07 CEST
Last Modified:              11-10-2004 12:07 CET
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

----------------------------------------------------------------------
 gnif - 11-10-04 05:08 
----------------------------------------------------------------------
ummmm, duh, you cant add mixing support to a chip in your pc, research your
problem before posting that kind of crap. The soundblaster does hardware
mixing, software mixing has to be configured by you, it is not for the
driver to handle. Alsa has plenty of support for software mixing, you need
to go and read the documentation.

----------------------------------------------------------------------
 tiwai - 11-10-04 12:07 
----------------------------------------------------------------------
1 is not implemented yet.  This is likely a hardware dependent (i.e. laptop
model specific), but it should be doable.

3 is already implemented.  You can change via the mixer interface.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-04 09:07 gblack         New Issue                                    
07-16-04 09:07 gblack         Distribution              => Gentoo          
07-16-04 09:07 gblack         Kernel Version            => 2.4.25          
11-10-04 05:08 gnif           Note Added: 0002357                          
11-10-04 12:07 tiwai          Note Added: 0002362                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
