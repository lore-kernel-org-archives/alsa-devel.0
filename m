From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001379]: 1.0.9 produces very low volume on all volumes set to 100%; 1.0.10rc1 fails to modprobe
Date: Wed, 7 Sep 2005 19:57:27 +0200
Message-ID: <e9be69d9955068a7785ffdec4e7631af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC1951B1
	for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2005 19:57:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1379> 
======================================================================
Reported By:                kSh
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1379
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SUSE Linux Professional 9.3
Kernel Version:             Linux 2.6.11.4-21.8-default
======================================================================
Date Submitted:             08-30-2005 18:47 CEST
Last Modified:              09-07-2005 19:57 CEST
======================================================================
Summary:                    1.0.9 produces very low volume on all volumes set to
100%; 1.0.10rc1 fails to modprobe
Description: 
Hello.
I have a problem with my Asus M5A laptop. ALSA drivers 1.0.9 that come
with SUSE produce very low volume even with all volumes set to 100%. I
tried removing the driver and compiling my own, the same result. And yes,
I read the 0001176 bug report that speaks of exactly the same issue. The
problem is 1.0.9 runs flawlessly but very quiet and although the
compilation and installation of 1.0.10rc1 went fine, while modprobing I
get:

# /etc/init.d/alsasound start
Starting sound driver: snd-hda-intel WARNING: Error inserting snd_pcm
(/lib/modules/2.6.11.4-21.8-default/kernel/sound/acore/snd-pcm.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hda_codec
(/lib/modules/2.6.11.4-21.8-default/kernel/sound/pci/hda/snd-hda-codec.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hda_intel
(/lib/modules/2.6.11.4-21.8-default/kernel/sound/pci/hda/snd-hda-intel.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
done

The dmesg is as follows:

# dmesg -c
snd: module not supported by Novell, setting U taint flag.
snd_timer: module not supported by Novell, setting U taint flag.
snd_pcm: module not supported by Novell, setting U taint flag.
snd_pcm: disagrees about version of symbol snd_dma_reserve_buf
snd_pcm: Unknown symbol snd_dma_reserve_buf, st_info == 0x1
snd_pcm: disagrees about version of symbol snd_dma_free_pages
snd_pcm: Unknown symbol snd_dma_free_pages, st_info == 0x1
snd_pcm: disagrees about version of symbol snd_dma_get_reserved_buf
snd_pcm: Unknown symbol snd_dma_get_reserved_buf, st_info == 0x1
snd_pcm: disagrees about version of symbol snd_dma_alloc_pages
snd_pcm: Unknown symbol snd_dma_alloc_pages, st_info == 0x1
load_module: err 0xfffffffe (dont worry)
snd_hda_codec: module not supported by Novell, setting U taint flag.
snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_list, st_info == 0x1
snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_step, st_info == 0x1
snd_hda_codec: Unknown symbol snd_pcm_format_width, st_info == 0x1
load_module: err 0xfffffffe (dont worry)
snd_hda_intel: module not supported by Novell, setting U taint flag.
snd_hda_intel: Unknown symbol snd_pcm_new, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_limit_hw_rates, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_lib_preallocate_pages_for_all,
st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_bus_new, st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_build_pcms, st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_codec_new, st_info == 0x1
snd_hda_intel: disagrees about version of symbol snd_dma_free_pages
snd_hda_intel: Unknown symbol snd_dma_free_pages, st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_queue_unsol_event, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_lib_malloc_pages, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_lib_ioctl, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_lib_free_pages, st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_calc_stream_format, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_set_ops, st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_suspend, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_suspend_all, st_info == 0x1
snd_hda_intel: Unknown symbol snd_hda_resume, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_integer, st_info ==
0x1
snd_hda_intel: Unknown symbol snd_hda_build_controls, st_info == 0x1
snd_hda_intel: disagrees about version of symbol snd_dma_alloc_pages
snd_hda_intel: Unknown symbol snd_dma_alloc_pages, st_info == 0x1
snd_hda_intel: Unknown symbol snd_pcm_period_elapsed, st_info == 0x1
load_module: err 0xfffffffe (dont worry)

It seems like the drivers were compiled for another kernel, am I right?
But the strange thing is the same ./configure, make, make install
procedure with 1.0.9 works just flawlessly.

I'm sorry if the problem comes from my lack of Linux knowledge. I just
hope we'll get a solution to this one. I'll provide any help you'll need.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-07-05 19:06 
----------------------------------------------------------------------
Just no time and no idea.  It works on my system pretty well.

----------------------------------------------------------------------
 tiwai - 09-07-05 19:57 
----------------------------------------------------------------------
If you have done only "rcalsasound stop" or "restart", it's not enough when
you update the drivers.  Run "modprobe -r snd-page-alloc" after
"rcalsasound stop" so that all snd-* modules are unloaded.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 18:47 kSh            New Issue                                    
08-30-05 18:47 kSh            Distribution              => SUSE Linux
Professional 9.3
08-30-05 18:47 kSh            Kernel Version            => Linux
2.6.11.4-21.8-default
08-30-05 18:49 kSh            Issue Monitored: kSh                         
08-30-05 19:48 Varanger       Issue Monitored: Varanger                    
08-30-05 23:19 Varanger       Issue End Monitor: Varanger                    
09-07-05 19:01 kSh            Note Added: 0006063                          
09-07-05 19:06 tiwai          Note Added: 0006064                          
09-07-05 19:57 tiwai          Note Added: 0006065                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
