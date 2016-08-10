From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Underrun with 2 periods on skylake HDA driver
Date: Wed, 10 Aug 2016 08:54:22 +0200
Message-ID: <41a8a1f8-01f9-6c8b-b837-f0d1bc78bc41@ladisch.de>
References: <20060810050415.GB5190@dhara-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1C5F5265335
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 08:54:35 +0200 (CEST)
In-Reply-To: <20060810050415.GB5190@dhara-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>, tiwai@suse.de
Cc: vinod.koul@intel.com, Hardik T <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, Rakesh A <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

Dharageswari R wrote:
> While doing the validation of Skylake HDA driver using aplay and
> following parameters, we noticed underrun issues.
>
> buffer_size  : 9600
> period_size  : 4800
>
> After doing further debugging, what I found is
>
> 1.DMA complete interrupt occurs for the first period.
> 2.Driver reads DMA position in buffer pointer and gets value of 4784.

The interrupt says that the buffer descriptor list entry has been
completed, but the position in buffer pointer says that the entry has
not yet been completed.

> I checked with HDA architects and they are saying that when the DMA
> completion interrupt occurs there can be slight delay before the DMA
> Position In Buffer Pointer gets updated.

The driver's interrupt handler takes care to read the interrupt status
register first, so that any pending memory writes from the device are
flushed.

Of course, this does not work if the device posts writes _after_ the
interrupt has been raised.  This is a bug in the hardware.

> So driver is expected to refill data based on whatever content is
> reflected in the DMA Position In Buffer.

No, that's not how it works.  The driver waits until all 4800 frames
are available, and the only way to wake it up is with an interrupt.


It appears the driver must work around this bug by scheduling another
interrupt after the delay.  Is there an upper limit (time or frames) for
this delay?


Regards,
Clemens
