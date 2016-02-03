From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: another WARNING in rawmidi_transmit_ack
Date: Wed, 3 Feb 2016 14:21:05 +0100
Message-ID: <CACT4Y+a5QDesu0E=DT2-On4H6VfTXjPeYVNxm8ekrchuA1BP7g@mail.gmail.com>
References: <CACT4Y+acG4iyphdOZx47Nyq_VHGbpJQK-6xNpiqUjaZYqsXOGw@mail.gmail.com>
 <s5hy4b4myqm.wl-tiwai@suse.de> <CACT4Y+bbeQKVNueT6iHdvruWj64hp4sYNOYZCvxagZBXtmn20Q@mail.gmail.com>
 <s5hk2mm464o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk2mm464o.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 3, 2016 at 8:15 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 02 Feb 2016 22:59:49 +0100,
> Dmitry Vyukov wrote:
>>
>> On Mon, Feb 1, 2016 at 12:55 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Mon, 01 Feb 2016 12:31:20 +0100,
>> > Dmitry Vyukov wrote:
>> >>
>> >> Hello,
>> >>
>> >> The following program triggers a splash of WARNINGs in rawmidi_transmit_ack.
>> >> Takashi, I am on commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3 + a
>> >> bunch of your recent fixes:
>> >> https://gist.githubusercontent.com/dvyukov/40640128a433ad16a56a/raw/ab3a08637ce3654b969b778c5700fe4a80f14456/gistfile1.txt
>> >
>> > Ouch, this is another spot with an open race between
>> > snd_rawmidi_transmit_peek() and snd_rawmidi_transmit_ack().
>> >
>> > Could you drop the previous fix and apply the one below instead?
>> >
>> > FWIW, I pushed sound.git tree topic/core-fixes branch containing all
>> > pending fixes.  This should be pullable cleanly onto 4.5-rc1/rc2.
>> >  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/core-fixes
>> >
>> >
>> > Thanks!
>> >
>> > Takashi
>>
>>
>> Now this program hangs the machine with:
>
> Mea culpa, the spinlock was applied at the wrong place.
> Below is the revised patch.  I updated topic/core-fixes branch as
> well.


re-applied
the reproducer does not trigger any issues now



>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: rawmidi: Make snd_rawmidi_transmit() race-free
>
> A kernel WARNING in snd_rawmidi_transmit_ack() is triggered by
> syzkaller fuzzer:
>   WARNING: CPU: 1 PID: 20739 at sound/core/rawmidi.c:1136
> Call Trace:
>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>  [<ffffffff82999e2d>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
>  [<ffffffff81352089>] warn_slowpath_common+0xd9/0x140 kernel/panic.c:482
>  [<ffffffff813522b9>] warn_slowpath_null+0x29/0x30 kernel/panic.c:515
>  [<ffffffff84f80bd5>] snd_rawmidi_transmit_ack+0x275/0x400 sound/core/rawmidi.c:1136
>  [<ffffffff84fdb3c1>] snd_virmidi_output_trigger+0x4b1/0x5a0 sound/core/seq/seq_virmidi.c:163
>  [<     inline     >] snd_rawmidi_output_trigger sound/core/rawmidi.c:150
>  [<ffffffff84f87ed9>] snd_rawmidi_kernel_write1+0x549/0x780 sound/core/rawmidi.c:1223
>  [<ffffffff84f89fd3>] snd_rawmidi_write+0x543/0xb30 sound/core/rawmidi.c:1273
>  [<ffffffff817b0323>] __vfs_write+0x113/0x480 fs/read_write.c:528
>  [<ffffffff817b1db7>] vfs_write+0x167/0x4a0 fs/read_write.c:577
>  [<     inline     >] SYSC_write fs/read_write.c:624
>  [<ffffffff817b50a1>] SyS_write+0x111/0x220 fs/read_write.c:616
>  [<ffffffff86336c36>] entry_SYSCALL_64_fastpath+0x16/0x7a arch/x86/entry/entry_64.S:185
>
> Also a similar warning is found but in another path:
> Call Trace:
>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>  [<ffffffff82be2c0d>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
>  [<ffffffff81355139>] warn_slowpath_common+0xd9/0x140 kernel/panic.c:482
>  [<ffffffff81355369>] warn_slowpath_null+0x29/0x30 kernel/panic.c:515
>  [<ffffffff8527e69a>] rawmidi_transmit_ack+0x24a/0x3b0 sound/core/rawmidi.c:1133
>  [<ffffffff8527e851>] snd_rawmidi_transmit_ack+0x51/0x80 sound/core/rawmidi.c:1163
>  [<ffffffff852d9046>] snd_virmidi_output_trigger+0x2b6/0x570 sound/core/seq/seq_virmidi.c:185
>  [<     inline     >] snd_rawmidi_output_trigger sound/core/rawmidi.c:150
>  [<ffffffff85285a0b>] snd_rawmidi_kernel_write1+0x4bb/0x760 sound/core/rawmidi.c:1252
>  [<ffffffff85287b73>] snd_rawmidi_write+0x543/0xb30 sound/core/rawmidi.c:1302
>  [<ffffffff817ba5f3>] __vfs_write+0x113/0x480 fs/read_write.c:528
>  [<ffffffff817bc087>] vfs_write+0x167/0x4a0 fs/read_write.c:577
>  [<     inline     >] SYSC_write fs/read_write.c:624
>  [<ffffffff817bf371>] SyS_write+0x111/0x220 fs/read_write.c:616
>  [<ffffffff86660276>] entry_SYSCALL_64_fastpath+0x16/0x7a arch/x86/entry/entry_64.S:185
>
> In the former case, the reason is that virmidi has an open code
> calling snd_rawmidi_transmit_ack() with the value calculated outside
> the spinlock.   We may use snd_rawmidi_transmit() in a loop just for
> consuming the input data, but even there, there is a race between
> snd_rawmidi_transmit_peek() and snd_rawmidi_tranmit_ack().
>
> Similarly in the latter case, it calls snd_rawmidi_transmit_peek() and
> snd_rawmidi_tranmit_ack() separately without protection, so they are
> racy as well.
>
> The patch tries to address these issues by the following ways:
> - Introduce the unlocked versions of snd_rawmidi_transmit_peek() and
>   snd_rawmidi_transmit_ack() to be called inside the explicit lock.
> - Rewrite snd_rawmidi_transmit() to be race-free (the former case).
> - Make the split calls (the latter case) protected in the rawmidi spin
>   lock.
>
> BugLink: http://lkml.kernel.org/r/CACT4Y+YPq1+cYLkadwjWa5XjzF1_Vki1eHnVn-Lm0hzhSpu5PA@mail.gmail.com
> BugLink: http://lkml.kernel.org/r/CACT4Y+acG4iyphdOZx47Nyq_VHGbpJQK-6xNpiqUjaZYqsXOGw@mail.gmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/sound/rawmidi.h      |  4 ++
>  sound/core/rawmidi.c         | 98 ++++++++++++++++++++++++++++++++------------
>  sound/core/seq/seq_virmidi.c | 17 +++++---
>  3 files changed, 88 insertions(+), 31 deletions(-)
>
> diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
> index fdabbb4ddba9..f730b91e472f 100644
> --- a/include/sound/rawmidi.h
> +++ b/include/sound/rawmidi.h
> @@ -167,6 +167,10 @@ int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
>  int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count);
>  int snd_rawmidi_transmit(struct snd_rawmidi_substream *substream,
>                          unsigned char *buffer, int count);
> +int __snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
> +                             unsigned char *buffer, int count);
> +int __snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream,
> +                              int count);
>
>  /* main midi functions */
>
> diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
> index f75d1656272c..26ca02248885 100644
> --- a/sound/core/rawmidi.c
> +++ b/sound/core/rawmidi.c
> @@ -1055,23 +1055,16 @@ int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream)
>  EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
>
>  /**
> - * snd_rawmidi_transmit_peek - copy data from the internal buffer
> + * __snd_rawmidi_transmit_peek - copy data from the internal buffer
>   * @substream: the rawmidi substream
>   * @buffer: the buffer pointer
>   * @count: data size to transfer
>   *
> - * Copies data from the internal output buffer to the given buffer.
> - *
> - * Call this in the interrupt handler when the midi output is ready,
> - * and call snd_rawmidi_transmit_ack() after the transmission is
> - * finished.
> - *
> - * Return: The size of copied data, or a negative error code on failure.
> + * This is a variant of snd_rawmidi_transmit_peek() without spinlock.
>   */
> -int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
> +int __snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
>                               unsigned char *buffer, int count)
>  {
> -       unsigned long flags;
>         int result, count1;
>         struct snd_rawmidi_runtime *runtime = substream->runtime;
>
> @@ -1081,7 +1074,6 @@ int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
>                 return -EINVAL;
>         }
>         result = 0;
> -       spin_lock_irqsave(&runtime->lock, flags);
>         if (runtime->avail >= runtime->buffer_size) {
>                 /* warning: lowlevel layer MUST trigger down the hardware */
>                 goto __skip;
> @@ -1106,25 +1098,47 @@ int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
>                 }
>         }
>        __skip:
> +       return result;
> +}
> +EXPORT_SYMBOL(__snd_rawmidi_transmit_peek);
> +
> +/**
> + * snd_rawmidi_transmit_peek - copy data from the internal buffer
> + * @substream: the rawmidi substream
> + * @buffer: the buffer pointer
> + * @count: data size to transfer
> + *
> + * Copies data from the internal output buffer to the given buffer.
> + *
> + * Call this in the interrupt handler when the midi output is ready,
> + * and call snd_rawmidi_transmit_ack() after the transmission is
> + * finished.
> + *
> + * Return: The size of copied data, or a negative error code on failure.
> + */
> +int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
> +                             unsigned char *buffer, int count)
> +{
> +       struct snd_rawmidi_runtime *runtime = substream->runtime;
> +       int result;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&runtime->lock, flags);
> +       result = __snd_rawmidi_transmit_peek(substream, buffer, count);
>         spin_unlock_irqrestore(&runtime->lock, flags);
>         return result;
>  }
>  EXPORT_SYMBOL(snd_rawmidi_transmit_peek);
>
>  /**
> - * snd_rawmidi_transmit_ack - acknowledge the transmission
> + * __snd_rawmidi_transmit_ack - acknowledge the transmission
>   * @substream: the rawmidi substream
>   * @count: the transferred count
>   *
> - * Advances the hardware pointer for the internal output buffer with
> - * the given size and updates the condition.
> - * Call after the transmission is finished.
> - *
> - * Return: The advanced size if successful, or a negative error code on failure.
> + * This is a variant of __snd_rawmidi_transmit_ack() without spinlock.
>   */
> -int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
> +int __snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
>  {
> -       unsigned long flags;
>         struct snd_rawmidi_runtime *runtime = substream->runtime;
>
>         if (runtime->buffer == NULL) {
> @@ -1132,7 +1146,6 @@ int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
>                           "snd_rawmidi_transmit_ack: output is not active!!!\n");
>                 return -EINVAL;
>         }
> -       spin_lock_irqsave(&runtime->lock, flags);
>         snd_BUG_ON(runtime->avail + count > runtime->buffer_size);
>         runtime->hw_ptr += count;
>         runtime->hw_ptr %= runtime->buffer_size;
> @@ -1142,9 +1155,32 @@ int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
>                 if (runtime->drain || snd_rawmidi_ready(substream))
>                         wake_up(&runtime->sleep);
>         }
> -       spin_unlock_irqrestore(&runtime->lock, flags);
>         return count;
>  }
> +EXPORT_SYMBOL(__snd_rawmidi_transmit_ack);
> +
> +/**
> + * snd_rawmidi_transmit_ack - acknowledge the transmission
> + * @substream: the rawmidi substream
> + * @count: the transferred count
> + *
> + * Advances the hardware pointer for the internal output buffer with
> + * the given size and updates the condition.
> + * Call after the transmission is finished.
> + *
> + * Return: The advanced size if successful, or a negative error code on failure.
> + */
> +int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
> +{
> +       struct snd_rawmidi_runtime *runtime = substream->runtime;
> +       int result;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&runtime->lock, flags);
> +       result = __snd_rawmidi_transmit_ack(substream, count);
> +       spin_unlock_irqrestore(&runtime->lock, flags);
> +       return result;
> +}
>  EXPORT_SYMBOL(snd_rawmidi_transmit_ack);
>
>  /**
> @@ -1160,12 +1196,22 @@ EXPORT_SYMBOL(snd_rawmidi_transmit_ack);
>  int snd_rawmidi_transmit(struct snd_rawmidi_substream *substream,
>                          unsigned char *buffer, int count)
>  {
> +       struct snd_rawmidi_runtime *runtime = substream->runtime;
> +       int result;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&runtime->lock, flags);
>         if (!substream->opened)
> -               return -EBADFD;
> -       count = snd_rawmidi_transmit_peek(substream, buffer, count);
> -       if (count < 0)
> -               return count;
> -       return snd_rawmidi_transmit_ack(substream, count);
> +               result = -EBADFD;
> +       else {
> +               count = __snd_rawmidi_transmit_peek(substream, buffer, count);
> +               if (count <= 0)
> +                       result = count;
> +               else
> +                       result = __snd_rawmidi_transmit_ack(substream, count);
> +       }
> +       spin_unlock_irqrestore(&runtime->lock, flags);
> +       return result;
>  }
>  EXPORT_SYMBOL(snd_rawmidi_transmit);
>
> diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
> index f71aedfb408c..c82ed3e70506 100644
> --- a/sound/core/seq/seq_virmidi.c
> +++ b/sound/core/seq/seq_virmidi.c
> @@ -155,21 +155,26 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>         struct snd_virmidi *vmidi = substream->runtime->private_data;
>         int count, res;
>         unsigned char buf[32], *pbuf;
> +       unsigned long flags;
>
>         if (up) {
>                 vmidi->trigger = 1;
>                 if (vmidi->seq_mode == SNDRV_VIRMIDI_SEQ_DISPATCH &&
>                     !(vmidi->rdev->flags & SNDRV_VIRMIDI_SUBSCRIBE)) {
> -                       snd_rawmidi_transmit_ack(substream, substream->runtime->buffer_size - substream->runtime->avail);
> -                       return;         /* ignored */
> +                       while (snd_rawmidi_transmit(substream, buf,
> +                                                   sizeof(buf)) > 0) {
> +                               /* ignored */
> +                       }
> +                       return;
>                 }
>                 if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
>                         if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
>                                 return;
>                         vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
>                 }
> +               spin_lock_irqsave(&substream->runtime->lock, flags);
>                 while (1) {
> -                       count = snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
> +                       count = __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
>                         if (count <= 0)
>                                 break;
>                         pbuf = buf;
> @@ -179,16 +184,18 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>                                         snd_midi_event_reset_encode(vmidi->parser);
>                                         continue;
>                                 }
> -                               snd_rawmidi_transmit_ack(substream, res);
> +                               __snd_rawmidi_transmit_ack(substream, res);
>                                 pbuf += res;
>                                 count -= res;
>                                 if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
>                                         if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
> -                                               return;
> +                                               goto out;
>                                         vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
>                                 }
>                         }
>                 }
> +       out:
> +               spin_unlock_irqrestore(&substream->runtime->lock, flags);
>         } else {
>                 vmidi->trigger = 0;
>         }
> --
> 2.7.0
>
