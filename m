From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation
	for ati-ixp chipset.
Date: Mon, 29 May 2006 11:41:37 +0200
Message-ID: <315fafb40b835e4ab236e87ef674ffc8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8F4616B
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 11:41:37 +0200 (MEST)
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
Last Modified:              05-29-2006 11:41 CEST
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
 Gene Heskett - 05-29-06 04:24 
----------------------------------------------------------------------
but we're stuck with whats in this lappy, with only the bare minimum of
actual 'bondouts' available.

It seems to me that a software layer doing the mixing could be written
that does present a uniform, chipset independent interface that the apps,
oss or alsa, could not tell from the actual hardware.  Any mutually
exclusive locks should be converted into virtual locks that exist only for
that individual software port being accessed.  All mixing should take
place beyond that point.

In the case of this ATI-IXP chipset then, exactly how is this being done? 
As in does there exist a block diagram of how this is actually  done?

I'm also having trouble with the concept that the major (except for closed
src skype) audio apps for linux are still dependent on the oss interface 3
years after alsa became the default linux audio system. That boggles the
mind given the obviously improved interfaces now presented to the
user/coder by alsa with 1.0.11, and which I can only see improving with
additional time.

The bottom line to me is that I think I have a reasonable expectation of
these 'major' applications all Just working(TM), if not now then not too
far into the future.

-- 
Cheers, Gene

----------------------------------------------------------------------
 Raymond - 05-29-06 11:41 
----------------------------------------------------------------------
It is because audacity support multi-channel capture (up to 16 channels)
and it must open "hw" device in order to check whether the sound card
support this feature.

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
05-28-06 05:10 rlrevell       Note Added: 0009991                          
05-28-06 05:27 Gene Heskett   Note Added: 0009992                          
05-28-06 05:34 rlrevell       Note Added: 0009993                          
05-28-06 05:37 Gene Heskett   Note Added: 0009994                          
05-28-06 06:13 rlrevell       Note Added: 0009995                          
05-28-06 06:29 Gene Heskett   Note Added: 0009998                          
05-28-06 06:35 rlrevell       Note Added: 0009999                          
05-28-06 08:22 Raymond        Note Added: 0010000                          
05-28-06 08:32 Raymond        Note Added: 0010001                          
05-28-06 13:17 Gene Heskett   Note Added: 0010002                          
05-29-06 03:13 Raymond        Note Added: 0010005                          
05-29-06 04:24 Gene Heskett   Note Added: 0010006                          
05-29-06 11:41 Raymond        Note Added: 0010010                          
======================================================================
