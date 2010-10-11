From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 2/4] ASoC: add ep93xx AC97 audio driver
Date: Mon, 11 Oct 2010 13:07:42 +0300
Message-ID: <20101011100742.GE27142@gw.healthdatacare.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<b0202066df3bb9732fbecca627d0149165905a95.1286707213.git.mika.westerberg@iki.fi>
	<20101011094717.GA9231@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BD25A103835
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 12:07:46 +0200 (CEST)
Received: by bwz18 with SMTP id 18so1990514bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 03:07:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011094717.GA9231@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, martinwguy@gmail.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 10:47:18AM +0100, Mark Brown wrote:
> On Sun, Oct 10, 2010 at 01:54:10PM +0300, Mika Westerberg wrote:
> 
> > +	mutex_lock(&info->lock);
> > +
> > +	INIT_COMPLETION(info->done);
> 
> Do you really need to do this on every single register I/O?

Sorry, didn't quite understand you. Do you mean that should I take
the mutex and init the completion or wait for an interrupt?

> 
> > +	ep93xx_ac97_write_reg(info, AC97S1DATA, reg);
> > +	ep93xx_ac97_write_reg(info, AC97IM, AC97_SLOT2RXVALID);
> > +	if (!wait_for_completion_timeout(&info->done, AC97_TIMEOUT)) {
> > +		dev_warn(info->dev, "timeout reading register %x\n", reg);
> > +		mutex_unlock(&info->lock);
> > +		return -1;
> 
> Return a real error code.

Ok, will do.

> 
> > +module_init(ep93xx_ac97_init);
> > +module_exit(ep93xx_ac97_exit);
> 
> Put these next to the functions they're referencing.

Ok.

> 
> > +#ifndef _EP93XX_SND_SOC_AC97_H
> > +#define _EP93XX_SND_SOC_AC97_H
> > +
> > +extern struct snd_soc_dai ep93xx_ac97_dai;
> > +
> > +#endif /* _EP93XX_SND_SOC_AC97_H */
> 
> This is not needed with current ASoC.  Are you sure you've tested with
> current code?  You should always submit against the development version
> of the subsystem you're working with for any new drivers - for ASoC
> Jassi already pointed you at the tree, and you can in the general case
> also look at -next.

Yeah, sorry about that. I had the impression that using the latest
mainline would be right thing to do :( I will base the next version
against that tree pointed by Jassi.

Thanks for the comments,
MW
