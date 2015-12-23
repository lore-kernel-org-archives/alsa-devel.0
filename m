From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 7/8] ASoC: wm_adsp: Add a handler for
 the compressed IRQ
Date: Wed, 23 Dec 2015 09:58:06 +0000
Message-ID: <20151223095806.GY6058@localhost.localdomain>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151223001907.GI16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D49265062
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 10:58:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151223001907.GI16023@sirena.org.uk>
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

On Wed, Dec 23, 2015 at 12:19:07AM +0000, Mark Brown wrote:
> On Tue, Dec 15, 2015 at 11:29:48AM +0000, Charles Keepax wrote:
> 
> > +static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
> > +{
> > +	struct wm5110_priv *florida = data;
> > +
> > +	wm_adsp_compr_handle_irq(&florida->core.adsp[2]);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> We unconditionally handle the IRQ...
> 
> > +int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
> > +{
> > +	struct wm_adsp_compr_buf *buf = dsp->buffer;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&dsp->pwr_lock);
> > +
> > +	if (!buf) {
> > +		adsp_err(dsp, "Spurious buffer IRQ\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> 
> ...though we even have code to handle spurious IRQs.  I'd expect
> IRQ_NONE if the interrupt wasn't handled, allowing genirq's error
> handling and diagnostics to take effect.

Yeah that seems sensible I will fix that up.

> 
> > +static int wm_adsp_buffer_ack_irq(struct wm_adsp_compr_buf *buf)
> > +{
> > +	if (buf->irq_ack & 0x01)
> > +		return 0;
> > +
> > +	adsp_dbg(buf->dsp, "Acking buffer IRQ(0x%x)\n", buf->irq_ack);
> > +
> > +	buf->irq_ack |= 0x01;
> > +
> > +	return wm_adsp_buffer_write(buf, HOST_BUFFER_FIELD(irq_ack),
> > +				    buf->irq_ack);
> > +}
> 
> This is confusing, this isn't actually in the interrupt path...

Acking the last IRQ basically tells the firmware that it is free
to send another. There is no point in doing so until we have
to wait for data. As we are just actively streaming available
data we can progress along fine without enabling the IRQ.

I am somewhat torn between a comment and renaming the function. I
will try to add some sort of reasonable comment.

Thanks,
Charles
