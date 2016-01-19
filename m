From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Discarding the first few frames inside the kernel
Date: Tue, 19 Jan 2016 11:22:54 +0900
Message-ID: <569D9DFE.5000503@sakamocchi.jp>
References: <CACaQK7CtpKQK_j5q+F6ekK_j+w3SLQ=RQ0yR76+81ETvsg1Qdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A1A2604D6
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 03:22:58 +0100 (CET)
In-Reply-To: <CACaQK7CtpKQK_j5q+F6ekK_j+w3SLQ=RQ0yR76+81ETvsg1Qdg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 19 2016 03:21, Ankhit Vivekananda wrote:
> I am interfacing the ICS43432 MEMS microphone with McBSP interface. The
> data sheet of the ICS43432 microphone shows that it takes about 4.5ms
> (16kHz sampling rate) for startup. Because of this, I hear a transient
> noise at the beginning of every stream. Is there in any way I can discard
> the frames inside the kernel space itself before reading the samples using
> snd_pcm_readi() call?
>
> I was able to mute the first few frames after the readi() call, but would
> want to know if I could do it before the readi() call itself inside the
> kernel space.

If the data transmission starts in 'struct snd_pcm_ops.prepare' callback 
of the driver, we can wait what we want, because ALSA PCM core 
guarantees to call it in process context.

In userspace, this looks like (here I describe in alsa-lib API):
  - calling snd_pcm_hw_params()
    - snd_pcm_prepare() is called library internal
      * struct snd_pcm_ops.prepare() is called in kernel mode.
        * mute
        * start data transmission
        * wait for the 4.5ms or somewhat
        * return
      * return
    - return
  - PCM frame operation such as snd_pcm_writei()
    * snd_pcm_ops.trigger(TRIGGER_START) is called in kernel mode.
      * demute
    * PCM frames starts to be transferred from userspace.


Regards

Takashi Sakamoto
