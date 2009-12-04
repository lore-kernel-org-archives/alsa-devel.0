From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ALSA Control Questions (atomicity, error handling)
Date: Fri, 4 Dec 2009 12:34:34 +0100
Message-ID: <20091204113434.GR14091@buzzloop.caiaq.de>
References: <4B1803CE.3080501@gmx.de>
	<20091203195018.GK14091@buzzloop.caiaq.de>
	<4B18D6DA.6070809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DA290103803
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 12:34:37 +0100 (CET)
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
> (for the interested ones, here is the code..)

One more thing: in case you intend to bring your code mainline, please
run scripts/checkpatch.pl on the patches before you submit. The sniplet
you posted has a number of style issues that should be fixed. In
particular, pay attention to indentation, comment style and parenthesis
positions - checkpatch.pl will help pointing out most if them.

Daniel

> static int snd_mychip_output_set_put(struct snd_kcontrol *kcontrol,
>                                     struct snd_ctl_elem_value *ucontrol)
> {
>  struct snd_mychip *mychip = snd_kcontrol_chip(kcontrol);
>  int addr = kcontrol->private_value;
>  short change = 0;
> 
>  spin_lock_irq(&mychip->mixer_lock);
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
> BUG: scheduling while atomic: amixer/0x00000001/430 ...
>      // waked by signal (terminate), leave thread
>      printk(INFO "reply: catched signal\n");
>      end=1;
>      break;
>    }      printk(INFO "dsp_reply signaled (saved status =
> %i)\n",stDspReply.status);
>    end=1;
> ...
> }
