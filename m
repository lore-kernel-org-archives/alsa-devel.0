From: noreply@alsa-project.org
Subject: [ALSA - driver 0000344]: usx2y driver causes kernel oops
Date: Thu, 24 Jun 2004 22:17:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <b2e60c22ec9539246b9bd4285e358ea7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0344
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                maggoi
Assigned To:                karsten
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     344
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             06-24-2004 18:06 CEST
Last Modified:              06-24-2004 22:17 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    usx2y driver causes kernel oops
Description:=20
While playing a soundfile using my Tascam us-122 (Alsa Module snd-usx2y)
after a few seconds the sound stutters and i get an Kernel oops.=20
This is not happening if I use Jack.
I'm using the latest alsa drivers 1.0.5. With kernel 2.6.6.=20

dmesg:
Debug: sleeping function called from invalid context at mm/slab.c:1996
in_atomic():1, irqs_disabled():1
 [<c01152f7>] __might_sleep+0xb7/0xe0
 [<c013be33>] __kmalloc+0xa3/0xb0
 [<c026dad1>] usb_alloc_urb+0x21/0x60
 [<f89b3775>] snd_usX2Y_substream_prepare+0xd5/0x1c0 [snd_usb_usx2y]
 [<f89b3397>] snd_usX2Y_urb_play_start+0xa7/0x170 [snd_usb_usx2y]
 [<f89b35bf>] snd_usX2Y_pcm_play_trigger+0x3f/0x50 [snd_usb_usx2y]
 [<f89490e8>] snd_pcm_do_start+0x28/0x30 [snd_pcm]
 [<f8948dc9>] snd_pcm_action_single+0x39/0x70 [snd_pcm]
 [<f8948f12>] snd_pcm_action_lock_irq+0x92/0x1e0 [snd_pcm]
 [<c0112a8c>] do_page_fault+0x34c/0x54e
 [<f894c4d7>] snd_pcm_common_ioctl1+0x167/0x2f0 [snd_pcm]
 [<f894c6c0>] snd_pcm_playback_ioctl1+0x60/0x3b0 [snd_pcm]
 [<c0150a32>] vfs_write+0xd2/0x130
 [<c0162f20>] sys_ioctl+0x100/0x270
 [<c010413b>] syscall_call+0x7/0xb



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 karsten - 06-24-2004 22:17 CEST=20
----------------------------------------------------------------------
As a test please replace all occurrences of GFP_KERNEL in=20
function snd_usX2Y_substream_prepare() with GFP_ATOMIC.
That function is in alsa-driver/usb/usx2y/usbusx2yaudio.c.

Thanks for debugging.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
06-24-04 18:06 maggoi         New Bug                                    =
 =20
06-24-04 18:06 maggoi         Distribution              =3D> Gentoo      =
   =20
06-24-04 18:06 maggoi         Kernel Version            =3D> 2.6.6       =
   =20
06-24-04 22:17 karsten        Bugnote Added: 0001337                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
