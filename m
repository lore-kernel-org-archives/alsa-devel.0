From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 13:45:16 +0100
Message-ID: <490071DC.6070607@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090003080000080305070007"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A47110385A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 14:45:30 +0200 (CEST)
In-Reply-To: <s5hbpxb8lfe.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090003080000080305070007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
>
> It'd be great if you can capture the whole Oops log.
> That was entirely missing for all the time.
>   
Oops attached.

Caused when trying to use mplayer to play a wav that aplay played perfectly.

Happy to try anything to help.

Thanks, Jason

PS, the commands and output leading up to the oops are below.

[root@sentry ~]# modprobe snd_sbxfi
[root@sentry ~]# aplay -Dplug:dmix:0 0_16_96.wav
Playing WAVE '0_16_96.wav' : Signed 16 bit Little Endian, Rate 96000 Hz, 
Mono
[root@sentry ~]# aplay -Dplug:dmix:0 wn.wav
Playing WAVE 'wn.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
[root@sentry ~]# mplayer wn.wav
MPlayer dev-SVN-r26936-4.3.0 (C) 2000-2008 MPlayer Team
CPU: Intel(R) Celeron(R) CPU 2.53GHz (Family: 15, Model: 4, Stepping: 9)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 1
Compiled with runtime CPU detection.
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote 
control.

Playing wn.wav.
Audio file file format detected.
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 48000 Hz, 2 ch, s16le, 1536.0 kbit/100.00% (ratio: 192000->192000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
AO: [pulse] Init failed: Connection refused
*** PULSEAUDIO: Unable to connect: Connection refused
*** Is your sound server running?
*** See: http://www.pulseaudio.org/wiki/Troubleshooting
[AO_ALSA] Playback open error: Connection refused



--------------090003080000080305070007
Content-Type: text/plain;
 name="sbxfi_oops_JH_23OCT08_1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sbxfi_oops_JH_23OCT08_1.txt"

BUG: unable to handle kernel NULL pointer dereference at 00000038
IP: [<c0425ae4>] scheduler_tick+0x94/0x17a
Oops: 0000 [#1] SMP 
Modules linked in: snd_sbxfi snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc lp nfsd auth_rpcgss exportfs bridge bnep rfcomm l2cap bluetooth nfs lockd nfs_acl fuse sunrpc sr_mod cdrom dm_mirror dm_log dm_multipath dm_mod ppdev parport_pc parport floppy pcspkr i2c_i801 e100 mii sg iTCO_wdt iTCO_vendor_support usb_storage i915 drm i2c_algo_bit i2c_core pata_acpi ata_piix ata_generic libata sd_mod scsi_mod raid456 async_xor async_memcpy async_tx xor raid1 ext3 jbd mbcache uhci_hcd ohci_hcd ehci_hcd [last unloaded: microcode]

Pid: 0, comm:  Not tainted (2.6.26.5-45.fc9.i686 #1)
EIP: 0060:[<c0425ae4>] EFLAGS: 00210046 CPU: 0
EIP is at scheduler_tick+0x94/0x17a
EAX: c13fba80 EBX: 00000000 ECX: 00000000 EDX: dd9c9900
ESI: c13fba80 EDI: 00000010 EBP: dda80b4c ESP: dda80b30
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process  (pid: 0, ti=dda80000 task=dd9c9900 task.ti=00000000)
Stack: 000003ff dd9c9900 00000000 00000400 00000000 00000000 dd9c9900 dda80b60 
       c043102d c13f85a4 80fcf224 0000007c dda80b78 c0441c00 dda80be0 c13f85a4 
       7fffffff c13f8518 dda80b90 c043bc45 c13f8550 ffffffff 7fffffff c13f85a4 
Call Trace:
 [<c043102d>] ? update_process_times+0x3d/0x49
 [<c0441c00>] ? tick_sched_timer+0x6d/0xa5
 [<c043bc45>] ? __run_hrtimer+0x4c/0x83
 [<c043c618>] ? hrtimer_interrupt+0xef/0x152
 [<c0414207>] ? smp_apic_timer_interrupt+0x69/0x7c
 [<c04056a8>] ? apic_timer_interrupt+0x28/0x30
 [<e05a57ac>] ? sbxfi_pcm_hw_params+0xfc/0x18d [snd_sbxfi]
 [<e05167c7>] ? snd_pcm_hw_params+0xeb/0x2b0 [snd_pcm]
 [<e0516d34>] ? snd_pcm_common_ioctl1+0x269/0x1533 [snd_pcm]
 [<e051a8fc>] ? snd_pcm_hw_param_first+0x126/0x158 [snd_pcm]
 [<e05186b6>] ? snd_pcm_playback_ioctl1+0x360/0x377 [snd_pcm]
 [<e0518738>] ? snd_pcm_kernel_ioctl+0x38/0x60 [snd_pcm]
 [<e052b97a>] ? snd_pcm_oss_change_params+0x967/0xc89 [snd_pcm_oss]
 [<e052c418>] ? snd_pcm_oss_get_active_substream+0x29/0x70 [snd_pcm_oss]
 [<e052c4e9>] ? snd_pcm_oss_get_formats+0x11/0xba [snd_pcm_oss]
 [<c043c50d>] ? ktime_get+0x13/0x2f
 [<e052cf21>] ? snd_pcm_oss_ioctl+0x3b1/0xafe [snd_pcm_oss]
 [<e052cb70>] ? snd_pcm_oss_ioctl+0x0/0xafe [snd_pcm_oss]
 [<c048ffd6>] ? vfs_ioctl+0x22/0x69
 [<c0490256>] ? do_vfs_ioctl+0x239/0x24c
 [<c04d54c9>] ? selinux_file_ioctl+0xa8/0xab
 [<c04902a9>] ? sys_ioctl+0x40/0x5b
 [<c0404c32>] ? syscall_call+0x7/0xb
 =======================
Code: fa 39 4d f0 0f 46 55 f0 0f af c1 88 d9 01 c2 d3 ea 89 54 9e 08 43 83 fb 05 74 04 01 ff eb d6 8b 45 e8 31 c9 8b 58 24 89 c2 89 f0 <ff> 53 38 f0 fe 06 8b 55 ec b8 80 2a 7a c0 8b 0c 95 80 23 75 c0 
EIP: [<c0425ae4>] scheduler_tick+0x94/0x17a SS:ESP 0068:dda80b30
Kernel panic - not syncing: Fatal exception in interrupt


--------------090003080000080305070007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090003080000080305070007--
