From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001833]: oops in snd_mpu401_uart
Date: Wed, 12 Apr 2006 15:16:15 +0200
Message-ID: <1aa51cdfe829736909d6e33a530f509f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57128154
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 15:16:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1833> 
======================================================================
Reported By:                ponchick
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1833
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             gentoo-sources-2.6.15-r4
======================================================================
Date Submitted:             02-09-2006 08:33 CET
Last Modified:              04-12-2006 15:16 CEST
======================================================================
Summary:                    oops in snd_mpu401_uart
Description: 
I don't know what exactly happend but when I run wine or winecfg it
segfaulted. dmesg shows following:
Unable to handle kernel paging request at 0000000010228800 RIP:
<ffffffff884ca00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
PGD 6e57067 PUD 0
Oops: 0002 [1] PREEMPT SMP
CPU 1
Modules linked in: snd_rtctimer snd_seq_midi snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq snd_au8830 snd_ac97_codec snd_pcm
snd_timer snd_page_alloc snd_ac97_bus snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore nvidia sky2
Pid: 11110, comm: wine-preloader Tainted: P      2.6.15-gentoo-r4 #1
RIP: 0010:[<ffffffff884ca00c>]
<ffffffff884ca00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
RSP: 0018:ffff81003564f8f0  EFLAGS: 00010046
RAX: 0000000000000013 RBX: ffff81003cb4e580 RCX: 0000000000000000
RDX: 0000000010228800 RSI: 0000000000000000 RDI: ffff81003cb4e580
RBP: ffff81003eb60740 R08: 0000000000000000 R09: ffff8100279794c0
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81003cb4fe00
R13: 0000000000000001 R14: ffff81003cb4e5f8 R15: 0000000000000246
FS:  000000005556c000(006b) GS:ffffffff8057b880(0063)
knlGS:00000000556cb920
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000010228800 CR3: 00000000375ad000 CR4: 00000000000006e0
Process wine-preloader (pid: 11110, threadinfo ffff81003564e000, task
ffff810002178440)
Stack: ffffffff884ca19f ffff81003ffef500 0000000000000046
ff00000000000286
       ffff81003cb4e580 ffff81003eb60740 ffff81003cb4fe00
ffff81003eb606c0
       0000000000000000 ffff81003d7c3bd0
Call Trace:<ffffffff884ca19f>{:snd_mpu401_uart:snd_mpu401_uart_cmd+65}
       <ffffffff884ca2f4>{:snd_mpu401_uart:snd_mpu401_uart_input_open+73}
       <ffffffff884c36b3>{:snd_rawmidi:snd_rawmidi_kernel_open+644}
       <ffffffff885471f0>{:snd_seq_midi:midisynth_subscribe+53}
       <ffffffff80397b49>{_spin_lock+27}
<ffffffff8851fcc2>{:snd_seq:subscribe_port+214}
       <ffffffff8851ff8f>{:snd_seq:snd_seq_port_connect+433}
       <ffffffff8851a9c8>{:snd_seq:snd_seq_ioctl_subscribe_port+226}
       <ffffffff8851c19a>{:snd_seq:snd_seq_kernel_client_ctl+92}
       <ffffffff8852eb1b>{:snd_seq_oss:snd_seq_oss_midi_open+267}
       <ffffffff8852eb83>{:snd_seq_oss:snd_seq_oss_midi_open_all+35}
       <ffffffff8852b89a>{:snd_seq_oss:snd_seq_oss_open+1152}
       <ffffffff8852d20c>{:snd_seq_oss:snd_seq_oss_event_input+0}
       <ffffffff8852b90a>{:snd_seq_oss:free_devinfo+0}
<ffffffff8018075f>{__link_path_walk+3332}
       <ffffffff80397b0c>{__lock_text_start+20}
<ffffffff8852b034>{:snd_seq_oss:odev_open+52}
       <ffffffff884ac6e4>{:soundcore:soundcore_open+513}
<ffffffff8017ab11>{chrdev_open+454}
       <ffffffff8017a94b>{chrdev_open+0}
<ffffffff80171031>{__dentry_open+310}
       <ffffffff8017118d>{nameidata_to_filp+34}
<ffffffff801711d6>{filp_open+58}
       <ffffffff801713d4>{get_unused_fd+234}
<ffffffff80171533>{do_sys_open+81}
       <ffffffff8011e57f>{sysenter_do_call+27}

Code: 40 88 32 c3 0f b6 06 0f b6 c0 c3 48 83 ec 28 4c 89 64 24 10
RIP <ffffffff884ca00c>{:snd_mpu401_uart:mpu401_write_mmio+0} RSP
<ffff81003564f8f0>
CR2: 0000000010228800
 <6>note: wine-preloader[11110] exited with preempt_count 1

I use standalone alsa-driver (kernel one is out of date and doesn't
support au8830 on 64-bit platforms) with gentoo-sources-2.6.14-r5,
gentoo-sources-2.6.15-r1 and gentoo-sources-2.6.15-r4. 
======================================================================

----------------------------------------------------------------------
 ponchick - 04-12-06 11:36 
----------------------------------------------------------------------
> Since the output of wavetable daugther card is connected to the "Video"
of analog mixer of AC97 codec, it don't use any resources dma, src or
mixer of au88x0 chip.
> 
> Do you have any other error in system log when the driver is loaded ?

No, I haven't.

> Do you have Diamond MX25 (SPDIF) connected to your NX300 ?

I haven't SPDIF out (at least on rear panel)

> Are there any application trying to open hw:0,1 (SPDIF), hw:0,2 or
hw:0,3 ?

I don't think so. There is only arts running when these errors occur. As I
know in default configuration it use hw:0.0 only.

> AFAIK /dev/adsp cannot be mapped to hw:0,1 for au88x0
> 
> 
>>> Do you means that no oops with aplaymidi when you mention "aplaymidi
doesn't
>>> produce any sound with and without this patch" ?
> 
>> Yes, with this patch there is no oops.
> 
> I assume that you mean the oops can be reproduced by
> 
> aplaymidi --port=16:0 any.mid
> 
> on your EM64T with alsa-1.0.11rc4 , it is easy for other to test when
the bug can be reproduced by a program in alsa-utils

Yes, It can be easily reproduced. Also without this patch I get about 1250
messages in kernel log like this:


Call Trace:<ffffffff8039b58e>{__sched_text_start+126}
<ffffffff8013a3af>{lock_timer_base+41}
       <ffffffff8039daf4>{_spin_unlock_irqrestore+22}
<ffffffff8039d045>{schedule_timeout+140}
       <ffffffff8013af04>{process_timeout+0}
<ffffffff8807a07c>{:snd_seq:snd_use_lock_sync_helper+124}
       <ffffffff88080980>{:snd_seq:port_delete+40}
<ffffffff88080ab8>{:snd_seq:snd_seq_delete_all_ports+233}
       <ffffffff8807a39a>{:snd_seq:seq_free_client1+9}
<ffffffff8807a48c>{:snd_seq:seq_free_client+86}
       <ffffffff8807a651>{:snd_seq:snd_seq_release+21}
<ffffffff80172bcb>{__fput+177}
       <ffffffff80171452>{filp_close+105}
<ffffffff80133541>{put_files_struct+110}
       <ffffffff80133e8c>{do_exit+594}
<ffffffff8027d372>{do_unblank_screen+114}
       <ffffffff8011d6a3>{do_page_fault+1786}
<ffffffff80141ce4>{call_usermodehelper_keys+213}
       <ffffffff8010e92d>{error_exit+0}
<ffffffff8802b00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
       <ffffffff8802b19f>{:snd_mpu401_uart:snd_mpu401_uart_cmd+65}
      
<ffffffff8802b36a>{:snd_mpu401_uart:snd_mpu401_uart_output_open+73}
       <ffffffff88024704>{:snd_rawmidi:snd_rawmidi_kernel_open+725}
       <ffffffff880a82b8>{:snd_seq_midi:midisynth_use+48}
<ffffffff8039df15>{_read_unlock_irq+18}
       <ffffffff8015249f>{find_get_page+86}
<ffffffff88080cc6>{:snd_seq:subscribe_port+214}
       <ffffffff88080fc9>{:snd_seq:snd_seq_port_connect+487}
       <ffffffff8807b9c8>{:snd_seq:snd_seq_ioctl_subscribe_port+226}
       <ffffffff8807cb18>{:snd_seq:snd_seq_ioctl+16}
<ffffffff8018444b>{do_ioctl+59}
       <ffffffff80184749>{vfs_ioctl+677} <ffffffff801847ba>{sys_ioctl+77}
       <ffffffff8010dbc2>{system_call+126}
scheduling while atomic: aplaymidi/0x00000001/22528

Call Trace:<ffffffff8039b58e>{__sched_text_start+126}
<ffffffff8013a3af>{lock_timer_base+41}
       <ffffffff8039daf4>{_spin_unlock_irqrestore+22}
<ffffffff8039d045>{schedule_timeout+140}
       <ffffffff8013af04>{process_timeout+0}
<ffffffff8807a07c>{:snd_seq:snd_use_lock_sync_helper+124}
       <ffffffff88080980>{:snd_seq:port_delete+40}
<ffffffff88080ab8>{:snd_seq:snd_seq_delete_all_ports+233}
       <ffffffff8807a39a>{:snd_seq:seq_free_client1+9}
<ffffffff8807a48c>{:snd_seq:seq_free_client+86}
       <ffffffff8807a651>{:snd_seq:snd_seq_release+21}
<ffffffff80172bcb>{__fput+177}
       <ffffffff80171452>{filp_close+105}
<ffffffff80133541>{put_files_struct+110}
       <ffffffff80133e8c>{do_exit+594}
<ffffffff8027d372>{do_unblank_screen+114}
       <ffffffff8011d6a3>{do_page_fault+1786}
<ffffffff80141ce4>{call_usermodehelper_keys+213}
       <ffffffff8010e92d>{error_exit+0}
<ffffffff8802b00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
       <ffffffff8802b19f>{:snd_mpu401_uart:snd_mpu401_uart_cmd+65}
      
<ffffffff8802b36a>{:snd_mpu401_uart:snd_mpu401_uart_output_open+73}
       <ffffffff88024704>{:snd_rawmidi:snd_rawmidi_kernel_open+725}
       <ffffffff880a82b8>{:snd_seq_midi:midisynth_use+48}
<ffffffff8039df15>{_read_unlock_irq+18}
       <ffffffff8015249f>{find_get_page+86}
<ffffffff88080cc6>{:snd_seq:subscribe_port+214}
       <ffffffff88080fc9>{:snd_seq:snd_seq_port_connect+487}
       <ffffffff8807b9c8>{:snd_seq:snd_seq_ioctl_subscribe_port+226}
       <ffffffff8807cb18>{:snd_seq:snd_seq_ioctl+16}
<ffffffff8018444b>{do_ioctl+59}
       <ffffffff80184749>{vfs_ioctl+677} <ffffffff801847ba>{sys_ioctl+77}
       <ffffffff8010dbc2>{system_call+126}
ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc4/work/alsa-driver-1.0.11rc4/acore/seq/../../alsa-kernel/core/seq/seq_lock.c:39:
seq_lock: timeout [1 left] in
/var/tmp/portage/alsa-driver-1.0.11_rc4/work/alsa-driver-1.0.11rc4/acore/seq/seq_ports.c:271
scheduling while atomic: aplaymidi/0x00000001/22528

Call Trace:<ffffffff8039b58e>{__sched_text_start+126}
<ffffffff8039de8f>{_spin_unlock_irq+21}
       <ffffffff8039c4b3>{thread_return+195}
<ffffffff8801652b>{:snd:snd_verbose_printk+230}
       <ffffffff8039d461>{__down_write+129}
<ffffffff88080805>{:snd_seq:clear_subscriber_list+46}
       <ffffffff88080991>{:snd_seq:port_delete+57}
<ffffffff88080ab8>{:snd_seq:snd_seq_delete_all_ports+233}
       <ffffffff8807a39a>{:snd_seq:seq_free_client1+9}
<ffffffff8807a48c>{:snd_seq:seq_free_client+86}
       <ffffffff8807a651>{:snd_seq:snd_seq_release+21}
<ffffffff80172bcb>{__fput+177}
       <ffffffff80171452>{filp_close+105}
<ffffffff80133541>{put_files_struct+110}
       <ffffffff80133e8c>{do_exit+594}
<ffffffff8027d372>{do_unblank_screen+114}
       <ffffffff8011d6a3>{do_page_fault+1786}
<ffffffff80141ce4>{call_usermodehelper_keys+213}
       <ffffffff8010e92d>{error_exit+0}
<ffffffff8802b00c>{:snd_mpu401_uart:mpu401_write_mmio+0}
       <ffffffff8802b19f>{:snd_mpu401_uart:snd_mpu401_uart_cmd+65}
      
<ffffffff8802b36a>{:snd_mpu401_uart:snd_mpu401_uart_output_open+73}
       <ffffffff88024704>{:snd_rawmidi:snd_rawmidi_kernel_open+725}
       <ffffffff880a82b8>{:snd_seq_midi:midisynth_use+48}
<ffffffff8039df15>{_read_unlock_irq+18}
       <ffffffff8015249f>{find_get_page+86}
<ffffffff88080cc6>{:snd_seq:subscribe_port+214}
       <ffffffff88080fc9>{:snd_seq:snd_seq_port_connect+487}
       <ffffffff8807b9c8>{:snd_seq:snd_seq_ioctl_subscribe_port+226}
       <ffffffff8807cb18>{:snd_seq:snd_seq_ioctl+16}
<ffffffff8018444b>{do_ioctl+59}
       <ffffffff80184749>{vfs_ioctl+677} <ffffffff801847ba>{sys_ioctl+77}
       <ffffffff8010dbc2>{system_call+126}

----------------------------------------------------------------------
 Raymond - 04-12-06 15:16 
----------------------------------------------------------------------
>> Are there any application trying to open hw:0,1 (SPDIF), hw:0,2 or
hw:0,3 ?

>I don't think so. There is only arts running when these errors occur. As
I know >in default configuration it use hw:0.0 only.

ALSA CVS server still not working

Try this diff against alsa-1.0.11rc5 to find out why the resources are
exhausted

diff -u alsa-driver-1.0.11rc5/alsa-kernel/pci/au88x0_orig/au88x0_pcm.c
alsa-driver-1.0.11rc5/alsa-kernel/pci/au88x0/au88x0_pcm.c
---
alsa-driver-1.0.11rc5/alsa-kernel/pci/au88x0_orig/au88x0_pcm.c	2006-04-10
21:42:00.000000000 +0800
+++ alsa-driver-1.0.11rc5/alsa-kernel/pci/au88x0/au88x0_pcm.c	2006-04-12
21:08:55.000000000 +0800
@@ -122,6 +122,8 @@
 	vortex_t *vortex = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
+
+	printk(KERN_INFO "vortex: pcm_open %s hw:%d,%d,%d\n",substream->stream
== SNDRV_PCM_STREAM_PLAYBACK ? "Playback" : "Capture" ,
vortex->card->number, substream->pcm->device, substream->number);
 	
 	/* Force equal size periods */
 	if ((err =
@@ -171,9 +173,13 @@
 /* close callback */
 static int snd_vortex_pcm_close(struct snd_pcm_substream *substream)
 {
-	//vortex_t *chip = snd_pcm_substream_chip(substream);
+	vortex_t *chip = snd_pcm_substream_chip(substream);
 	stream_t *stream = (stream_t *) substream->runtime->private_data;
 
+	printk(KERN_INFO "vortex: pcm_close %s hw:%d,%d,%d\n",
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? "Playback" :
"Capture",
+		chip->card->number, substream->pcm->device , substream->number );
+
 	// the hardware-specific codes will be here
 	if (stream != NULL) {
 		stream->substream = NULL;
@@ -202,10 +208,9 @@
 	}
 	//sgbuf = (struct snd_sg_buf *) substream->runtime->dma_private;
 	sgbuf = snd_pcm_substream_sgbuf(substream);
-	/*
-	   printk(KERN_INFO "Vortex: periods %d, period_bytes %d, channels =
%d\n", params_periods(hw_params),
-	   params_period_bytes(hw_params), params_channels(hw_params));
-	 */
+	
+   	printk(KERN_INFO "vortex: pcm_hwparams %s hw:%d,%d,%d channels = %d
format = %d rate = %d\n", substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
"Playback" : "Capture ", chip->card->number, substream->pcm->device,
substream->number, params_channels(hw_params), params_format(hw_params),
params_rate(hw_params));
+	 
 	spin_lock_irq(&chip->lock);
 	// Make audio routes and config buffer DMA.
 	if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT) {
@@ -255,6 +260,9 @@
 {
 	vortex_t *chip = snd_pcm_substream_chip(substream);
 	stream_t *stream = (stream_t *) (substream->runtime->private_data);
+	printk(KERN_INFO "vortex: pcm_hw_free %s hw:%d,%d,%d\n",
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? "Playback" :
"Capture",
+		chip->card->number, substream->pcm->device , substream->number );
 
 	spin_lock_irq(&chip->lock);
 	// Delete audio routes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-06 08:33 ponchick       New Issue                                    
02-09-06 08:33 ponchick       Distribution              => gentoo          
02-09-06 08:33 ponchick       Kernel Version            =>
gentoo-sources-2.6.15-r4
02-09-06 09:12 Raymond        Note Added: 0007971                          
02-09-06 09:32 Raymond        Note Added: 0007973                          
02-09-06 11:57 ponchick       Note Added: 0007975                          
02-09-06 12:32 Raymond        Note Added: 0007976                          
02-09-06 12:35 Raymond        Note Edited: 0007976                         
02-10-06 03:06 Raymond        Note Added: 0007982                          
02-10-06 03:11 rlrevell       Note Added: 0007983                          
02-10-06 03:49 Raymond        Note Added: 0007984                          
02-10-06 05:08 ponchick       Note Added: 0007986                          
02-10-06 05:36 Raymond        Note Added: 0007988                          
02-10-06 06:03 Raymond        Note Added: 0007990                          
02-10-06 10:09 ponchick       Note Added: 0007997                          
02-10-06 11:30 Raymond        Note Added: 0008001                          
02-12-06 03:32 Raymond        Note Added: 0008024                          
02-12-06 14:14 Raymond        Note Deleted: 0007990                        
02-13-06 07:08 Raymond        Note Edited: 0008024                         
02-13-06 16:44 Raymond        Note Edited: 0008001                         
02-14-06 10:41 Raymond        Note Edited: 0008024                         
02-16-06 04:40 Raymond        Note Added: 0008084                          
02-16-06 06:33 ponchick       Note Added: 0008086                          
02-16-06 09:57 Raymond        Note Added: 0008089                          
02-16-06 10:16 ponchick       Note Added: 0008091                          
02-16-06 10:38 Raymond        Note Added: 0008092                          
02-16-06 10:40 Raymond        Note Edited: 0008092                         
02-16-06 13:08 Raymond        Note Edited: 0008089                         
02-25-06 13:15 Raymond        Note Added: 0008189                          
03-21-06 18:02 Raymond        Note Edited: 0008089                         
04-06-06 19:13 Raymond        Note Added: 0009126                          
04-06-06 19:23 rlrevell       Note Added: 0009127                          
04-11-06 05:09 Raymond        Note Added: 0009226                          
04-11-06 06:08 ponchick       Note Added: 0009227                          
04-11-06 09:06 Raymond        Note Added: 0009230                          
04-12-06 10:28 Raymond        Note Added: 0009240                          
04-12-06 11:36 ponchick       Note Added: 0009241                          
04-12-06 15:16 Raymond        Note Added: 0009243                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
