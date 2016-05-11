From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH] ALSA: firewire-lib: permit process
	context only to	flush queued packets for better PCM period
	granularity
Date: Wed, 11 May 2016 09:31:41 +0200
Message-ID: <5732DFDD.6000208@ladisch.de>
References: <1462625196-3640-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5B5A82607C8
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 09:31:53 +0200 (CEST)
In-Reply-To: <1462625196-3640-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Sorry for the delay.

Takashi Sakamoto wrote:
> These three commits were merged to improve PCM pointer granularity.
> commit 76fb87894828 ("ALSA: firewire-lib: taskletize the snd_pcm_period_elapsed() call")
> commit e9148dddc3c7 ("ALSA: firewire-lib: flush completed packets when reading PCM position")
> commit 92b862c7d685 ("ALSA: firewire-lib: optimize packet flushing")
>
> The point of them is to handle queued packets not only in software IRQ
> context of IR/IT contexts, but also in process context. This idea
> introduced a cyclic call of 'struct snd_pcm_ops.pointer()'.

There is no recursion because of the tasklet.  The only problem is that
the tasklet could be scheduled repeatedly because new packets continue
to arrive.  But even when this happens, it's harmless.

> The last commit adds 'pointer_flush' member to 'struct amdtp_stream'
> to avoid the situation. On the other hand, This solution is weak at
> race condition between the process context and the software IRQ
> context of IR/IT contexts.
>
> Practically, this race is not so critical because it influences process
> context to skip flushing queued packets and to get worse granularity of
> PCM pointer.

When a race causes pointer_flush to be read as true although it should
be false, there is simply a superfluous call to flush_completions.

When pointer_flush is read as false although it should be true, then the
buffer_pointer value _might_ not be the most current one (due to the
missing flush), but this is unlikely to happen because the buffer_pointer
was just updated by update_pcm_pointers().  In any case, the just-
scheduled tasklet will inform the application about the new pointer.

> The similar solution can be achieved by 'in_interrupt()' macro. This
> commit applies the macro to solve the race condition against
> 'pointer_flush'.

>  unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
>  {
> -	/* this optimization is allowed to be racy */
> -	if (s->pointer_flush && amdtp_stream_running(s))
> ...
> +	if (!in_interrupt() && amdtp_stream_running(s))
>  		fw_iso_context_flush_completions(s->context);
> -	else
> -		s->pointer_flush = true;
>
>  	return ACCESS_ONCE(s->pcm_buffer_pointer);
>  }

Looks good.

Acked-by: Clemens Ladisch <clemens@ladisch.de>


> And I think there's another race condition against processing each packets
> by calling out/in_stream_callback(), but I cannot observe the race.

As you already found out, fw_iso_context_flush_completions() is thread
safe.


Regards,
Clemens
