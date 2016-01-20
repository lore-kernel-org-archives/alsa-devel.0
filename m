From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Re: Discarding the first few frames inside the kernel
Date: Wed, 20 Jan 2016 11:24:03 -0600
Message-ID: <CACaQK7DCUx7=2t-SBZQ6vjU4OJ+Le0YcOK_D-0q4RqFczTO9Zg@mail.gmail.com>
References: <CACaQK7CtpKQK_j5q+F6ekK_j+w3SLQ=RQ0yR76+81ETvsg1Qdg@mail.gmail.com>
 <569D9DFE.5000503@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B824B260447
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 18:24:03 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id b14so40850141wmb.1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 09:24:03 -0800 (PST)
In-Reply-To: <569D9DFE.5000503@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Thank you for your response. I am not sure as to how the wait for 4.5ms can
be applied there?
Alternatively, does calling snd_pcm_format_set_silence(), be a safe method
to silence the first few samples coming out of the buffer?

Regards,
Ankhit

On Mon, Jan 18, 2016 at 8:22 PM, Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On Jan 19 2016 03:21, Ankhit Vivekananda wrote:
>
>> I am interfacing the ICS43432 MEMS microphone with McBSP interface. The
>> data sheet of the ICS43432 microphone shows that it takes about 4.5ms
>> (16kHz sampling rate) for startup. Because of this, I hear a transient
>> noise at the beginning of every stream. Is there in any way I can discard
>> the frames inside the kernel space itself before reading the samples using
>> snd_pcm_readi() call?
>>
>> I was able to mute the first few frames after the readi() call, but would
>> want to know if I could do it before the readi() call itself inside the
>> kernel space.
>>
>
> If the data transmission starts in 'struct snd_pcm_ops.prepare' callback
> of the driver, we can wait what we want, because ALSA PCM core guarantees
> to call it in process context.
>
> In userspace, this looks like (here I describe in alsa-lib API):
>  - calling snd_pcm_hw_params()
>    - snd_pcm_prepare() is called library internal
>      * struct snd_pcm_ops.prepare() is called in kernel mode.
>        * mute
>        * start data transmission
>        * wait for the 4.5ms or somewhat
>        * return
>      * return
>    - return
>  - PCM frame operation such as snd_pcm_writei()
>    * snd_pcm_ops.trigger(TRIGGER_START) is called in kernel mode.
>      * demute
>    * PCM frames starts to be transferred from userspace.
>
>
> Regards
>
> Takashi Sakamoto
>
