From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Sat, 29 Oct 2005 11:23:57 +0100 (BST)
Message-ID: <20051029102357.49836.qmail@web52903.mail.yahoo.com>
References: <1130549177.32367.63.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130549177.32367.63.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Lee Revell <rlrevell@joe-job.com> wrote:
> > I've just installed Linux 2.6.14-SMP with ALSA 1.0.10rc1 on my UP PII=
I machine, and I've found
> > that:
> >=20
> > $ aplaymidi -p 65:0 <midifile>
> >=20
> > immediately locks my machine up hard.

> What was the last version where this worked?

At least 1.0.9b, I think.

> Which soundfont do you have loaded?

It's the 8mbgmsfx.sf2 sound-font that came with the card.

> Are any other apps using the audio device at the time?

None.

>  What does /proc/asound/card0/voices look like?

$ cat /proc/asound/card0/voices=20
ch      use     pcm     efx     synth   midi
0       0       0       0       0       0
1       0       0       0       0       0
2       0       0       0       0       0
3       0       0       0       0       0
4       0       0       0       0       0
5       0       0       0       0       0
6       0       0       0       0       0
7       0       0       0       0       0
8       0       0       0       0       0
9       0       0       0       0       0
10      0       0       0       0       0
11      0       0       0       0       0
12      0       0       0       0       0
13      0       0       0       0       0
14      0       0       0       0       0
15      0       0       0       0       0
16      0       0       0       0       0
17      0       0       0       0       0
18      0       0       0       0       0
19      0       0       0       0       0
20      0       0       0       0       0
21      0       0       0       0       0
22      0       0       0       0       0
23      0       0       0       0       0
24      0       0       0       0       0
25      0       0       0       0       0
26      0       0       0       0       0
27      0       0       0       0       0
28      0       0       0       0       0
29      0       0       0       0       0
30      0       0       0       0       0
31      0       0       0       0       0
32      0       0       0       0       0
33      0       0       0       0       0
34      0       0       0       0       0
35      0       0       0       0       0
36      0       0       0       0       0
37      0       0       0       0       0
38      0       0       0       0       0
39      0       0       0       0       0
40      0       0       0       0       0
41      0       0       0       0       0
42      0       0       0       0       0
43      0       0       0       0       0
44      0       0       0       0       0
45      0       0       0       0       0
46      0       0       0       0       0
47      0       0       0       0       0
48      0       0       0       0       0
49      0       0       0       0       0
50      0       0       0       0       0
51      0       0       0       0       0
52      0       0       0       0       0
53      0       0       0       0       0
54      0       0       0       0       0
55      0       0       0       0       0
56      0       0       0       0       0
57      0       0       0       0       0
58      0       0       0       0       0
59      0       0       0       0       0
60      0       0       0       0       0
61      0       0       0       0       0
62      0       0       0       0       0
63      0       0       0       0       0
=20
> Try creating a MIDI file with only 8 notes, does that also cause the
> lockup?  If this works then try 16, 32 etc until it locks up.

I have no idea how to create a MIDI file; Again, I've been using MIDI fil=
es that came with the
card. And in fact, it doesn't play a single note before it locks up.

> Can the problem be reproduced on a UP kernel?

I'll bear that test in mind; my next test will be seeing if my Audigy2 be=
haves the same in my SMP
box.

Update: I've just rebooted this machine back into 2.6.13.1 to check which=
 version of the ALSA
drivers I was using before. Apparently, it was 1.0.10rc1 as of 30th Septe=
mber, and yes, the MIDI
lockup was present. However, this time the NMI watchdog was able to give =
me an oops report:

NMI Watchdog detected LOCKUP on CPU0, eip c029a65a, registers:
Modules linked in: snd_usb_audio snd_usb_lib snd_seq_oss snd_seq_midi snd=
_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul mga
drm ipv6 floppy snd_pcm_oss snd_mixer_oss snd_seq snd_rtctimer binfmt_mis=
c matroxfb_maven
i2c_matroxfb i2c_algo_bit loop w83781d eeprom i2c_sensor tsdev ide_cd
cdrom psmouse pcspkr button processor nfs nfsd exportfs lockd parport_pc =
parport ehci_hcd eth1394
ohci_hcd ohci1394 ieee1394 8139too mii emu10k1_gp gameport snd_emu10k1 sn=
d_rawmidi snd_seq_device
snd_ac97_codec snd_pcm snd_timer snd_ac97_bus snd_page_alloc snd_util_mem=
 snd_hwdep snd soundcore
i2c_i801 i2c_core uhci_hcd usbcore i8xx_tco intel_agp agpgart evdev sunrp=
c ext3 jbd
CPU:    0
EIP:    0060:[<c029a65a>]    Not tainted VLI
EFLAGS: 00000086   (2.6.13.1)
EIP is at _spin_lock+0xa/0x10
eax: dafe64e4   ebx: dfd49220   ecx: d808ed0c   edx: 00000001
esi: 00000000   edi: dafe6400   ebp: 00000008   esp: c0389f8c
ds: 007b   es: 007b   ss: 0068
Process aplaymidi (pid: 3932, threadinfo=3Dc0389000 task=3Ddfadfa60)
Stack: e2900e13 00000001 d9b41a2c 00000292 0000284c dafe64e4 d9b41800 800=
20024
       dfd49220 00000000 d808ed84 00000008 c02029d5 d808efbc c0139be2 000=
00000
       c034c2c0 00000008 dfd49220 c034c2dc c0139cf9 d808efbc dfd49220 d80=
8ed84
Call Trace:
 [<e2900e13>] snd_timer_interrupt+0x23/0x310 [snd_timer]
 [<c02029d5>] rtc_interrupt+0xe5/0xf0
 [<c0139be2>] handle_IRQ_event+0x32/0x70
 [<c0139cf9>] __do_IRQ+0xd9/0x140
 [<c0105306>] do_IRQ+0x46/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103836>] common_interrupt+0x1a/0x20
 [<c02031e8>] rtc_do_ioctl+0x6c8/0x8a0
 [<c0142a9c>] make_ahead_window+0x7c/0xc0
 [<c0120a4f>] current_fs_time+0x5f/0x70
 [<c013f7d0>] prep_new_page+0x40/0x70
 [<c013fd17>] buffered_rmqueue+0xe7/0x1d0
 [<c0140139>] __alloc_pages+0x269/0x400
 [<c0203710>] rtc_control+0x30/0x70
 [<e2b72067>] rtctimer_start+0x27/0x30 [snd_rtctimer]
 [<e290093e>] snd_timer_start1+0x7e/0xa0 [snd_timer]
 [<e2900a25>] snd_timer_start+0x65/0xa0 [snd_timer]
 [<e2c3ee86>] snd_seq_timer_start+0x36/0x50 [snd_seq]
 [<e2c3da60>] snd_seq_queue_process_event+0xb0/0x100 [snd_seq]
 [<e2c3d41f>] queue_access_lock+0x3f/0x60 [snd_seq]
 [<e2c3dafd>] snd_seq_control_queue+0x4d/0x90 [snd_seq]
 [<e2c39bdf>] snd_seq_deliver_single_event+0x16f/0x180 [snd_seq]
 [<e2c39de4>] snd_seq_deliver_event+0x34/0x50 [snd_seq]
 [<e2c3a036>] snd_seq_client_enqueue_event+0xe6/0x130 [snd_seq]
 [<c01afb8a>] copy_from_user+0x3a/0x80
 [<e2c3a225>] snd_seq_write+0x125/0x1a0 [snd_seq]
 [<c0159390>] vfs_write+0x170/0x180
 [<c0159451>] sys_write+0x41/0x70
 [<c0102e1f>] sysenter_past_esp+0x54/0x75
Code: c3 ba 00 f0 ff ff 21 e2 81 42 14 00 01 00 00 f0 81 28 00 00 00 01 7=
4 05 e8 7c e8 ff ff c3 8d
76 00 f0 fe 08 79 09 f3 90 80 38 00 <7e> f9 eb f2 c3 90 f0 81 28 00 00 00=
 01 74 05 e8 5a e8 ff ff
c3
console shuts up ...

Much more useful :-).

Cheers,
Chris



	=09
___________________________________________________________=20
How much free photo storage do you get? Store your holiday=20
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
