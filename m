From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000497]: cdplayer and midi does'n work
Date: Mon, 13 Sep 2004 15:32:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913133214.D0EBA1200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 83A2727E
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 15:32:15 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id E263E23C1E
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 15:32:14 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000497
======================================================================
Reported By:                maciekb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     497
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             09-11-2004 16:46 CEST
Last Modified:              09-13-2004 15:32 CEST
======================================================================
Summary:                    cdplayer and midi does'n work
Description: 
I have A7V600-X motherboard with via8237 chipset
My cdplayer does'n play and i do not have midi. 
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:32 CEST 
----------------------------------------------------------------------
Make sure that you unmuted and raised the volume of CD mixer control.
Please attach /etc/asound.state.

The hardware doesn't support MIDI (playback).
Possibly, the external MIDI UART is supported by snd-mpu401.
If you want a soft MIDI synth, try the softsynth program like TiMidity.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-11-04 16:46 maciekb        New Bug                                      
09-11-04 16:46 maciekb        Distribution              => Debian unstable 
09-11-04 16:46 maciekb        Kernel Version            => 2.6.7           
09-13-04 15:32 tiwai          Bugnote Added: 0001745                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
