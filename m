From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
Date: Thu, 19 Dec 2013 10:14:25 +0800
Message-ID: <20131219021423.GA10601@MrMyself>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131218185952.GM31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 745C526529F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 03:31:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131218185952.GM31886@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 06:59:52PM +0000, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 06:44:45PM +0800, Nicolin Chen wrote:
> 
> > +/**
> > + * fsl_ssi_set_dai_tdm_slot - set TDM slot number
> > + *
> > + * Note: This function can be only called when using SSI as DAI master
> > + */
> > +static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
> > +				u32 rx_mask, int slots, int slot_width)
> > +{
> > +	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> > +	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> > +	u32 val;
> 
> I'm a bit concernred about what this is for and why it's required - is
> it something that machine drivers have to call and if it is shouldn't
> the driver be defaulting to a sensible configuration?

SSI can control how many slots to generate and which slot to send data. Yes,
the normal case, which should be defaulting to normal two slots I2S case, can
be configured by SSI driver itself as you mentioned. I'll add it to startup().

Then only those machine drivers using multiple slots (>2) need to call it.

Thank you for the comments.
Nicolin Chen
