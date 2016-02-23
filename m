From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: simultaneous start of input/output channels
Date: Tue, 23 Feb 2016 11:42:09 +0100
Message-ID: <56CC3781.6010607@metafoo.de>
References: <CAJOrw7wFQzb-1RCyOUvvWqH8s57roA48M3Po3OFN-j1ro32BuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-244.synserver.de (smtp-out-245.synserver.de
 [212.40.185.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C7811260476
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 13:19:28 +0100 (CET)
In-Reply-To: <CAJOrw7wFQzb-1RCyOUvvWqH8s57roA48M3Po3OFN-j1ro32BuQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonah Petri <jpetri@izotope.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/22/2016 05:10 PM, Jonah Petri wrote:
> Hello!
> 
> Our application is very low-latency full duplex audio on a Freescale SoC.
> ALSA is configured with 2 64-frame buffers, with DSP happening on a
> realtime user thread.
> 
> With small buffer sizes, we're obviously very tight on timing, and I've run
> into an issue which seems architectural in nature, and seemingly is worthy
> of consulting the list.
> 
> What we're seeing is a large temporal latency between the DMA completion
> IRQ for the audio input DMA and audio output DMA. This delay is on the
> order of 200 microseconds, but also somewhat variable (ok, "large" is
> relative here, but it matters to us!).  In the ideal case, these two
> interrupts would be perfectly aligned in time, allowing us to run DSP for
> the full buffer's duration.  However, since the interrupts are offset by
> about 20% of a buffer, we effectively lose that time for our DSP.  And,
> since the timing is variable, and we're in a realtime application, this
> produces scared engineers.
> 
> Working backwards from the hardware drivers, I see that snd_soc_dai_ops's
> trigger callback is used to start and stop the DMA.  The fundamental
> "start" action comes down to a single register write which can easily start
> both input and output streams in the same write.  However, it seems that
> the snd_soc_dai_ops does not provide for simultaneous start of both input
> and output streams.  Tracing back through the kernel interface and into
> user space, it seems that starting both the input and output streams
> necessitates two separate calls from userspace, which could explain the
> delay, and some of the variability in timing.
> 
> My question is:
> * Did I miss some API or technique which could allow simultaneous start of
> full duplex streams?

Have a look at snd_pcm_link()
(http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gac6c33091b049985baa6466e8fe93917e).
This links two PCM devices together to that operations like start/stop are
done at the same time. Although this is just a soft-link, which means you
send one IOCTL and the ALSA core will forward that to both trigger functions.

> * If not, I would certainly appreciate advice on where we could fit this
> into the existing architecture!  We would be glad to do the kernel work to
> make this change, as this capability seems generally useful!

If you can actually link them in hardware and launch both streams with the
same register write you might need to adopt the internal link architecture
to support this.

- Lars
