From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
	streaming model
Date: Wed, 21 Dec 2011 16:16:32 +0000
Message-ID: <CAE-xCyM-RZxQHbXUH4aswQS_xraEM-vMVynfDiSsj5ZUyq5Gkw@mail.gmail.com>
References: <1324424088-5705-1-git-send-email-zonque@gmail.com>
	<1324424088-5705-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AB465243C8
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 17:16:33 +0100 (CET)
Received: by vbbfp1 with SMTP id fp1so6109692vbb.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 08:16:32 -0800 (PST)
In-Reply-To: <1324424088-5705-3-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Hello Daniel,

I'm now running this new patch with the kernel git 3.2 rc6.

I do get sound through Alsa and Pulse Audio, but Jackd2 crashes at start.
The same version of jack works on 3.2 rc4 with your previous version
of the patch.

Let me know if there is any other info that I should provide you
outside the dmesg trace below.

In dmesg, I get the following:
[   92.185624] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
[   92.185637] IP: [<ffffffffa05c9768>]
snd_usb_endpoint_activate+0x18/0x90 [snd_usb_audio]
[   92.185655] PGD 13328b067 PUD 10b118067 PMD 0
[   92.185665] Oops: 0000 [#1] PREEMPT SMP
[   92.185673] CPU 0
[   92.185676] Modules linked in: snd_seq_dummy speedstep_lib
parport_pc ppdev binfmt_misc joydev snd_usb_audio arc4 snd_pcm
brcmsmac fglrx(P) snd_page_alloc snd_hwdep mac80211 brcmutil
snd_usbmidi_lib snd_seq_midi snd_rawmidi snd_seq_midi_event cfg80211
snd_seq crc8 i7core_edac edac_core snd_timer snd_seq_device snd cordic
soundcore psmouse serio_raw hp_wmi sparse_keymap lp parport usbhid hid
uvesafb ahci libahci wmi video
[   92.185747]
[   92.185753] Pid: 2282, comm: jackd Tainted: P           O
3.2.0-rc6-music+ #1 Hewlett-Packard HP ENVY 17 Notebook PC/144D
[   92.185764] RIP: 0010:[<ffffffffa05c9768>]  [<ffffffffa05c9768>]
snd_usb_endpoint_activate+0x18/0x90 [snd_usb_audio]
[   92.185779] RSP: 0018:ffff8801101e3ce8  EFLAGS: 00010246
[   92.185784] RAX: 00000000fffffff0 RBX: ffff8801239221e8 RCX: 00000000008=
b5700
[   92.185790] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   92.185796] RBP: ffff8801101e3cf8 R08: ffffea0004785d00 R09: ffffffffa05=
caac2
[   92.185802] R10: 0000000000000001 R11: 0000000000000001 R12: 00000000000=
00000
[   92.185807] R13: ffff880133dd6f38 R14: ffff88011ce6e800 R15: 00000000000=
0bb80
[   92.185815] FS:  00007fd7a8d89740(0000) GS:ffff88013fc00000(0000)
knlGS:0000000000000000
[   92.185821] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   92.185826] CR2: 0000000000000008 CR3: 000000011d416000 CR4: 00000000000=
006f0
[   92.185831] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   92.185836] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[   92.185842] Process jackd (pid: 2282, threadinfo ffff8801101e2000,
task ffff8801101badc0)
[   92.185846] Stack:
[   92.185849]  ffff8801239221e8 ffff880127490f60 ffff8801101e3d58
ffffffffa05d0d1f
[   92.185859]  0000000000000000 0000000000000000 0000000100000001
ffff8801385e3800
[   92.185869]  ffff8801101e3d58 0000000000000000 ffff88013391a200
ffff88011ce6f400
[   92.185878] Call Trace:
[   92.185892]  [<ffffffffa05d0d1f>] snd_usb_hw_params+0x38f/0x5e0
[snd_usb_audio]
[   92.185907]  [<ffffffffa050c4d0>] snd_pcm_hw_params+0xe0/0x3b0 [snd_pcm]
[   92.185919]  [<ffffffffa050d60b>] snd_pcm_common_ioctl1+0x30b/0xcb0 [snd=
_pcm]
[   92.185932]  [<ffffffffa050dffc>] snd_pcm_capture_ioctl1+0x4c/0x240 [snd=
_pcm]
[   92.185942]  [<ffffffff81616f00>] ? do_page_fault+0x210/0x5c0
[   92.185954]  [<ffffffffa050e224>] snd_pcm_capture_ioctl+0x34/0x40 [snd_p=
cm]
[   92.185962]  [<ffffffff81186fef>] do_vfs_ioctl+0x8f/0x500
[   92.185971]  [<ffffffff8117656a>] ? fget_light+0x6a/0x100
[   92.185978]  [<ffffffff811874f1>] sys_ioctl+0x91/0xa0
[   92.185987]  [<ffffffff8161afc2>] system_call_fastpath+0x16/0x1b
[   92.185992] Code: 74 c4 48 89 df e8 99 f1 ff ff 48 83 c4 18 5b 5d
c3 66 90 55 48 89 e5 48 83 ec 10 48 89 5d f0 4c 89 65 f8 66 66 66 66
90 45 31 e4 <8b> 47 08 48 89 fb 85 c0 75 3d 48 8b 07 41 bc f0 ff ff ff
f6 40
[   92.186084] RIP  [<ffffffffa05c9768>]
snd_usb_endpoint_activate+0x18/0x90 [snd_usb_audio]
[   92.186097]  RSP <ffff8801101e3ce8>
[   92.186101] CR2: 0000000000000008
[   92.186151] ---[ end trace aa91e071d7593ce2 ]---




On Tue, Dec 20, 2011 at 11:34 PM, Daniel Mack <zonque@gmail.com> wrote:
> In order to split changes properly, this patch only adds the new
> implementation but leaves the old one around, so the the driver doesn't
> change its behaviour. The switch to actually use the new code is
> submitted separately.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> =A0sound/usb/card.h =A0 =A0 | =A0 58 ++++
> =A0sound/usb/endpoint.c | =A0927 ++++++++++++++++++++++++++++++++++++++++=
+++++++++-
> =A0sound/usb/endpoint.h | =A0 26 ++
> =A0sound/usb/usbaudio.h | =A0 =A01 +
> =A04 files changed, 1001 insertions(+), 11 deletions(-)
>
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index a39edcc..92228f1 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -29,13 +29,17 @@ struct audioformat {
> =A0};
>
> =A0struct snd_usb_substream;
> +struct snd_usb_endpoint;
>
> =A0struct snd_urb_ctx {
> =A0 =A0 =A0 =A0struct urb *urb;
> =A0 =A0 =A0 =A0unsigned int buffer_size; =A0 =A0 =A0 /* size of data buff=
er, if data URB */
> =A0 =A0 =A0 =A0struct snd_usb_substream *subs;
> + =A0 =A0 =A0 struct snd_usb_endpoint *ep;
> =A0 =A0 =A0 =A0int index; =A0 =A0 =A0/* index for urb array */
> =A0 =A0 =A0 =A0int packets; =A0 =A0/* number of packets per urb */
> + =A0 =A0 =A0 int packet_size[MAX_PACKS_HS]; /* size of packets for next =
submission */
> + =A0 =A0 =A0 struct list_head ready_list;
> =A0};
>
> =A0struct snd_urb_ops {
> @@ -45,6 +49,60 @@ struct snd_urb_ops {
> =A0 =A0 =A0 =A0int (*retire_sync)(struct snd_usb_substream *subs, struct =
snd_pcm_runtime *runtime, struct urb *u);
> =A0};
>
> +struct snd_usb_endpoint {
> + =A0 =A0 =A0 struct snd_usb_audio *chip;
> +
> + =A0 =A0 =A0 int use_count;
> + =A0 =A0 =A0 int ep_num; =A0 =A0 =A0 =A0 =A0 =A0 /* the referenced endpo=
int number */
> + =A0 =A0 =A0 int type; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SND_USB_ENDPOINT_T=
YPE_* */
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 void (*prepare_data_urb) (struct snd_usb_substream *subs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
urb *urb);
> + =A0 =A0 =A0 void (*retire_data_urb) (struct snd_usb_substream *subs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct u=
rb *urb);
> +
> + =A0 =A0 =A0 struct snd_usb_substream *data_subs;
> + =A0 =A0 =A0 struct snd_usb_endpoint *sync_master;
> + =A0 =A0 =A0 struct snd_usb_endpoint *sync_slave;
> +
> + =A0 =A0 =A0 struct snd_urb_ctx urb[MAX_URBS];
> +
> + =A0 =A0 =A0 struct snd_usb_packet_info {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t packet_size[MAX_PACKS_HS];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int packets;
> + =A0 =A0 =A0 } next_packet[MAX_URBS];
> + =A0 =A0 =A0 int next_packet_read_pos, next_packet_write_pos;
> + =A0 =A0 =A0 struct list_head ready_playback_urbs;
> +
> + =A0 =A0 =A0 unsigned int nurbs; =A0 =A0 =A0 =A0 =A0 =A0 /* # urbs */
> + =A0 =A0 =A0 unsigned long active_mask; =A0 =A0 =A0/* bitmask of active =
urbs */
> + =A0 =A0 =A0 unsigned long unlink_mask; =A0 =A0 =A0/* bitmask of unlinke=
d urbs */
> + =A0 =A0 =A0 char *syncbuf; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* sync b=
uffer for all sync URBs */
> + =A0 =A0 =A0 dma_addr_t sync_dma; =A0 =A0 =A0 =A0 =A0 =A0/* DMA address =
of syncbuf */
> +
> + =A0 =A0 =A0 unsigned int pipe; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* the data i=
/o pipe */
> + =A0 =A0 =A0 unsigned int freqn; =A0 =A0 =A0 =A0 =A0 =A0 /* nominal samp=
ling rate in fs/fps in Q16.16 format */
> + =A0 =A0 =A0 unsigned int freqm; =A0 =A0 =A0 =A0 =A0 =A0 /* momentary sa=
mpling rate in fs/fps in Q16.16 format */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0freqshift; =A0 =A0 =A0 =A0 =A0 /* how mu=
ch to shift the feedback value to get Q16.16 */
> + =A0 =A0 =A0 unsigned int freqmax; =A0 =A0 =A0 =A0 =A0 /* maximum sampli=
ng rate, used for buffer management */
> + =A0 =A0 =A0 unsigned int phase; =A0 =A0 =A0 =A0 =A0 =A0 /* phase accumu=
lator */
> + =A0 =A0 =A0 unsigned int maxpacksize; =A0 =A0 =A0 /* max packet size in=
 bytes */
> + =A0 =A0 =A0 unsigned int maxframesize; =A0 =A0 =A0/* max packet size in=
 frames */
> + =A0 =A0 =A0 unsigned int curpacksize; =A0 =A0 =A0 /* current packet siz=
e in bytes (for capture) */
> + =A0 =A0 =A0 unsigned int curframesize; =A0 =A0 =A0/* current packet siz=
e in frames (for capture) */
> + =A0 =A0 =A0 unsigned int syncmaxsize; =A0 =A0 =A0 /* sync endpoint pack=
et size */
> + =A0 =A0 =A0 unsigned int fill_max:1; =A0 =A0 =A0 =A0/* fill max packet =
size always */
> + =A0 =A0 =A0 unsigned int datainterval; =A0 =A0 =A0/* log_2 of data pack=
et interval */
> + =A0 =A0 =A0 unsigned int syncinterval; =A0 =A0 =A0/* P for adaptive mod=
e, 0 otherwise */
> + =A0 =A0 =A0 unsigned char silence_value;
> + =A0 =A0 =A0 unsigned int stride;
> + =A0 =A0 =A0 int iface, alt_idx;
> +
> + =A0 =A0 =A0 spinlock_t lock;
> + =A0 =A0 =A0 struct list_head list;
> +};
> +
> =A0struct snd_usb_substream {
> =A0 =A0 =A0 =A0struct snd_usb_stream *stream;
> =A0 =A0 =A0 =A0struct usb_device *dev;
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 81c6ede..3e06fdc 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -19,9 +19,11 @@
> =A0#include <linux/init.h>
> =A0#include <linux/usb.h>
> =A0#include <linux/usb/audio.h>
> +#include <linux/slab.h>
>
> =A0#include <sound/core.h>
> =A0#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
>
> =A0#include "usbaudio.h"
> =A0#include "helper.h"
> @@ -29,6 +31,9 @@
> =A0#include "endpoint.h"
> =A0#include "pcm.h"
>
> +#define EP_FLAG_ACTIVATED =A0 =A0 =A00
> +#define EP_FLAG_RUNNING =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +
> =A0/*
> =A0* convert a sampling rate into our full speed format (fs/1000 in Q16.1=
6)
> =A0* this will overflow at approx 524 kHz
> @@ -50,7 +55,7 @@ static inline unsigned get_usb_high_speed_rate(unsigned=
 int rate)
> =A0/*
> =A0* unlink active urbs.
> =A0*/
> -static int deactivate_urbs(struct snd_usb_substream *subs, int force, in=
t can_sleep)
> +static int deactivate_urbs_old(struct snd_usb_substream *subs, int force=
, int can_sleep)
> =A0{
> =A0 =A0 =A0 =A0struct snd_usb_audio *chip =3D subs->stream->chip;
> =A0 =A0 =A0 =A0unsigned int i;
> @@ -112,7 +117,7 @@ static void release_urb_ctx(struct snd_urb_ctx *u)
> =A0/*
> =A0* =A0wait until all urbs are processed.
> =A0*/
> -static int wait_clear_urbs(struct snd_usb_substream *subs)
> +static int wait_clear_urbs_old(struct snd_usb_substream *subs)
> =A0{
> =A0 =A0 =A0 =A0unsigned long end_time =3D jiffies + msecs_to_jiffies(1000=
);
> =A0 =A0 =A0 =A0unsigned int i;
> @@ -147,8 +152,8 @@ void snd_usb_release_substream_urbs(struct snd_usb_su=
bstream *subs, int force)
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0/* stop urbs (to be sure) */
> - =A0 =A0 =A0 deactivate_urbs(subs, force, 1);
> - =A0 =A0 =A0 wait_clear_urbs(subs);
> + =A0 =A0 =A0 deactivate_urbs_old(subs, force, 1);
> + =A0 =A0 =A0 wait_clear_urbs_old(subs);
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < MAX_URBS; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0release_urb_ctx(&subs->dataurb[i]);
> @@ -163,7 +168,7 @@ void snd_usb_release_substream_urbs(struct snd_usb_su=
bstream *subs, int force)
> =A0/*
> =A0* complete callback from data urb
> =A0*/
> -static void snd_complete_urb(struct urb *urb)
> +static void snd_complete_urb_old(struct urb *urb)
> =A0{
> =A0 =A0 =A0 =A0struct snd_urb_ctx *ctx =3D urb->context;
> =A0 =A0 =A0 =A0struct snd_usb_substream *subs =3D ctx->subs;
> @@ -317,7 +322,7 @@ int snd_usb_init_substream_urbs(struct snd_usb_substr=
eam *subs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u->urb->transfer_flags =3D URB_ISO_ASAP | =
URB_NO_TRANSFER_DMA_MAP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u->urb->interval =3D 1 << subs->datainterv=
al;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u->urb->context =3D u;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->complete =3D snd_complete_urb;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->complete =3D snd_complete_urb_old;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (subs->syncpipe) {
> @@ -855,7 +860,7 @@ static int start_urbs(struct snd_usb_substream *subs,=
 struct snd_pcm_runtime *ru
>
> =A0__error:
> =A0 =A0 =A0 =A0// snd_pcm_stop(subs->pcm_substream, SNDRV_PCM_STATE_XRUN);
> - =A0 =A0 =A0 deactivate_urbs(subs, 0, 0);
> + =A0 =A0 =A0 deactivate_urbs_old(subs, 0, 0);
> =A0 =A0 =A0 =A0return -EPIPE;
> =A0}
>
> @@ -916,7 +921,7 @@ int snd_usb_substream_playback_trigger(struct snd_pcm=
_substream *substream, int
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0subs->ops.prepare =3D prepare_playback_urb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0case SNDRV_PCM_TRIGGER_STOP:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return deactivate_urbs(subs, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return deactivate_urbs_old(subs, 0, 0);
> =A0 =A0 =A0 =A0case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0subs->ops.prepare =3D prepare_nodata_playb=
ack_urb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -934,7 +939,7 @@ int snd_usb_substream_capture_trigger(struct snd_pcm_=
substream *substream, int c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0subs->ops.retire =3D retire_capture_urb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return start_urbs(subs, substream->runtime=
);
> =A0 =A0 =A0 =A0case SNDRV_PCM_TRIGGER_STOP:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return deactivate_urbs(subs, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return deactivate_urbs_old(subs, 0, 0);
> =A0 =A0 =A0 =A0case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0subs->ops.retire =3D retire_paused_capture=
_urb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -950,8 +955,8 @@ int snd_usb_substream_prepare(struct snd_usb_substrea=
m *subs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_pcm=
_runtime *runtime)
> =A0{
> =A0 =A0 =A0 =A0/* clear urbs (to be sure) */
> - =A0 =A0 =A0 deactivate_urbs(subs, 0, 1);
> - =A0 =A0 =A0 wait_clear_urbs(subs);
> + =A0 =A0 =A0 deactivate_urbs_old(subs, 0, 1);
> + =A0 =A0 =A0 wait_clear_urbs_old(subs);
>
> =A0 =A0 =A0 =A0/* for playback, submit the URBs now; otherwise, the first=
 hwptr_done
> =A0 =A0 =A0 =A0 * updates for all URBs would happen at the same time when=
 starting */
> @@ -963,3 +968,903 @@ int snd_usb_substream_prepare(struct snd_usb_substr=
eam *subs,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 return =A0ep->sync_master &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->sync_master->type =3D=3D SND_USB_ENDPOI=
NT_TYPE_DATA &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->type =3D=3D SND_USB_ENDPOINT_TYPE_DATA =
&&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_pipeout(ep->pipe);
> +}
> +
> +/* determine the number of frames in the next packet */
> +static int next_packet_size(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (ep->fill_max)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ep->maxframesize;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&ep->lock, flags);
> + =A0 =A0 =A0 ep->phase =3D (ep->phase & 0xffff)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (ep->freqm << ep->datainterval);
> + =A0 =A0 =A0 ret =3D min(ep->phase >> 16, ep->maxframesize);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&ep->lock, flags);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static void retire_outbound_urb(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_=
urb_ctx *urb_ctx)
> +{
> + =A0 =A0 =A0 if (ep->retire_data_urb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->retire_data_urb(ep->data_subs, urb_ctx-=
>urb);
> +}
> +
> +static void retire_inbound_urb(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_u=
rb_ctx *urb_ctx)
> +{
> + =A0 =A0 =A0 struct urb *urb =3D urb_ctx->urb;
> +
> + =A0 =A0 =A0 if (ep->sync_slave)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_usb_handle_sync_urb(ep->sync_slave, ep,=
 urb);
> +
> + =A0 =A0 =A0 if (ep->retire_data_urb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->retire_data_urb(ep->data_subs, urb);
> +}
> +
> +static void prepare_outbound_urb_sizes(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct snd_urb_ctx *ctx)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ctx->packets; ++i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx->packet_size[i] =3D next_packet_size(ep=
);
> +}
> +
> +/*
> + * Prepare a PLAYBACK urb for submission to the bus.
> + */
> +static void prepare_outbound_urb(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct s=
nd_urb_ctx *ctx)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct urb *urb =3D ctx->urb;
> + =A0 =A0 =A0 unsigned char *cp =3D urb->transfer_buffer;
> +
> + =A0 =A0 =A0 urb->dev =3D ep->chip->dev; /* we need to set this at each =
time */
> +
> + =A0 =A0 =A0 switch (ep->type) {
> + =A0 =A0 =A0 case SND_USB_ENDPOINT_TYPE_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ep->prepare_data_urb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->prepare_data_urb(ep->da=
ta_subs, urb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no data provider, so sen=
d silence */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int offs =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ctx->pack=
ets; ++i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int counts =
=3D ctx->packet_size[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_fr=
ame_desc[i].offset =3D offs * ep->stride;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_fr=
ame_desc[i].length =3D counts * ep->stride;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offs +=3D c=
ounts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->number_of_packets =3D =
ctx->packets;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->transfer_buffer_length=
 =3D offs * ep->stride;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(urb->transfer_buffer=
, ep->silence_value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offs * ep->s=
tride);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case SND_USB_ENDPOINT_TYPE_SYNC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (snd_usb_get_speed(ep->chip->dev) >=3D U=
SB_SPEED_HIGH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fill the length and of=
fset of each urb descriptor.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the fixed 12.13 freque=
ncy is passed as 16.16 through the pipe.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].leng=
th =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].offs=
et =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[0] =3D ep->freqn;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[1] =3D ep->freqn >> 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[2] =3D ep->freqn >> 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[3] =3D ep->freqn >> 24;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fill the length and of=
fset of each urb descriptor.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the fixed 10.14 freque=
ncy is passed through the pipe.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].leng=
th =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].offs=
et =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[0] =3D ep->freqn >> 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[1] =3D ep->freqn >> 10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp[2] =3D ep->freqn >> 18;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +}
> +
> +/*
> + * Prepare a CAPTURE or SYNC urb for submission to the bus.
> + */
> +static inline void prepare_inbound_urb(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct snd_urb_ctx *urb_ctx)
> +{
> + =A0 =A0 =A0 int i, offs;
> + =A0 =A0 =A0 struct urb *urb =3D urb_ctx->urb;
> +
> + =A0 =A0 =A0 urb->dev =3D ep->chip->dev; /* we need to set this at each =
time */
> +
> + =A0 =A0 =A0 switch (ep->type) {
> + =A0 =A0 =A0 case SND_USB_ENDPOINT_TYPE_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offs =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < urb_ctx->packets; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[i].offs=
et =3D offs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[i].leng=
th =3D ep->curpacksize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offs +=3D ep->curpacksize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->transfer_buffer_length =3D offs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->number_of_packets =3D urb_ctx->packets;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case SND_USB_ENDPOINT_TYPE_SYNC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].length =3D min(4u, e=
p->syncmaxsize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].offset =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +}
> +
> +static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&ep->lock, flags);
> +
> + =A0 =A0 =A0 while (test_bit(EP_FLAG_RUNNING, &ep->flags) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0!list_empty(&ep->ready_playback_urbs) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0ep->next_packet_read_pos !=3D ep->next_packe=
t_write_pos) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_usb_packet_info *packet;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_urb_ctx *ctx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct urb *urb;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err, i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet =3D ep->next_packet + ep->next_packe=
t_read_pos;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->next_packet_read_pos++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->next_packet_read_pos %=3D MAX_URBS;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* take URB out of FIFO */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx =3D list_first_entry(&ep->ready_playbac=
k_urbs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct snd_urb_ctx, ready_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&ctx->ready_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb =3D ctx->urb;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* copy over the length information */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < packet->packets; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx->packet_size[i] =3D pac=
ket->packet_size[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_outbound_urb(ep, ctx);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D usb_submit_urb(ctx->urb, GFP_ATOMIC=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "Unable=
 to submit urb #%d: %d (urb %p)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctx-=
>index, err, ctx->urb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(ctx->index, &ep->ac=
tive_mask);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&ep->lock, flags);
> +}
> +
> +/*
> + * complete callback for urbs
> + */
> +static void snd_complete_urb(struct urb *urb)
> +{
> + =A0 =A0 =A0 struct snd_urb_ctx *ctx =3D urb->context;
> + =A0 =A0 =A0 struct snd_usb_endpoint *ep =3D ctx->ep;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 if (unlikely(urb->status =3D=3D -ENOENT || =A0 =A0 =A0 =A0 =
=A0/* unlinked */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urb->status =3D=3D -ENODEV || =
=A0 =A0 =A0 =A0 =A0/* device removed */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urb->status =3D=3D -ECONNRESET |=
| =A0 =A0 =A0/* unlinked */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urb->status =3D=3D -ESHUTDOWN)) =
=A0 =A0 =A0 =A0/* device disabled */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_clear;
> +
> + =A0 =A0 =A0 if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_clear;
> +
> + =A0 =A0 =A0 if (usb_pipeout(ep->pipe)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retire_outbound_urb(ep, ctx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* can be stopped during retire callback */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep=
->flags)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_clear;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (snd_usb_endpoint_implict_feedback_sink(=
ep)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(ctx->index, &ep->=
active_mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ep->lock=
, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&ctx->ready_l=
ist, &ep->ready_playback_urbs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ep-=
>lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_pending_output_urbs(e=
p);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_outbound_urb_sizes(ep, ctx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_outbound_urb(ep, ctx);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retire_inbound_urb(ep, ctx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* can be stopped during retire callback */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep=
->flags)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_clear;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_inbound_urb(ep, ctx);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D usb_submit_urb(urb, GFP_ATOMIC);
> + =A0 =A0 =A0 if (err =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 snd_printk(KERN_ERR "cannot submit urb (err =3D %d)\n", err=
);
> + =A0 =A0 =A0 //snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +
> +exit_clear:
> + =A0 =A0 =A0 clear_bit(ctx->index, &ep->active_mask);
> +}
> +
> +struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct usb_host_interface *alts,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int ep_num, int direction, int type)
> +{
> + =A0 =A0 =A0 struct list_head *p;
> + =A0 =A0 =A0 struct snd_usb_endpoint *ep;
> + =A0 =A0 =A0 int ret, is_playback =3D direction =3D=3D SNDRV_PCM_STREAM_=
PLAYBACK;
> +
> + =A0 =A0 =A0 mutex_lock(&chip->mutex);
> +
> + =A0 =A0 =A0 list_for_each(p, &chip->ep_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep =3D list_entry(p, struct snd_usb_endpoin=
t, list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ep->ep_num =3D=3D ep_num &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->iface =3D=3D alts->desc.bInterf=
aceNumber &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->alt_idx =3D=3D alts->desc.bAlte=
rnateSetting) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printdd(KERN_DEBUG "Re-=
using EP %x in iface %d,%d @%p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ep_num, ep->iface, ep->alt_idx, ep);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto __exit_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 snd_printdd(KERN_DEBUG "Creating new %s %s endpoint #%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_playback ? "playback" : "capture",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D=3D SND_USB_ENDPOINT_TYPE_DA=
TA ? "data" : "sync",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ep_num);
> +
> + =A0 =A0 =A0 /* select the alt setting once so the endpoints become vali=
d */
> + =A0 =A0 =A0 ret =3D usb_set_interface(chip->dev, alts->desc.bInterfaceN=
umber,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alts->desc.=
bAlternateSetting);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "%s(): usb_set_interfac=
e() failed, ret =3D %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto __exit_unlock;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> + =A0 =A0 =A0 if (!ep)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto __exit_unlock;
> +
> + =A0 =A0 =A0 ep->chip =3D chip;
> + =A0 =A0 =A0 spin_lock_init(&ep->lock);
> + =A0 =A0 =A0 ep->type =3D type;
> + =A0 =A0 =A0 ep->ep_num =3D ep_num;
> + =A0 =A0 =A0 ep->iface =3D alts->desc.bInterfaceNumber;
> + =A0 =A0 =A0 ep->alt_idx =3D alts->desc.bAlternateSetting;
> + =A0 =A0 =A0 INIT_LIST_HEAD(&ep->ready_playback_urbs);
> + =A0 =A0 =A0 ep_num &=3D USB_ENDPOINT_NUMBER_MASK;
> +
> + =A0 =A0 =A0 if (is_playback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->pipe =3D usb_sndisocpipe(chip->dev, ep_=
num);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->pipe =3D usb_rcvisocpipe(chip->dev, ep_=
num);
> +
> + =A0 =A0 =A0 if (type =3D=3D SND_USB_ENDPOINT_TYPE_SYNC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (get_endpoint(alts, 1)->bLength >=3D USB=
_DT_ENDPOINT_AUDIO_SIZE &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_endpoint(alts, 1)->bRefresh >=
=3D 1 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_endpoint(alts, 1)->bRefresh <=
=3D 9)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->syncinterval =3D get_en=
dpoint(alts, 1)->bRefresh;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (snd_usb_get_speed(chip->dev) =3D=
=3D USB_SPEED_FULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->syncinterval =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (get_endpoint(alts, 1)->bInterval >=
=3D 1 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_endpoint(alts, 1)->b=
Interval <=3D 16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->syncinterval =3D get_en=
dpoint(alts, 1)->bInterval - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->syncinterval =3D 3;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->syncmaxsize =3D le16_to_cpu(get_endpoin=
t(alts, 1)->wMaxPacketSize);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_add_tail(&ep->list, &chip->ep_list);
> +
> +__exit_unlock:
> + =A0 =A0 =A0 mutex_unlock(&chip->mutex);
> +
> + =A0 =A0 =A0 return ep;
> +}
> +
> +/*
> + * =A0wait until all urbs are processed.
> + */
> +static int wait_clear_urbs(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 unsigned long end_time =3D jiffies + msecs_to_jiffies(1000);
> + =A0 =A0 =A0 unsigned int i;
> + =A0 =A0 =A0 int alive;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alive =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ep->nurbs; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(i, &ep->active=
_mask))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alive++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!alive)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_timeout_uninterruptible(1);
> + =A0 =A0 =A0 } while (time_before(jiffies, end_time));
> +
> + =A0 =A0 =A0 if (alive)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "timeout: still %d acti=
ve urbs on EP #%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 alive, ep->ep_num);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * unlink active urbs.
> + */
> +static int deactivate_urbs(struct snd_usb_endpoint *ep, int force, int c=
an_sleep)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int i;
> + =A0 =A0 =A0 int async;
> +
> + =A0 =A0 =A0 if (!force && ep->chip->shutdown) /* to be sure... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBADFD;
> +
> + =A0 =A0 =A0 async =3D !can_sleep && ep->chip->async_unlink;
> +
> + =A0 =A0 =A0 clear_bit(EP_FLAG_RUNNING, &ep->flags);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&ep->lock, flags);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&ep->ready_playback_urbs);
> + =A0 =A0 =A0 ep->next_packet_read_pos =3D 0;
> + =A0 =A0 =A0 ep->next_packet_write_pos =3D 0;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&ep->lock, flags);
> +
> + =A0 =A0 =A0 if (!async && in_interrupt())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ep->nurbs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(i, &ep->active_mask)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_set_bit(i, &e=
p->unlink_mask)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct urb =
*u =3D ep->urb[i].urb;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (async)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 usb_unlink_urb(u);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 usb_kill_urb(u);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * release an endpoint's urbs
> + */
> +static void release_urbs(struct snd_usb_endpoint *ep, int force)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* route incoming urbs to nirvana */
> + =A0 =A0 =A0 ep->retire_data_urb =3D NULL;
> + =A0 =A0 =A0 ep->prepare_data_urb =3D NULL;
> +
> + =A0 =A0 =A0 /* stop urbs */
> + =A0 =A0 =A0 deactivate_urbs(ep, force, 1);
> + =A0 =A0 =A0 wait_clear_urbs(ep);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ep->nurbs; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_urb_ctx(&ep->urb[i]);
> +
> + =A0 =A0 =A0 if (ep->syncbuf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_free_coherent(ep->chip->dev, SYNC_URBS =
* 4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->syn=
cbuf, ep->sync_dma);
> +
> + =A0 =A0 =A0 ep->syncbuf =3D NULL;
> + =A0 =A0 =A0 ep->nurbs =3D 0;
> +}
> +
> +static int data_ep_set_params(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_pcm_=
hw_params *hw_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct audiofor=
mat *fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_usb_=
endpoint *sync_ep)
> +{
> + =A0 =A0 =A0 unsigned int maxsize, i, urb_packs, total_packs, packs_per_=
ms;
> + =A0 =A0 =A0 int period_bytes =3D params_period_bytes(hw_params);
> + =A0 =A0 =A0 int format =3D params_format(hw_params);
> + =A0 =A0 =A0 int is_playback =3D usb_pipeout(ep->pipe);
> + =A0 =A0 =A0 int frame_bits =3D snd_pcm_format_physical_width(params_for=
mat(hw_params)) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 params_channels(hw_params);
> +
> + =A0 =A0 =A0 ep->datainterval =3D fmt->datainterval;
> + =A0 =A0 =A0 ep->stride =3D frame_bits >> 3;
> + =A0 =A0 =A0 ep->silence_value =3D format =3D=3D SNDRV_PCM_FORMAT_U8 ? 0=
x80 : 0;
> +
> + =A0 =A0 =A0 /* calculate max. frequency */
> + =A0 =A0 =A0 if (ep->maxpacksize) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* whatever fits into a max. size packet */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 maxsize =3D ep->maxpacksize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqmax =3D (maxsize / (frame_bits >> 3=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << (16 - ep=
->datainterval);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no max. packet size: just take 25% highe=
r than nominal */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqmax =3D ep->freqn + (ep->freqn >> 2=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 maxsize =3D ((ep->freqmax + 0xffff) * (fram=
e_bits >> 3))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> (16 - ep=
->datainterval);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (ep->fill_max)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->curpacksize =3D ep->maxpacksize;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->curpacksize =3D maxsize;
> +
> + =A0 =A0 =A0 if (snd_usb_get_speed(ep->chip->dev) !=3D USB_SPEED_FULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packs_per_ms =3D 8 >> ep->datainterval;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packs_per_ms =3D 1;
> +
> + =A0 =A0 =A0 if (is_playback && !snd_usb_endpoint_implict_feedback_sink(=
ep)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_packs =3D max(ep->chip->nrpacks, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_packs =3D min(urb_packs, (unsigned int)=
 MAX_PACKS);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_packs =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 urb_packs *=3D packs_per_ms;
> +
> + =A0 =A0 =A0 if (sync_ep && !snd_usb_endpoint_implict_feedback_sink(ep))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_packs =3D min(urb_packs, 1U << sync_ep-=
>syncinterval);
> +
> + =A0 =A0 =A0 /* decide how many packets to be used */
> + =A0 =A0 =A0 if (is_playback && !snd_usb_endpoint_implict_feedback_sink(=
ep)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int minsize, maxpacks;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* determine how small a packet can be */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 minsize =3D (ep->freqn >> (16 - ep->dataint=
erval))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * (frame_bits >> 3);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* with sync from device, assume it can be =
12% lower */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sync_ep)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 minsize -=3D minsize >> 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 minsize =3D max(minsize, 1u);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 total_packs =3D (period_bytes + minsize - 1=
) / minsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we need at least two URBs for queueing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (total_packs < 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 total_packs =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* and we don't want too lo=
ng a queue either */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 maxpacks =3D max(MAX_QUEUE =
* packs_per_ms, urb_packs * 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 total_packs =3D min(total_p=
acks, maxpacks);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (urb_packs > 1 && urb_packs * maxsize=
 >=3D period_bytes)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_packs >>=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 total_packs =3D MAX_URBS * urb_packs;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ep->nurbs =3D (total_packs + urb_packs - 1) / urb_packs;
> + =A0 =A0 =A0 if (ep->nurbs > MAX_URBS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* too much... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->nurbs =3D MAX_URBS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 total_packs =3D MAX_URBS * urb_packs;
> + =A0 =A0 =A0 } else if (ep->nurbs < 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* too little - we need at least two packets
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to ensure contiguous playback/capture
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->nurbs =3D 2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* allocate and initialize data urbs */
> + =A0 =A0 =A0 for (i =3D 0; i < ep->nurbs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_urb_ctx *u =3D &ep->urb[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->index =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->ep =3D ep;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->packets =3D (i + 1) * total_packs / ep->=
nurbs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - i * total_packs / ep->nur=
bs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->buffer_size =3D maxsize * u->packets;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fmt->fmt_type =3D=3D UAC_FORMAT_TYPE_II)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->packets++; /* for transf=
er delimiter */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb =3D usb_alloc_urb(u->packets, GFP_KE=
RNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!u->urb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_of_memory;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->transfer_buffer =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_alloc_coherent(ep->chip=
->dev, u->buffer_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GFP_KERNEL, &u->urb->transfer_dma);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!u->urb->transfer_buffer)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_of_memory;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->pipe =3D ep->pipe;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->transfer_flags =3D URB_ISO_ASAP | U=
RB_NO_TRANSFER_DMA_MAP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->interval =3D 1 << ep->datainterval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->context =3D u;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->complete =3D snd_complete_urb;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_of_memory:
> + =A0 =A0 =A0 release_urbs(ep, 0);
> + =A0 =A0 =A0 return -ENOMEM;
> +}
> +
> +static int sync_ep_set_params(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_pcm_=
hw_params *hw_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct audiofor=
mat *fmt)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 ep->syncbuf =3D usb_alloc_coherent(ep->chip->dev, SYNC_URBS=
 * 4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0GFP_KERNEL, &ep->sync_dma);
> + =A0 =A0 =A0 if (!ep->syncbuf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < SYNC_URBS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_urb_ctx *u =3D &ep->urb[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->index =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->ep =3D ep;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->packets =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb =3D usb_alloc_urb(1, GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!u->urb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_of_memory;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->transfer_buffer =3D ep->syncbuf + i=
 * 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->transfer_dma =3D ep->sync_dma + i *=
 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->transfer_buffer_length =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->pipe =3D ep->pipe;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->transfer_flags =3D URB_ISO_ASAP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0URB_NO_TRANSFER_DMA_MAP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->number_of_packets =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->interval =3D 1 << ep->syncinterval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->context =3D u;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u->urb->complete =3D snd_complete_urb;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ep->nurbs =3D SYNC_URBS;
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_of_memory:
> + =A0 =A0 =A0 release_urbs(ep, 0);
> + =A0 =A0 =A0 return -ENOMEM;
> +}
> +
> +int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_=
pcm_hw_params *hw_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct audi=
oformat *fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_=
usb_endpoint *sync_ep)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 if (ep->use_count !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_WARNING "Unable to change f=
ormat on ep #%x: already in use\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ep->ep_num);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* release old buffers, if any */
> + =A0 =A0 =A0 release_urbs(ep, 0);
> +
> + =A0 =A0 =A0 ep->datainterval =3D fmt->datainterval;
> + =A0 =A0 =A0 ep->maxpacksize =3D fmt->maxpacksize;
> + =A0 =A0 =A0 ep->fill_max =3D fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX;
> +
> + =A0 =A0 =A0 if (snd_usb_get_speed(ep->chip->dev) =3D=3D USB_SPEED_FULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqn =3D get_usb_full_speed_rate(param=
s_rate(hw_params));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqn =3D get_usb_high_speed_rate(param=
s_rate(hw_params));
> +
> + =A0 =A0 =A0 /* calculate the frequency in 16.16 format */
> + =A0 =A0 =A0 ep->freqm =3D ep->freqn;
> + =A0 =A0 =A0 ep->freqshift =3D INT_MIN;
> +
> + =A0 =A0 =A0 ep->phase =3D 0;
> +
> + =A0 =A0 =A0 switch (ep->type) {
> + =A0 =A0 =A0 case =A0SND_USB_ENDPOINT_TYPE_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D data_ep_set_params(ep, hw_params, f=
mt, sync_ep);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case =A0SND_USB_ENDPOINT_TYPE_SYNC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D sync_ep_set_params(ep, hw_params, f=
mt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 snd_printdd(KERN_DEBUG "Setting params for ep #%x (type %d,=
 %d urbs), ret=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ep->ep_num, ep->type, ep->nurbs, err=
);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 unsigned int i;
> +
> + =A0 =A0 =A0 if (ep->chip->shutdown)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBADFD;
> +
> + =A0 =A0 =A0 /* already running? */
> + =A0 =A0 =A0 if (++ep->use_count !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* just to be sure */
> + =A0 =A0 =A0 deactivate_urbs(ep, 0, 1);
> + =A0 =A0 =A0 wait_clear_urbs(ep);
> +
> + =A0 =A0 =A0 ep->active_mask =3D 0;
> + =A0 =A0 =A0 ep->unlink_mask =3D 0;
> + =A0 =A0 =A0 ep->phase =3D 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If this endpoint has a data endpoint as implicit feedb=
ack source,
> + =A0 =A0 =A0 =A0* don't start the urbs here. Instead, mark them all as a=
vailable,
> + =A0 =A0 =A0 =A0* wait for the record urbs to arrive and queue from that=
 context.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 set_bit(EP_FLAG_RUNNING, &ep->flags);
> +
> + =A0 =A0 =A0 if (snd_usb_endpoint_implict_feedback_sink(ep)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ep->nurbs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_urb_ctx *ctx =3D=
 ep->urb + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&ctx->ready_l=
ist, &ep->ready_playback_urbs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ep->nurbs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct urb *urb =3D ep->urb[i].urb;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (snd_BUG_ON(!urb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto __error;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usb_pipeout(ep->pipe)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_outbound_urb_sizes(=
ep, urb->context);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_outbound_urb(ep, ur=
b->context);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prepare_inbound_urb(ep, urb=
->context);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D usb_submit_urb(urb, GFP_ATOMIC);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "cannot=
 submit urb %d, error %d: %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i, e=
rr, usb_error_string(err));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto __error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(i, &ep->active_mask);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +__error:
> + =A0 =A0 =A0 clear_bit(EP_FLAG_RUNNING, &ep->flags);
> + =A0 =A0 =A0 ep->use_count--;
> + =A0 =A0 =A0 deactivate_urbs(ep, 0, 0);
> + =A0 =A0 =A0 return -EPIPE;
> +}
> +
> +void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int force, int can_s=
leep, int wait)
> +{
> + =A0 =A0 =A0 if (!ep)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (snd_BUG_ON(ep->use_count =3D=3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (--ep->use_count =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deactivate_urbs(ep, force, can_sleep);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->data_subs =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->sync_slave =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->retire_data_urb =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->prepare_data_urb =3D NULL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wait)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_clear_urbs(ep);
> + =A0 =A0 =A0 }
> +}
> +
> +int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 if (ep->use_count !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (!ep->chip->shutdown &&
> + =A0 =A0 =A0 =A0 =A0 !test_and_set_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D usb_set_interface(ep->chip->dev, ep=
->iface, ep->alt_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "%s() u=
sb_set_interface() failed, ret =3D %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 __func__, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(EP_FLAG_ACTIVATED=
, &ep->flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EBUSY;
> +}
> +
> +int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
> +{
> + =A0 =A0 =A0 if (!ep)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (ep->use_count !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (!ep->chip->shutdown &&
> + =A0 =A0 =A0 =A0 =A0 test_and_clear_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D usb_set_interface(ep->chip->dev, ep=
->iface, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "%s(): =
usb_set_interface() failed, ret =3D %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 __func__, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EBUSY;
> +}
> +
> +void snd_usb_endpoint_free(struct list_head *head)
> +{
> + =A0 =A0 =A0 struct snd_usb_endpoint *ep;
> +
> + =A0 =A0 =A0 ep =3D list_entry(head, struct snd_usb_endpoint, list);
> + =A0 =A0 =A0 release_urbs(ep, 1);
> + =A0 =A0 =A0 kfree(ep);
> +}
> +
> +/*
> + * process after playback sync complete
> + *
> + * Full speed devices report feedback values in 10.14 format as samples =
per
> + * frame, high speed devices in 16.16 format as samples per microframe.
> + * Because the Audio Class 1 spec was written before USB 2.0, many high =
speed
> + * devices use a wrong interpretation, some others use an entirely diffe=
rent
> + * format. =A0Therefore, we cannot predict what format any particular de=
vice uses
> + * and must detect it automatically.
> + */
> +void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_usb_e=
ndpoint *sender,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct urb=
 *urb)
> +{
> + =A0 =A0 =A0 int shift;
> + =A0 =A0 =A0 unsigned int f;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 snd_BUG_ON(ep =3D=3D sender);
> +
> + =A0 =A0 =A0 if (snd_usb_endpoint_implict_feedback_sink(ep) &&
> + =A0 =A0 =A0 =A0 =A0 ep->use_count !=3D 0) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* implicit feedback case */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i, bytes =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_urb_ctx *in_ctx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_usb_packet_info *out_packet;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_ctx =3D urb->context;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Count overall packet size */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < in_ctx->packets; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (urb->iso_frame_desc[i].=
status =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes +=3D =
urb->iso_frame_desc[i].actual_length;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* skip empty packets. At least M-Audio's=
 Fast Track Ultra stops
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* streaming once it received a 0-byte OU=
T URB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bytes =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ep->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_packet =3D ep->next_packet + ep->next_p=
acket_write_pos;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Iterate through the inbound packet and=
 prepare the lengths
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for the output packet. The OUT packet =
we are about to send
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* will have the same amount of payload t=
han the IN packet we
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* just received.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_packet->packets =3D in_ctx->packets;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < in_ctx->packets; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (urb->iso_frame_desc[i].=
status =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_packet-=
>packet_size[i] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 urb->iso_frame_desc[i].actual_length / ep->stride;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_packet-=
>packet_size[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->next_packet_write_pos++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->next_packet_write_pos %=3D MAX_URBS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ep->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_pending_output_urbs(ep);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (urb->iso_frame_desc[0].status !=3D 0 ||
> + =A0 =A0 =A0 =A0 =A0 urb->iso_frame_desc[0].actual_length < 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 f =3D le32_to_cpup(urb->transfer_buffer);
> + =A0 =A0 =A0 if (urb->iso_frame_desc[0].actual_length =3D=3D 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f &=3D 0x00ffffff;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f &=3D 0x0fffffff;
> +
> + =A0 =A0 =A0 if (f =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (unlikely(ep->freqshift =3D=3D INT_MIN)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The first time we see a feedback value=
, determine its format
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* by shifting it left or right until it =
matches the nominal
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* frequency value. =A0This assumes that =
the feedback does not
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* differ from the nominal value more tha=
n +50% or -25%.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (f < ep->freqn - ep->freqn / 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f <<=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (f > ep->freqn + ep->freqn / 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f >>=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqshift =3D shift;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if (ep->freqshift >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f <<=3D ep->freqshift;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f >>=3D -ep->freqshift;
> +
> + =A0 =A0 =A0 if (likely(f >=3D ep->freqn - ep->freqn / 8 && f <=3D ep->f=
reqmax)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the frequency looks valid, set it.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This value is referred to in prepare_p=
layback_urb().
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ep->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqm =3D f;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ep->lock, flags);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Out of range; maybe the shift value is=
 wrong.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Reset it so that we autodetect again t=
he next time.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->freqshift =3D INT_MIN;
> + =A0 =A0 =A0 }
> +}
> +
> diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
> index 88eb63a..9f083d7 100644
> --- a/sound/usb/endpoint.h
> +++ b/sound/usb/endpoint.h
> @@ -18,4 +18,30 @@ int snd_usb_substream_prepare(struct snd_usb_substream=
 *subs,
> =A0int snd_usb_substream_playback_trigger(struct snd_pcm_substream *subst=
ream, int cmd);
> =A0int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substr=
eam, int cmd);
>
> +
> +#define SND_USB_ENDPOINT_TYPE_DATA =A0 =A0 0
> +#define SND_USB_ENDPOINT_TYPE_SYNC =A0 =A0 1
> +
> +struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct usb_host_interface *alts,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 int ep_num, int direction, int type);
> +
> +int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_=
pcm_hw_params *hw_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct audi=
oformat *fmt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_=
usb_endpoint *sync_ep);
> +
> +int =A0snd_usb_endpoint_start(struct snd_usb_endpoint *ep);
> +void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int force, int can_s=
leep, int wait);
> +int =A0snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
> +int =A0snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
> +void snd_usb_endpoint_free(struct list_head *head);
> +
> +int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep);
> +
> +void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_usb_e=
ndpoint *sender,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct urb=
 *urb);
> +
> =A0#endif /* __USBAUDIO_ENDPOINT_H */
> diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
> index a16c21d..b8233eb 100644
> --- a/sound/usb/usbaudio.h
> +++ b/sound/usb/usbaudio.h
> @@ -47,6 +47,7 @@ struct snd_usb_audio {
> =A0 =A0 =A0 =A0int num_suspended_intf;
>
> =A0 =A0 =A0 =A0struct list_head pcm_list; =A0 =A0 =A0/* list of pcm strea=
ms */
> + =A0 =A0 =A0 struct list_head ep_list; =A0 =A0 =A0 /* list of audio-rela=
ted endpoints */
> =A0 =A0 =A0 =A0int pcm_devs;
>
> =A0 =A0 =A0 =A0struct list_head midi_list; =A0 =A0 /* list of midi interf=
aces */
> --
> 1.7.5.4
>
