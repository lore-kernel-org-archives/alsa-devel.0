From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 7/8] ASoC: wm_adsp: Add a handler for
 the compressed IRQ
Date: Tue, 29 Dec 2015 15:43:13 +0000
Message-ID: <20151229154313.GA1490@localhost.localdomain>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151223001907.GI16023@sirena.org.uk>
 <20151223095806.GY6058@localhost.localdomain>
 <20151224193137.GI579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D99632605FF
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 16:43:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151224193137.GI579@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 24, 2015 at 07:31:37PM +0000, Mark Brown wrote:
> On Wed, Dec 23, 2015 at 09:58:06AM +0000, Charles Keepax wrote:
> > On Wed, Dec 23, 2015 at 12:19:07AM +0000, Mark Brown wrote:
> > > On Tue, Dec 15, 2015 at 11:29:48AM +0000, Charles Keepax wrote:
> 
> > > > +static int wm_adsp_buffer_ack_irq(struct wm_adsp_compr_buf *buf)
> > > > +{
> > > > +	if (buf->irq_ack & 0x01)
> 
> > > This is confusing, this isn't actually in the interrupt path...
> 
> > Acking the last IRQ basically tells the firmware that it is free
> > to send another. There is no point in doing so until we have
> > to wait for data. As we are just actively streaming available
> > data we can progress along fine without enabling the IRQ.
> 
> > I am somewhat torn between a comment and renaming the function. I
> > will try to add some sort of reasonable comment.
> 
> This doesn't sound like it's really acknowledging an IRQ - you have
> level triggered interrupts here so if the interrupt isn't acknowledged
> the interrupt handler will constantly be called.

It kinda is acking the IRQ just at the firmware level, not the
hardware level. The physical IRQ all gets acked through regmap
so that is all handled. This code here lets the firmware know,
which it will then use to decide whether it should send a new IRQ
or not.

I could perhaps rename the function to
wm_adsp_buffer_request_irq? and buf->irq_ack to buf->irq_count?
That might make the usage a little more clear.

Thanks,
Charles
