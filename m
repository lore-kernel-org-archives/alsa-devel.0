From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000455]: segfault when trying to connect dmix->plug
Date: Wed, 18 Aug 2004 20:20:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818182040.21A341102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 78CEA28A
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 20:20:40 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 3182518E41
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 20:20:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000455
======================================================================
Reported By:                stsp
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     455
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-18-2004 20:20 CEST
Last Modified:              08-18-2004 20:20 CEST
======================================================================
Summary:                    segfault when trying to connect dmix->plug
Description: 
Hi.

With the attached configuration I get
segmentation fault:
---
$ ogg123 mise02-ulicka.ogg
ALSA lib pcm_dmix.c:873:(snd_pcm_dmix_open) dmix plugin can be only
connected to hw plugin
Segmentation fault
---

Here is the problematic place:
---
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1078196992 (LWP 30505)]
snd_pcm_plug_open (pcmp=0xbffff7c0, name=0x43653b13 "default",
    sformat=1131543104, schannels=1131543104, srate=1131543104,
    route_policy=1131543104, ttable=0x4371fa40, tt_ssize=1131543104,
    tt_cused=1131543104, tt_sused=1131543104, slave=0x428c6fdc,
    close_slave=1131543104) at pcm_plug.c:1034
1034            pcm->fast_ops = slave->fast_ops;
(gdb) p pcm->fast_ops
$1 = (snd_pcm_fast_ops_t *) 0x0
---
So it is trying to assign to NULL.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 20:20 stsp           New Bug                                      
08-18-04 20:20 stsp           File Added: asound.conf                      
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
