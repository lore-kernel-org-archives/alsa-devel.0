From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [RFC] A question regarding open ioctl for user
 space in ASoC driver.
Date: Tue, 20 May 2014 12:43:24 +0800
Message-ID: <20140520044323.GA10471@MrMyself>
References: <20140516105939.GA2544@MrMyself>
 <20140520001834.GJ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DD72615F3
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 06:58:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140520001834.GJ12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Thanks for the ideas!

On Tue, May 20, 2014 at 01:18:34AM +0100, Mark Brown wrote:
> On Fri, May 16, 2014 at 06:59:41PM +0800, Nicolin Chen wrote:

> > 1) P2P, peripheral to peripheral, regards ASRC as a FE (front end link)
> >    corresponding to a BE (back end link like ESAI<->CS42888). The P2P
> >    function resolves a problem of unsupported sample rates for BE that
> >    we can convert the unsupported audio format to a supported one before
> >    we send the data into BE. It also has better quality and less CPU
> >    loading comparing to ALSA-lib's SRC function.
> 
> >    * For this function, I don't see any critical problem here. But...
> 
> This is moderately common in mainline already.  You shouldn't need to
> have any custom code - we should just be able to figure out that the SRC
> is needed (and a quick glance at your out of tree code shows now ioctl()
> so that's fine as you say).

I was thinking about just leaving P2P as an initial version and reserving
some essential interfaces for M2M function so that I can add it up later
in our internal branch or we can figure out a better approach in community
style. And now, it looks like a good idea for me to try this way so as to
move on quickly.

> > 2) M2M, memory to memory, can simply make ASRC as a sample rate converter
> >    without playback via any BE sound card, just like using any software
> >    to convert a WAV file in one sample rate to another WAV in a required
> >    sample rate. The driver has its self-designed application to compelte
> >    this function by sending the audio data from a wave file into a misc
> >    device via non-generic ioctl:
> 
> I would expect this to be handled by just routing the audio between the
> two front ends using DAPM/DPCM rather than by having a new kernel API.a

Two front ends: one for ASRC and the other is...? And how does it transfer
audio data with user space?

> DPCM is mostly Liam's area so I'll defer to him on exactly how DPCM
> would figure that out - even with pure DAPM it's something we should do
> better with than we do.  I don't know if there are examples in the Intel
> code people could refer to?
> 
> If nothing else representing the ASRC block as a CODEC would do the
> trick though that doesn't entirely play well with DPCM, it is kind of
> doing the right thing though in that the ASRC block terminates two
> digital paths.  I'm not loving the elegence there though.

Sorry I can't understand this CODEC approach either...

Yes, ASRC has two digital ends but each of them is just a FIFO register
, input FIFO and output FIFO, waiting for DMA to handle the Tx/Rx job,
not like a normal CODEC that has DAI outwards.

Thank you,
Nicolin
