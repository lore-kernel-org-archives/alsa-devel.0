From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000455]: segfault when trying to connect dmix->plug
Date: Wed, 15 Sep 2004 20:44:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040915184440.7BBD747007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D5DD5308
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 20:44:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000455
======================================================================
Reported By:                stsp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     455
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             08-18-2004 20:20 CEST
Last Modified:              09-15-2004 20:44 CEST
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

----------------------------------------------------------------------
 stsp - 08-19-2004 10:21 CEST 
----------------------------------------------------------------------
> $1 = (snd_pcm_fast_ops_t *) 0x0
> So it is trying to assign to NULL.
OK, never mind, of course that assignment is valid.
Nothing wrong with the slave->fast_fops either.
But it segfaults here only when some memory debugger
is used (njamd, efence), otherwise it segfaults much
later. Might be some memory corruption.
Attached are backtraces at a crash points: log1 - with
memory debugger; log2 - without. Both looks pretty
useless...

----------------------------------------------------------------------
 stsp - 08-22-2004 17:58 CEST 
----------------------------------------------------------------------
This was trivial to resolve, patch attached.
Btw, any plans to make dmix to be attachable to other plugins?

----------------------------------------------------------------------
 stsp - 09-13-2004 18:36 CEST 
----------------------------------------------------------------------
I guess I have to add the proper description to that patch:

------------
Summary: [ALSA-LIB] dmix: dont forget to return -EINVAL on errors

Description:
snd_pcm_dmix_open() returns success if the open fails attempting
to open not the HW plugin (dmix seems to be limited to use only
the HW plugin right now). This leads to memory corruptions and
eventually a SIGSEGV. The attached patch fixes the omission.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>

----------------------------------------------------------------------
 tiwai - 09-15-2004 20:44 CEST 
----------------------------------------------------------------------
Thanks, applied to CVS now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 20:20 stsp           New Bug                                      
08-18-04 20:20 stsp           File Added: asound.conf                      
08-19-04 10:21 stsp           Bugnote Added: 0001589                       
08-19-04 10:22 stsp           File Added: logs.tar.gz                      
08-19-04 10:23 stsp           Bug Monitored: stsp                          
08-22-04 17:56 stsp           File Added: pcm_dmix.c.diff                    
08-22-04 17:58 stsp           Bugnote Added: 0001609                       
09-13-04 18:36 stsp           Bugnote Added: 0001753                       
09-13-04 18:37 stsp           File Added: dmix_ret_fix.diff                    
09-15-04 20:44 tiwai          Bugnote Added: 0001764                       
09-15-04 20:44 tiwai          Assigned To               => tiwai           
09-15-04 20:44 tiwai          Resolution               open => fixed       
09-15-04 20:44 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
