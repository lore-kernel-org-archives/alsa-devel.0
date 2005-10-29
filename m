From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Sat, 29 Oct 2005 13:30:05 -0400
Message-ID: <1130607006.32367.116.camel@mindpipe>
References: <20051029102357.49836.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051029102357.49836.qmail@web52903.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-10-29 at 11:23 +0100, Chris Rankin wrote:
> NMI Watchdog detected LOCKUP on CPU0, eip c029a65a, registers:
> Modules linked in: snd_usb_audio snd_usb_lib snd_seq_oss snd_seq_midi snd_emu10k1_synth
> snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul mga
> drm ipv6 floppy snd_pcm_oss snd_mixer_oss snd_seq snd_rtctimer binfmt_misc matroxfb_maven
> i2c_matroxfb i2c_algo_bit loop w83781d eeprom i2c_sensor tsdev ide_cd
> cdrom psmouse pcspkr button processor nfs nfsd exportfs lockd parport_pc parport ehci_hcd eth1394
> ohci_hcd ohci1394 ieee1394 8139too mii emu10k1_gp gameport snd_emu10k1 snd_rawmidi snd_seq_device
> snd_ac97_codec snd_pcm snd_timer snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep snd soundcore
> i2c_i801 i2c_core uhci_hcd usbcore i8xx_tco intel_agp agpgart evdev sunrpc ext3 jbd
> CPU:    0
> EIP:    0060:[<c029a65a>]    Not tainted VLI
> EFLAGS: 00000086   (2.6.13.1)
> EIP is at _spin_lock+0xa/0x10
> eax: dafe64e4   ebx: dfd49220   ecx: d808ed0c   edx: 00000001
> esi: 00000000   edi: dafe6400   ebp: 00000008   esp: c0389f8c
> ds: 007b   es: 007b   ss: 0068
> Process aplaymidi (pid: 3932, threadinfo=c0389000 task=dfadfa60)
> Stack: e2900e13 00000001 d9b41a2c 00000292 0000284c dafe64e4 d9b41800 80020024
>        dfd49220 00000000 d808ed84 00000008 c02029d5 d808efbc c0139be2 00000000
>        c034c2c0 00000008 dfd49220 c034c2dc c0139cf9 d808efbc dfd49220 d808ed84
> Call Trace:
>  [<e2900e13>] snd_timer_interrupt+0x23/0x310 [snd_timer]
>  [<c02029d5>] rtc_interrupt+0xe5/0xf0
>  [<c0139be2>] handle_IRQ_event+0x32/0x70
>  [<c0139cf9>] __do_IRQ+0xd9/0x140
>  [<c0105306>] do_IRQ+0x46/0x70
>  =======================
>  [<c0103836>] common_interrupt+0x1a/0x20
>  [<c02031e8>] rtc_do_ioctl+0x6c8/0x8a0
>  [<c0142a9c>] make_ahead_window+0x7c/0xc0
>  [<c0120a4f>] current_fs_time+0x5f/0x70
>  [<c013f7d0>] prep_new_page+0x40/0x70
>  [<c013fd17>] buffered_rmqueue+0xe7/0x1d0
>  [<c0140139>] __alloc_pages+0x269/0x400
>  [<c0203710>] rtc_control+0x30/0x70
>  [<e2b72067>] rtctimer_start+0x27/0x30 [snd_rtctimer]
>  [<e290093e>] snd_timer_start1+0x7e/0xa0 [snd_timer]
>  [<e2900a25>] snd_timer_start+0x65/0xa0 [snd_timer]
>  [<e2c3ee86>] snd_seq_timer_start+0x36/0x50 [snd_seq]
>  [<e2c3da60>] snd_seq_queue_process_event+0xb0/0x100 [snd_seq]
>  [<e2c3d41f>] queue_access_lock+0x3f/0x60 [snd_seq]
>  [<e2c3dafd>] snd_seq_control_queue+0x4d/0x90 [snd_seq]
>  [<e2c39bdf>] snd_seq_deliver_single_event+0x16f/0x180 [snd_seq]
>  [<e2c39de4>] snd_seq_deliver_event+0x34/0x50 [snd_seq]
>  [<e2c3a036>] snd_seq_client_enqueue_event+0xe6/0x130 [snd_seq]
>  [<c01afb8a>] copy_from_user+0x3a/0x80
>  [<e2c3a225>] snd_seq_write+0x125/0x1a0 [snd_seq]
>  [<c0159390>] vfs_write+0x170/0x180
>  [<c0159451>] sys_write+0x41/0x70
>  [<c0102e1f>] sysenter_past_esp+0x54/0x75
> Code: c3 ba 00 f0 ff ff 21 e2 81 42 14 00 01 00 00 f0 81 28 00 00 00 01 74 05 e8 7c e8 ff ff c3 8d
> 76 00 f0 fe 08 79 09 f3 90 80 38 00 <7e> f9 eb f2 c3 90 f0 81 28 00 00 00 01 74 05 e8 5a e8 ff ff
> c3
> console shuts up ...

OK, great.  This is related to the recent change to make the RTC the
default timer for the ALSA sequencer, it's not an emu10k1 driver bug.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
