From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000445]: 1.0.6 breaks redhat alsasound script
Date: Mon, 16 Aug 2004 12:06:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040816100639.ED13B1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3EDEE224
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2004 12:06:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000445
======================================================================
Reported By:                deathpudding
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     445
Category:                   CORE - sequencer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               redhat
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             08-15-2004 19:25 CEST
Last Modified:              08-16-2004 12:06 CEST
======================================================================
Summary:                    1.0.6 breaks redhat alsasound script
Description: 
I compiled the driver with sequencer support. The alsasound script uses the
content of /proc/asound/seq/drivers to know which sequencer drivers to
load. But, since installing the 1.0.6 driver, the seq/drivers file repeats
the list of drivers infinitely, for example:

snd-emu10k1-synth,loaded,requested,1
snd-seq-midi,loaded,requested,1
snd-seq-oss,loaded,requested,1
snd-emu10k1-synth,loaded,requested,1
snd-seq-midi,loaded,requested,1
snd-seq-oss,loaded,requested,1
...

and therefore the alsasound script gets stuck in an infinite loop,
printing out this:

FATAL: Module snd_emu10k1_synth already in kernel.
FATAL: Module snd_seq_midi already in kernel.
FATAL: Module snd_emu10k1_synth already in kernel.
FATAL: Module snd_seq_midi already in kernel.
...
======================================================================

----------------------------------------------------------------------
 c0ff - 08-15-2004 23:13 CEST 
----------------------------------------------------------------------
It's a bug in alsa /proc read function (core/info.c). 2.6.8-rc4 kernel does
not have this bug, but alsa-driver-1.0.5a has.

----------------------------------------------------------------------
 perex - 08-16-2004 12:06 CEST 
----------------------------------------------------------------------
Fixed in 1.0.6a.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 19:25 deathpudding   New Bug                                      
08-15-04 19:25 deathpudding   Distribution              => redhat          
08-15-04 23:13 c0ff           Bugnote Added: 0001568                       
08-16-04 12:06 perex          Bugnote Added: 0001570                       
08-16-04 12:06 perex          Assigned To               => perex           
08-16-04 12:06 perex          Resolution               open => fixed       
08-16-04 12:06 perex          Status                   new => resolved     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
