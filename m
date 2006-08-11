From: Dharageswari R <dharageswari.r@intel.com>
Subject: Re: Underrun with 2 periods on skylake HDA driver
Date: Fri, 11 Aug 2006 10:12:04 +0530
Message-ID: <20060811044152.GA3557@dhara-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 90560266983
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 06:42:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, dharageswari.r@intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2016 at 11:54:22PM -0700, Clemens Ladisch wrote:
> Dharageswari R wrote:
> > While doing the validation of Skylake HDA driver using aplay and
> > following parameters, we noticed underrun issues.
> >
> > buffer_size  : 9600
> > period_size  : 4800
> >
> > After doing further debugging, what I found is
> >
> > 1.DMA complete interrupt occurs for the first period.
> > 2.Driver reads DMA position in buffer pointer and gets value of 4784.
>
> The interrupt says that the buffer descriptor list entry has been
> completed, but the position in buffer pointer says that the entry has
> not yet been completed.
>
yes
> > I checked with HDA architects and they are saying that when the DMA
> > completion interrupt occurs there can be slight delay before the DMA
> > Position In Buffer Pointer gets updated.
>
> The driver's interrupt handler takes care to read the interrupt status
> register first, so that any pending memory writes from the device are
> flushed.
>
> Of course, this does not work if the device posts writes _after_ the
> interrupt has been raised.  This is a bug in the hardware.
>
> > So driver is expected to refill data based on whatever content is
> > reflected in the DMA Position In Buffer.
>
> No, that's not how it works.  The driver waits until all 4800 frames
> are available, and the only way to wake it up is with an interrupt.
>
There is no other interrupt apart from the buffer completion interrupt
to know the post write completion. The only option here would be to
poll till the position is equal or more than the period boundary with
timeout before the period elapsed reporting. I thought of avoiding this
if possible but doesnt seem to be true. Thanks for your reply.
I will make sure that the driver reports period ellapsed
at or above the period boundary.
>
> It appears the driver must work around this bug by scheduling another
> interrupt after the delay.  Is there an upper limit (time or frames) for
> this delay?
The upper limit is not deterministic in this case.
>
>
> Regards,
> Clemens

-- 
