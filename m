From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Sat, 9 Dec 2017 18:27:32 +0100
Message-ID: <20171209172732.GF15660@piout.net>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5A2BE644.3070009@gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Arvind,

This was v5 and it contains an error that was corrected between v1 and
v2. For whatever reason, you reintroduced it between v4 and v5.

This is wasting a lot of time.

On 09/12/2017 at 19:03:56 +0530, arvindY wrote:
> Hi Dan,
> 
> On Saturday 09 December 2017 05:22 PM, Dan Carpenter wrote:
> > The error handling doesn't work here because "nuc900_audio->irq_num" is
> > unsigned.  Also we should be checking for < 0 and not <= 0 but I believe
> > that's harmless.  The platform_get_irq() comments don't talk about the
> > return values...
> Sorry for this  patch. I will fix it and send you updated patch.
> Thanks for point it.
> > Fixes: fa8cc38165c2 ("ASoC: nuc900: Fix platform_get_irq's error checking")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> > index 5e4fbd2d3479..71fce7c85c93 100644
> > --- a/sound/soc/nuc900/nuc900-ac97.c
> > +++ b/sound/soc/nuc900/nuc900-ac97.c
> > @@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
> >   		goto out;
> >   	}
> > -	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> > -	if (nuc900_audio->irq_num <= 0) {
> > -		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
> > +	ret = platform_get_irq(pdev, 0);
> > +	if (ret < 0)

The <= 0 was ok, see:
https://lkml.org/lkml/2017/11/18/41


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
