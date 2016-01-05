From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 7/8] ASoC: wm_adsp: Add a handler for
 the compressed IRQ
Date: Tue, 5 Jan 2016 14:36:36 +0000
Message-ID: <20160105143636.GB1490@localhost.localdomain>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151223001907.GI16023@sirena.org.uk>
 <20151223095806.GY6058@localhost.localdomain>
 <20151224193137.GI579@sirena.org.uk>
 <20151229154313.GA1490@localhost.localdomain>
 <20160105142025.GA6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 427E02610C5
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 15:37:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160105142025.GA6588@sirena.org.uk>
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

On Tue, Jan 05, 2016 at 02:20:25PM +0000, Mark Brown wrote:
> On Tue, Dec 29, 2015 at 03:43:13PM +0000, Charles Keepax wrote:
> > On Thu, Dec 24, 2015 at 07:31:37PM +0000, Mark Brown wrote:
> 
> > > > I am somewhat torn between a comment and renaming the function. I
> > > > will try to add some sort of reasonable comment.
> 
> > > This doesn't sound like it's really acknowledging an IRQ - you have
> > > level triggered interrupts here so if the interrupt isn't acknowledged
> > > the interrupt handler will constantly be called.
> 
> > It kinda is acking the IRQ just at the firmware level, not the
> > hardware level. The physical IRQ all gets acked through regmap
> > so that is all handled. This code here lets the firmware know,
> > which it will then use to decide whether it should send a new IRQ
> > or not.
> 
> That's not an interrupt acknowlegement, it's a request for more data.

Well a request to let us know about there being more data. We will
keep consuming data as it is generated until we reach a point where
we have less than one fragment, then we set this and wait for an
IRQ to say we have more than a fragment again.

> 
> > I could perhaps rename the function to
> > wm_adsp_buffer_request_irq? and buf->irq_ack to buf->irq_count?
> > That might make the usage a little more clear.
> 
> That might be a bit clearer, yes - it looks like this is a mailbox on
> the DSP that you're kicking?

Effectively you could think of it as a mailbox, I haven't looked
much at the framework but I suspect it is a little overkill for
what we want to do here.

Thanks,
Charles
