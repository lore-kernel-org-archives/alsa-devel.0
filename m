From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation
	for ati-ixp chipset.
Date: Mon, 29 May 2006 21:24:01 +0200
Message-ID: <e00ebd07d305e556fab7d27db5abbd31@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26CF7152
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 21:24:02 +0200 (MEST)
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
Last Modified:              05-29-2006 21:24 CEST
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
 Gene Heskett - 05-29-06 15:55 
----------------------------------------------------------------------
But thats not how I'd interpret what was returned from the application of
the -v option as I showed many notes above this one now.  If that output
is wrong, then please say so, and show specifically, including the name of
the file to fix, how to go about fixing it.

The posting of the contents of a config file as you did, without any clues
as to this files actual identity, is not helpfull and only serves to
confuse the user.

-- 
Cheers, Gene

----------------------------------------------------------------------
 sprocketboy - 05-29-06 21:24 
----------------------------------------------------------------------
This is a "me too" type of post, but maybe I can add some more useful
information.

I have tried to record while playing (overdub) in audacity as well, and
have never gotten it to work.  The default audacity-1.2.3 RPM for Mandriva
is compiled with the portaudio=v18 flag set, which means that audacity
looks for an OSS driver, or in the case of ALSA, an OSS emulator.  I have
tried compiling both the stable audacity-1.2.3 and the beta 1.3.0 versions
with the portaudio=v19 flag set.  In both cases, the "ALSA ATI IXP" driver
appears as a device selection in audacity's "Preferences" dialog, but if I
select the ALSA driver for input and output and try to record, audacity
locks up the kernel.

Here is the relevant output for 'lspci -v' on my system.  I am using the
Mandriva kernel 2.6.12-22mdk, custom compiled with support for SMP, 4GB
himem, hyperthreading (I have a dual-core processor on a Toshiba laptop),
and pre-emptible kernel.  Do any of those settings break the ati-ixp
driver?

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97
Audio Controller (rev 01)
        Subsystem: Toshiba America Info Systems: Unknown device ff01
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 17
        Memory at e8004400 (32-bit, non-prefetchable) [size=256]

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
05-29-06 14:56 Raymond        Note Edited: 0010005                         
05-29-06 15:34 Raymond        Note Added: 0010011                          
05-29-06 15:55 Gene Heskett   Note Added: 0010012                          
05-29-06 21:16 sprocketboy    Issue Monitored: sprocketboy                    
05-29-06 21:24 sprocketboy    Note Added: 0010013                          
======================================================================
