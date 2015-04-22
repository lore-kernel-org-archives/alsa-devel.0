From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/7] ASoC: hda - add Skylake HD audio
 driver
Date: Wed, 22 Apr 2015 08:31:32 +0530
Message-ID: <20150422030132.GB2738@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-6-git-send-email-vinod.koul@intel.com>
 <s5hfv7wwpbe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DF4F26047F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 05:04:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfv7wwpbe.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 19, 2015 at 09:27:17AM +0200, Takashi Iwai wrote:
> At Fri, 17 Apr 2015 14:43:18 +0530,
> Vinod Koul wrote:
> > +irqreturn_t azx_interrupt(int irq, void *dev_id)
> > +{
> > +	struct hdac_bus *chip = dev_id;
> > +	u32 status;
> > +
> > +#ifdef CONFIG_PM
> > +	if (!pm_runtime_active(chip->dev))
> > +		return IRQ_NONE;
> > +#endif
> > +
> > +	spin_lock(&chip->reg_lock);
> > +
> > +	status = snd_hdac_chip_readl(chip, INTSTS);
> > +	if (status == 0 || status == 0xffffffff) {
> > +		spin_unlock(&chip->reg_lock);
> > +		return IRQ_NONE;
> > +	}
> > +	spin_unlock(&chip->reg_lock);
> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +irqreturn_t azx_threaded_handler(int irq, void *dev_id)
> > +{
> > +	struct hdac_bus *chip = dev_id;
> > +	u32 status;
> > +	unsigned long cookie;
> > +
> > +	status = snd_hdac_chip_readl(chip, INTSTS);
> > +	spin_lock_irqsave(&chip->reg_lock, cookie);
> > +
> > +	snd_hdac_bus_handle_stream_irq(chip, status, &azx_position_check);
> > +
> > +	/* clear rirb int */
> > +	status = snd_hdac_chip_readb(chip, RIRBSTS);
> > +	if (status & RIRB_INT_MASK) {
> > +		if (status & RIRB_INT_RESPONSE)
> > +			snd_hdac_bus_update_rirb(chip);
> > +		snd_hdac_chip_writeb(chip, RIRBSTS, RIRB_INT_MASK);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&chip->reg_lock, cookie);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> BTW, you don't need to use a threaded irq for this task.  Unlike DSP
> driver, the PCM and CORB/RIRB irq doesn't need a long time to handle.
For this yes we dont. I can move this up.

But we still need a threaded handler for DSP ops, but yes no need to wake
all the time

-- 
~Vinod
