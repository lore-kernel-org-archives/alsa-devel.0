From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 14:31:24 +0100
Message-ID: <20090402133124.GE9522@n2100.arm.linux.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
	<20090402123844.GD9522@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 94D1824396
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 15:31:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402123844.GD9522@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 01:38:44PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 02, 2009 at 01:18:03PM +0100, Mark Brown wrote:
> > On Thu, Apr 02, 2009 at 01:13:48PM +0100, Russell King - ARM Linux wrote:
> > > I've tried both your patches, and I still have to manually write to
> > > GCR to bring the bus out of reset.  I'll investigate more in the coming
> > > days.
> > 
> > Which PXA variant is the system using?
> 
> PXA255.

Right, adding some printk's, which include into pxa2xx-ac97's reset
functions reveals...

soc_resume: entry
soc_resume_deferred: entry
pxa2xx_ac97_resume:
soc_resume_deferred: exit
soc_resume: exit
wm97xx_resume: entry
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=120 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=76 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=78 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=80 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=82 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=84 GSR=0x0)
pxa2xx_ac97_write: write error (ac97_reg=86 GSR=0x0)
wm97xx_resume: exit

So, basically, we're starting to access the AC97 bus without first
initializing the controller.  This can't work on _any_ PXA platform.

On any reset, GCR is initialized by the hardware to zero.  That means
that the PXA AC97 hardware is held in reset state, and the codec is
held in cold reset.

On resume or probe, we need to take the hardware out of cold reset.

That happens in the probe just fine because one of the first actions
that the core ALSA AC97 code does is to issue a cold reset - see
sound/pci/ac97/ac97_codec.c:snd_ac97_mixer() where it calls the
bus reset() method.

And here we have the problem... using Ian's wm9705 driver, it doesn't
implement any suspend/resume ops.  I assume Ian's e-series platforms
aren't suspend-able.

Having added the suspend/resume functions to the driver in the same
manner as soc/codecs/ac97.c:

static int wm9705_soc_suspend(struct platform_device *pdev, pm_message_t msg)
{
        struct snd_soc_device *socdev = platform_get_drvdata(pdev);
        snd_ac97_suspend(socdev->card->codec->ac97);
        return 0;
}

static int wm9705_soc_resume(struct platform_device *pdev)
{
        struct snd_soc_device *socdev = platform_get_drvdata(pdev);
        snd_ac97_resume(socdev->card->codec->ac97);
        return 0;
} 

I now find that the board crashes inexplicably on suspend... because...
Argh, Ian, what pile of mess have you created in wm9705?

There's *no* AC97 initialization in there.  Whereas ac97.c does:

        /* add codec as bus device for standard ac97 */
        ret = snd_ac97_bus(codec->card, 0, &soc_ac97_ops, NULL, &ac97_bus);
        if (ret < 0)
                goto bus_err;
        
        memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
        ret = snd_ac97_mixer(ac97_bus, &ac97_template, &codec->ac97);
        if (ret < 0)
                goto bus_err;

You do:

        ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);

which doesn't actually give us an AC97 codec device - it only kmallocs
some memory for them.

Okay, I'm going to shelve this project for at least the next three
months now, and will return to it when (and if) the ASoC codec
situation improves.
