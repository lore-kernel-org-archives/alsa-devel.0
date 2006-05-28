From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation
	for ati-ixp chipset.
Date: Sun, 28 May 2006 03:22:18 +0200
Message-ID: <982c14448d1da251f25d87e61d14d001@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 91C80171
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 03:22:18 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2147> 
======================================================================
Reported By:                Gene Heskett
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2147
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               FC5, uptodate
Kernel Version:             2.6.16-1.2111_FC5
======================================================================
Date Submitted:             05-23-2006 03:52 CEST
Last Modified:              05-28-2006 03:22 CEST
======================================================================
Summary:                    lack of full duplex operation for ati-ixp chipset.
Description: 
skype, ekiga, audacity, and generally any program that needs to both
transmit and receive, using isolated paths, fails in playback when
recording.  In skype, I sound great at the far end, but reception may or
may not work, with emphasis on the not.  What I hear in the phones, or in
the speakers, sounds like what you would get if you took a sentence of
spoken words, break it up into say 5ms pieces, and play them at maybe 10
of these little snippets per second, so that the resultant sound is broken
up to the point of no comprehension, and stretched in time by a
considerable amount.

In audacity, simultanious playback, or play one track while recording
another, likewise fails in that only very short snippets of the played
track are output to the phones or speakers.

Likewise, ekiga suffers from this same effect, I'm told I sound great on
teh other end, but I can't hear more than half a word occasionally.
======================================================================

----------------------------------------------------------------------
 Gene Heskett - 05-28-06 03:20 
----------------------------------------------------------------------
I'm sorry, that added note got badly hacked and parts of it will not make a
lot of sense.  This lappy has a touch pad that I cannot seem to disable,
and if a thumb gets too close to it (it doesn't have to actually touch the
sonofabitch), it will jump to someplace else on the screen and highlight a
few lines of text, which will of course be deleted on the next keystroke.

Its such a pain in the ass that I'm tempted to go get a usb keyboard and
see if I can make it work because this is frustrating in the maximus.

That however has little or nothing to do with my audio problem, and thats
a lack of full duplex operation IN THE REAL WORLD...

-- 
Cheers, Gene

----------------------------------------------------------------------
 rlrevell - 05-28-06 03:22 
----------------------------------------------------------------------
"So that, according to your judgement, means its working. So why can't I
make it work in the real world? For skype or ekiga."

Because skype, audacity, and ekiga are OSS apps, and OSS apps block
everything else from using the soundcard.  It might be possible to solve
this eventually but it's difficult.  It's much easier if those apps simply
add ALSA support...

"FWIW, when I start arecord, I get this on the terminal screen but no
volume control appears:"

I'm not sure what you mean by "no volume control appears".  Where are you
expecting it to appear?

ALSA does not have a volume control per PCM instance - unless the app
implements its own software volume control, there is only the global
volume control in alsamixer.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:52 Gene Heskett   New Issue                                    
05-23-06 03:52 Gene Heskett   Distribution              => FC5, uptodate   
05-23-06 03:52 Gene Heskett   Kernel Version            => 2.6.16-1.2111_FC5
05-23-06 15:01 tiwai          Note Added: 0009934                          
05-23-06 16:46 Gene Heskett   Note Added: 0009938                          
05-23-06 17:24 tiwai          Note Added: 0009941                          
05-23-06 18:07 Gene Heskett   Note Added: 0009943                          
05-23-06 19:14 tiwai          Note Added: 0009947                          
05-28-06 03:08 Gene Heskett   Note Added: 0009985                          
05-28-06 03:20 Gene Heskett   Note Added: 0009986                          
05-28-06 03:22 rlrevell       Note Added: 0009987                          
======================================================================
