From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Mon, 11 Dec 2017 13:27:30 +0300
Message-ID: <20171211102730.agtoczxiu4dcn5ra@mwanda>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com> <20171209172732.GF15660@piout.net>
 <20171210015200.gr4mxzqgzyvamxui@mwanda>
 <5A2C9E9A.7020501@gmail.com>
 <20171211084053.p5ke733i3kzzk5mz@mwanda>
 <a191218d-fe63-db5f-1993-2167a2077f70@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F8DD266AE4
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 11:27:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a191218d-fe63-db5f-1993-2167a2077f70@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 11, 2017 at 02:37:22PM +0530, Arvind Yadav wrote:
> Hi Dan,
> 
> 
> On Monday 11 December 2017 02:10 PM, Dan Carpenter wrote:
> > On Sun, Dec 10, 2017 at 08:10:26AM +0530, arvindY wrote:
> > > 
> > > On Sunday 10 December 2017 07:22 AM, Dan Carpenter wrote:
> > > > On Sat, Dec 09, 2017 at 06:27:32PM +0100, Alexandre Belloni wrote:
> > > > > > > diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> > > > > > > index 5e4fbd2d3479..71fce7c85c93 100644
> > > > > > > --- a/sound/soc/nuc900/nuc900-ac97.c
> > > > > > > +++ b/sound/soc/nuc900/nuc900-ac97.c
> > > > > > > @@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
> > > > > > >     		goto out;
> > > > > > >     	}
> > > > > > > -	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> > > > > > > -	if (nuc900_audio->irq_num <= 0) {
> > > > > > > -		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
> > > > > > > +	ret = platform_get_irq(pdev, 0);
> > > > > > > +	if (ret < 0)
> > > > > The <= 0 was ok, see:
> > > > > https://lkml.org/lkml/2017/11/18/41
> > > > > 
> > > > Yeah, but is it ever going to return 0?  That seems like a design error
> > > > and also really crap commenting if so
> > > yes, It can return 0 on sprac platform and If you see the return of
> > > platform_get_irq() 'return r ? r->start : -ENXIO;'. It should be
> > > 'return r && r->start? r->start : -ENXIO;'. We can not add checks here,
> > > Because There's a bunch of platforms in the kernel they still use IRQ0 as
> > > valid.
> > > I have separate mails where few maintainer ask me to add check for 0 and few
> > > not.
> > > Adding check for 0 will never harm.
> > What you're saying doesn't make sense.
> I am following a below link. Where they have point out irq 0 is not valid.
> https://lwn.net/Articles/470820/

That article is interesting and explains why this stuff is so messed up,
but I think my email is correct.  No one is going to tell the kernel,
"There is an IRQ resource at 0, please store it in r->start.  We can't
use that IRQ, it's only there to make the kernel crash when people call
platform_get_irq()!  #geniusidea."

There are other IRQ functions like irq_of_parse_and_map() which do
return zero on error but platform_get_irq() pretty clearly returns
negative error codes.

regards,
dan carpenter
