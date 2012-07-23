From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 16:09:06 +0530
Message-ID: <1343039946.1726.4830.camel@vkoul-udesk3>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FAB265269
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:38:43 +0200 (CEST)
In-Reply-To: <20120723101851.GG4435@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-07-23 at 11:18 +0100, Mark Brown wrote:
> On Mon, Jul 23, 2012 at 03:36:37PM +0530, Vinod Koul wrote:
> 
> > In many modern SoCs the audio DSP can buffer the PCM ring buffer data. Today we
> 
> This isn't particularly new, we've had SRAM buffers in SoCs for ages.
> 
> > have no means to represent this buffering and ALSA wrongly detects an overrun
> > when hw_ptr reaches app_ptr value, though DSP may still have some buffered data.
> 
> It's not immediately clear to me that we shouldn't be flagging an
> overrun here - obviously if there's just a pure delay introduced by the
> DSP then we will underrun if we catch up with the input, it's just that
> there will be a delay in the user hearing it.  It seems like the thing
> we need to say here is more that the DSP or DMA knows where the
> application pointer is and can halt the DMA when it underruns, together
> with the fact that we have some buffering beyond the application visible
> DMA which means that an underrun isn't (yet) a user audible problem.
> We'd also want some other way of saying that that these further buffers
> did overrun.
having DMA know where app_pointer helps in detection of overrun in dsp.
But that's a separate topic.

Take the case of a DSP which employs DMA on input and output (of the
DSP)
At start, DSP would buffer some data, assuming a period. And assume app
has filed one period only. So at start as we buffered a period, ALSA
threw up wrong xrun, as it wasn't aware that this buffer is not yet
rendered.

Using this notion, ALSA knows that there is some buffer in DSP and used
that for xrun as well as delay calculations.


> > This patch tries to add a new field "soc_delay" to represent buffering done in
> > DSPs. This value is also used for the xrun calculations in ALSA.
> 
> soc_delay seems like a very unclear name for this.
I am not good with names, perhaps soc_buffer is good name :-) ?


-- 
~Vinod
