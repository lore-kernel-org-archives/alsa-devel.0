From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 16:36:18 +0530
Message-ID: <1343041578.1726.4876.camel@vkoul-udesk3>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
 <20120723104720.GK4435@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DA9260314
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 13:05:55 +0200 (CEST)
In-Reply-To: <20120723104720.GK4435@opensource.wolfsonmicro.com>
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

On Mon, 2012-07-23 at 11:47 +0100, Mark Brown wrote:
> On Mon, Jul 23, 2012 at 04:09:06PM +0530, Vinod Koul wrote:
> > On Mon, 2012-07-23 at 11:18 +0100, Mark Brown wrote:
> 
> > > It's not immediately clear to me that we shouldn't be flagging an
> > > overrun here - obviously if there's just a pure delay introduced by the
> 
> > Take the case of a DSP which employs DMA on input and output (of the
> > DSP)
> > At start, DSP would buffer some data, assuming a period. And assume app
> > has filed one period only. So at start as we buffered a period, ALSA
> > threw up wrong xrun, as it wasn't aware that this buffer is not yet
> > rendered.
> 
> > Using this notion, ALSA knows that there is some buffer in DSP and used
> > that for xrun as well as delay calculations.
> 
> I'm having a hard time relating this to what I was saying.  The point
> here is that if the device keeps marching on consuming data (as most
> cyclic DMAs would) then there's still going to be an underrun even if
> there's a buffer that causes a delay in the user hearing it.
yes there would be overrun but that is correct one. At that point I can
see that the DSP would have rendered everything it has (all buffers
exhausted). At this point app_pointer = hw_pointer and soc_delay would
be zero.
I am assuming dsp driver reports the soc_delay dynamically as it would
do for hw_pointer.

This doesn't stop all underruns, they would still be reported.
 
This only prevents false underrun when DSP still has something to
process and give to output DMA.
> 
> > > > This patch tries to add a new field "soc_delay" to represent buffering done in
> > > > DSPs. This value is also used for the xrun calculations in ALSA.
> 
> > > soc_delay seems like a very unclear name for this.
> 
> > I am not good with names, perhaps soc_buffer is good name :-) ?
> 
> The "soc" is the problem here - this shouldn't be specific to some sort
> of hardware.
Hmmm, yes this can happen outside soc's as well. dsp_buffer is my next
candidate :)


-- 
~Vinod
