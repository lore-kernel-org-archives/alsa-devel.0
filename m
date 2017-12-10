From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Sun, 10 Dec 2017 04:52:00 +0300
Message-ID: <20171210015200.gr4mxzqgzyvamxui@mwanda>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com> <20171209172732.GF15660@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 78FCB26734C
 for <alsa-devel@alsa-project.org>; Sun, 10 Dec 2017 02:57:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171209172732.GF15660@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, arvindY <arvind.yadav.cs@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 09, 2017 at 06:27:32PM +0100, Alexandre Belloni wrote:
> > > diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> > > index 5e4fbd2d3479..71fce7c85c93 100644
> > > --- a/sound/soc/nuc900/nuc900-ac97.c
> > > +++ b/sound/soc/nuc900/nuc900-ac97.c
> > > @@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
> > >   		goto out;
> > >   	}
> > > -	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> > > -	if (nuc900_audio->irq_num <= 0) {
> > > -		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
> > > +	ret = platform_get_irq(pdev, 0);
> > > +	if (ret < 0)
> 
> The <= 0 was ok, see:
> https://lkml.org/lkml/2017/11/18/41
> 

Yeah, but is it ever going to return 0?  That seems like a design error
and also really crap commenting if so.

regards,
dan carpenter
