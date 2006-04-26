From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002077]: emu10k1 will not use S24_LE
Date: Wed, 26 Apr 2006 22:20:52 +0200
Message-ID: <b0bba165869dbf9d5f1e82a50c269c76@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F22F165
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 22:20:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2077> 
======================================================================
Reported By:                braininajar
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2077
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-26-2006 21:51 CEST
Last Modified:              04-26-2006 22:20 CEST
======================================================================
Summary:                    emu10k1 will not use S24_LE
Description: 
The Audigy2 is a 24-bit, 96k card. It will handle 24 bit, 96k samples. For
some reason or other, the emu10k1 driver will not let it
======================================================================

----------------------------------------------------------------------
 pzad - 04-26-06 22:07 
----------------------------------------------------------------------
Audigy 2 are two soundcards in one chip (old Audigy 1 and SB live 24 bit).
In linux Audigy 1 part is used by default (it has more features but only
48 kHz 16 bi). If you want use 24 bit 96 kHz you have to use device hw:0,4
(I think it is 4 - I am not sure). Alsa doesn't use it as default device,
because it has less features as Audigy 1 part (only advantage is 24/96
sound - disadvantage - no hw mixing no dsp).

----------------------------------------------------------------------
 jcdutton - 04-26-06 22:20 
----------------------------------------------------------------------
Please provide output from:
cat /proc/asound/cards
cat /proc/asound/version

24bit is not supported on all Audigy cards in linux yet.
The 24bit is a special mode that bypassed the DSP.
Unfortunately, the bypass method is different one almost every Audigy
card, so until all the different methods are supported, it will not work
on all Audigy cards.

Also 24bit capture on a PC sound card is next to pointless due to computer
noise introduced and low quality codecs and front end components. You
might get 18bits of real quality, but I doubt even that.

There are exceptions to that in the really expensive professional sound
capture devices that also have a PC interface, but very few of them work
with Linux. E.g. the EMU1212m.

James

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 21:51 braininajar    New Issue                                    
04-26-06 21:51 braininajar    Distribution              => gentoo          
04-26-06 21:51 braininajar    Kernel Version            => 2.6.16          
04-26-06 22:07 pzad           Note Added: 0009524                          
04-26-06 22:20 jcdutton       Note Added: 0009525                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
