From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002331]: Everything works,
	but no sound. Mic works. ICH7, ALC861
Date: Fri, 4 Aug 2006 11:18:42 +0200
Message-ID: <206984a2855bef833f0ff9a433af3ab3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18D11141
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 11:18:43 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2331> 
======================================================================
Reported By:                pwaller
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2331
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.17.6
======================================================================
Date Submitted:             08-04-2006 11:18 CEST
Last Modified:              08-04-2006 11:18 CEST
======================================================================
Summary:                    Everything works, but no sound. Mic works. ICH7,
ALC861
Description: 
New laptop, I'm unsure of the exact make, it is unbranded - I don't know
what the hardware is apart from what lspci and such are telling me. If I
need to find out from some documentatin I will do so.

I've tried every setting for model= available.

pwaller@jupiter$ sudo lspci -nv -s 00:1b.0
0000:00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1584:9072
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at fe0f8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

pwaller@jupiter$ sudo lspci -v -s 00:1b.0
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
        Subsystem: Uniwill Computer Corp: Unknown device 9072

pwaller@jupiter$ sudo lshw -C multimedia
  *-multimedia
       description: Multimedia controller
       product: 82801G (ICH7 Family) High Definition Audio Controller
       vendor: Intel Corporation
       physical id: 1b
       bus info: pci@00:1b.0
       version: 02
       width: 64 bits
       clock: 33MHz
       capabilities: bus_master cap_list
       configuration: driver=HDA Intel
       resources: iomemory:fe0f8000-fe0fbfff irq:169


dmesg | grep snd
(no output).

pwaller@jupiter$ lsmod | grep hda
snd_hda_intel          20116  0
snd_hda_codec         164400  1 snd_hda_intel
snd_pcm                82820  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd                    60552  6
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         11272  2 snd_hda_intel,snd_pcm

Seems to be a fairly common issue, looking at various bug reports here.
:(


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-06 11:18 pwaller        New Issue                                    
08-04-06 11:18 pwaller        Distribution              => Ubuntu Dapper   
08-04-06 11:18 pwaller        Kernel Version            => 2.6.17.6        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
