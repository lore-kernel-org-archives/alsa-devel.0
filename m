From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Default enabling of mixer controls
Date: Mon, 8 Jun 2009 19:54:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030591A903@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
	<20090608121447.GD7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id CBC3E2438A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:24:09 +0200 (CEST)
In-Reply-To: <20090608121447.GD7858@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It is not working for me. 

I wrote this small piece of code:

static int omap3evm_twl4030_init(struct snd_soc_codec *codec)
{
	unsigned short reg;

	printk (KERN_DEBUG "inside omap3evm_twl4030_init\n\n");
	
	/* Enable Analog Left Capture Route AUXL */
	reg = codec->read(codec, TWL4030_REG_ANAMICL);
	reg |= TWL4030_AUXL_EN;
	codec->write(codec, TWL4030_REG_ANAMICL, reg);

	/* Enable Analog Right Capture Route AUXR */
	reg = codec->read(codec, TWL4030_REG_ANAMICR);
	reg |= TWL4030_AUXR_EN;
	codec->write(codec, TWL4030_REG_ANAMICR, reg);

	return 0;
}

After that, if I do a get on Analog Left Capture Route AUXL (or the other),
I am seeing that it has been turned ON. However, when I try to capture,
It doesn't work. I have to disable it first and then re-enable it to
capture properly.

Any clues?

Regards,
Anuj Aggarwal

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
> project.org] On Behalf Of Mark Brown
> Sent: Monday, June 08, 2009 5:45 PM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Default enabling of mixer controls
> 
> On Mon, Jun 08, 2009 at 05:40:56PM +0530, Aggarwal, Anuj wrote:
> 
> > Right now, they both come disabled in the default configuration and I
> > have to enable them explicitly by issuing the amixer cset command. How
> > can I do that automatically?
> 
> Register writes in the DAI init function will probably do the job,
> however the general advice is to leave this up to user space.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
