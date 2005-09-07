From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001379]: 1.0.9 produces very low volume on all volumes set to 100%; 1.0.10rc1 fails to modprobe
Date: Wed, 7 Sep 2005 22:15:17 +0200
Message-ID: <c2e2be995385354d92f7a508a041f6b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 983131A8
	for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2005 22:15:17 +0200 (MEST)
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
Last Modified:              09-07-2005 22:15 CEST
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
 kSh - 09-07-05 21:51 
----------------------------------------------------------------------
Thank you. I managed to make the soundcard work :) Here's the one and only
killer combination for all of you upgrading from 1.0.9 to 1.0.10rc1:

/etc/init.d/alsasound stop
for i in `lsmod | cut -d" " -f1 | grep snd`; do modprobe -r $i; done
modprobe -r soundcore
cd /your/1.0.9/dir/
make uninstall
cd /your/1.0.10rc1/dir/
make clean
./configure --with-suse=yes --with-sequencer=yes --with-debug=full
--prefix=/usr --with-cards=hda-intel 
make && make install

Now edit your /etc/modprobe.d/sound file to contain:
options snd-hda-intel model="asus" position_fix=1
options hda-codec model="asus"

Finally, do /etc/init.d/alsasound start

For some strange reason, all other combinations failed. You have to
explicitly tell ./configure to bare SUSE kernel and to compile only the
hda-intel card. If anything in my instructions isn't sane, tell me.

Again, thank you all for your time. This issue is now resolved and should
be closed :)

If you need any SUSE specific help or testing don't hesitate to contact
me. I will help you gladly if I can.

Best regards,
Lukasz Langa

----------------------------------------------------------------------
 kSh - 09-07-05 22:15 
----------------------------------------------------------------------
Well, there IS one problem, though. One I thought would be solved by
position_fix=1. I mean the sound is clicky at times, the artifacts sound
like crushed cellophane or faulty cables when you touch them: these are
high-pitch clicks and pops. The clicks are heard on high-volume music
fragments but not on all of them and this effect is not related with
volume adjustments (100% volume produces as many pops as volumes at 50%..
below 40% however I can barely hear anything so I can't really tell for
sure) or LFE (bass-boost) that I have always set to 0%.

position_fix produces the same effects for 0, 1 and 2 values.

What can I do? (this issue is related with 0001380)

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
09-07-05 21:51 kSh            Note Added: 0006067                          
09-07-05 22:15 kSh            Note Added: 0006068                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
