From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ALSA Control Questions (atomicity, error handling)
Date: Fri, 4 Dec 2009 12:27:07 +0100
Message-ID: <20091204112707.GQ14091@buzzloop.caiaq.de>
References: <4B1803CE.3080501@gmx.de>
	<20091203195018.GK14091@buzzloop.caiaq.de>
	<4B18D6DA.6070809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E5E7D103801
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 12:27:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B18D6DA.6070809@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Schneider <tobsnyder@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 04, 2009 at 10:31:06AM +0100, Tobias Schneider wrote:
> Actually I know where the problem in my code is: inside the put
> callback (see below) I am calling a function (dsp_setoutput) that is
> sending the signal to the DSP, there I wanted to wait for the reply
> of the DSP to get a feedback whether the request was successful or
> not. This was done by a semaphore (going down and waiting for IRQ
> from DSP that is setting sema up), and thats the point where the
> posted bug occured.
> 
> So I was just wondering that it seems that there is no possibility
> to wait for a reply of the DSP, to be sure that a given value has
> been set?
> 
> 
> (for the interested ones, here is the code..)
> 
> static int snd_mychip_output_set_put(struct snd_kcontrol *kcontrol,
>                                     struct snd_ctl_elem_value *ucontrol)
> {
>  struct snd_mychip *mychip = snd_kcontrol_chip(kcontrol);
>  int addr = kcontrol->private_value;
>  short change = 0;
> 
>  spin_lock_irq(&mychip->mixer_lock);

As I said - here you're holding a spinlock ...

>  if (ucontrol->value.integer.value[0] != mychip->output_set[addr]) {
>    if (dsp_setoutput(addr+1, ucontrol->value.integer.value[0]) >= 0)
>    {
>      mychip->output_set[addr] = ucontrol->value.integer.value[0];
>      change = 1;
>    }
>    else  // error sending signal
>    {
>      change = -EBUSY;  // device or resource busy
>    }
>  }
>  spin_unlock_irq(&mychip->mixer_lock);
>  return change;
> }
> 
> later on in the called function...
> // wait for reply via semaphore
>  while(!end)
>  {
>    if (down_interruptible(&dsp_reply_sema)==-EINTR)   // HERE WE GET

And here you allow the CPU to reschedule while waiting for a mutex.
That doesn't fly. You should remove the spinlock from the function above
and move it to the actual lowlevel I/O function (whatever
dsp_setoutput() does eventually).

Think about where locking is actually needed, at which point your
function flow must not be interrupted by anything to avoid data
corruption. Use locking there, and remove it from other places.

This might also be a good read to get an overview:

  http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/index.html

> Another point: I figured out that the "ALSA middlelayer" seems to
> filter the given values of a control. So if the user sets value=1000
> where maximum is 10, I will get 10 instead of 1000 in the put
> callback...so it's not necessary to check values in those callbacks,
> but unfortunately that's not always good - because sometimes it
> doesn't make sense to use the max or min values if the user just
> entered a wrong number...

For integer values, it does make sense to clamp values to their limits.
For enums, that might be different. Not sure what the ALSA core does
there.

Daniel
