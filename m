From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation
	for ati-ixp chipset.
Date: Sun, 28 May 2006 04:51:10 +0200
Message-ID: <225f99905a4427d3febf28cb68e7b1c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5CD7C171
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 04:51:10 +0200 (MEST)
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
Last Modified:              05-28-2006 04:51 CEST
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
 rlrevell - 05-28-06 04:24 
----------------------------------------------------------------------
If you are using alsa-lib 1.0.11 it should be using dmix and dsnoop by
default.

----------------------------------------------------------------------
 Gene Heskett - 05-28-06 04:51 
----------------------------------------------------------------------
>From 0009987, a VU meter appears, its a text meter, not a gui, so i guess I
miss-understood.

>From 0009988, my current /root/.asoundrc:
pcm.atiixp {
     type hw
     card 0
}

ctl.atiixp {
     type hw
     card 0
}
pcm.!default {
        type hw
        card 0
}

ctl.!default {
        type hw
        card 0
}

Do I add the stuff in 009988, or replace this with that, what?

>From 0009989, it would appear that alsalib is 1.0.11-3-rc2.2 (FC5 rpm) 
The kernel is 2.6.16-1.2122_FC5.   This appears to be the latest versions
of the alsalib and company available for FC5.

Am I going to have to see if I can recall howto configure checkinstall for
defaulting to rpm production again in order to install 1.0.11 final?

-- 
Cherrs, Gene

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
05-28-06 03:58 Raymond        Note Added: 0009988                          
05-28-06 04:04 Raymond        Note Edited: 0009988                         
05-28-06 04:05 Raymond        Note Edited: 0009988                         
05-28-06 04:24 rlrevell       Note Added: 0009989                          
05-28-06 04:51 Gene Heskett   Note Added: 0009990                          
======================================================================
