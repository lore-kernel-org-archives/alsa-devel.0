From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Mon, 11 Dec 2017 11:40:53 +0300
Message-ID: <20171211084053.p5ke733i3kzzk5mz@mwanda>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com> <20171209172732.GF15660@piout.net>
 <20171210015200.gr4mxzqgzyvamxui@mwanda>
 <5A2C9E9A.7020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 2468D266AE4
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 09:41:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5A2C9E9A.7020501@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 10, 2017 at 08:10:26AM +0530, arvindY wrote:
> 
> 
> On Sunday 10 December 2017 07:22 AM, Dan Carpenter wrote:
> > On Sat, Dec 09, 2017 at 06:27:32PM +0100, Alexandre Belloni wrote:
> > > > > diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> > > > > index 5e4fbd2d3479..71fce7c85c93 100644
> > > > > --- a/sound/soc/nuc900/nuc900-ac97.c
> > > > > +++ b/sound/soc/nuc900/nuc900-ac97.c
> > > > > @@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
> > > > >    		goto out;
> > > > >    	}
> > > > > -	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> > > > > -	if (nuc900_audio->irq_num <= 0) {
> > > > > -		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
> > > > > +	ret = platform_get_irq(pdev, 0);
> > > > > +	if (ret < 0)
> > > The <= 0 was ok, see:
> > > https://lkml.org/lkml/2017/11/18/41
> > > 
> > Yeah, but is it ever going to return 0?  That seems like a design error
> > and also really crap commenting if so
> yes, It can return 0 on sprac platform and If you see the return of
> platform_get_irq() 'return r ? r->start : -ENXIO;'. It should be
> 'return r && r->start? r->start : -ENXIO;'. We can not add checks here,
> Because There's a bunch of platforms in the kernel they still use IRQ0 as
> valid.
> I have separate mails where few maintainer ask me to add check for 0 and few
> not.
> Adding check for 0 will never harm.

What you're saying doesn't make sense.

You *can't* treat 0 as an error on Sparc because that's a valid IRQ.  In
fact, it seems like if you want to write portable code you should never
treated zero as an error.

It doesn't make sense that someone would register an IRQ resource with
an invalid IRQ number.  In other words, r->start is never going to be
zero on a platform where that's invalid.

So I'm pretty sure "if (ret < 0) " is the correct way to write code and
"if (ret <= 0) " is incorrect but generally harmless except perhaps in
limited situations on SPARC or other similar arches.

regards,
dan carpenter
