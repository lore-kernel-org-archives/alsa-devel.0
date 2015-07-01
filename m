From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: ts3a227e: do not report jack status
 when there is i2c read err
Date: Wed, 1 Jul 2015 23:20:56 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718D2ADDF@ORSMSX113.amr.corp.intel.com>
References: <1435724282-109761-1-git-send-email-yang.a.fang@intel.com>
 <CAEUnVG6fLa_+rnmFQ1zWZod25pJomO6xqLbshj8_t8AhhtK9Sg@mail.gmail.com>
 <20150701173409.GA111758@mocha> <20150701180524.GX11162@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718D29814@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D411E2651D3
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 01:21:00 +0200 (CEST)
In-Reply-To: <0485FB02182A4744A8B06D69AB7BF8E718D29814@ORSMSX113.amr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@kernel.org>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Jain,
 Praveen K" <praveen.k.jain@intel.com>, 'Liam Girdwood' <lgirdwood@gmail.com>, "Iriawan, Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "'kevin.strasser@linux.intel.com'" <kevin.strasser@linux.intel.com>, 'Dylan Reid' <dgreid@chromium.org>, "'mika.westerberg@linux.intel.com'" <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Fang, Yang A
> Sent: Wednesday, July 01, 2015 11:25 AM
> To: 'Mark Brown'
> Cc: Dylan Reid; Liam Girdwood; alsa-devel@alsa-project.org; Sripathi, Srinivas;
> Jain, Praveen K; Iriawan, Denny; Nujella, Sathyanarayana;
> kevin.strasser@linux.intel.com; mika.westerberg@linux.intel.com
> Subject: RE: [alsa-devel] [PATCH] ASoC: ts3a227e: do not report jack status
> when there is i2c read err
> 
> 
> 
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]
> > Sent: Wednesday, July 01, 2015 11:05 AM
> > To: Fang, Yang A
> > Cc: Dylan Reid; Liam Girdwood; alsa-devel@alsa-project.org; Sripathi,
> > Srinivas; Jain, Praveen K; Iriawan, Denny; Nujella, Sathyanarayana;
> > kevin.strasser@linux.intel.com; mika.westerberg@linux.intel.com
> > Subject: Re: [alsa-devel] [PATCH] ASoC: ts3a227e: do not report jack
> > status when there is i2c read err
> >
> > On Wed, Jul 01, 2015 at 10:34:09AM -0700, Yang Fang wrote:
> > > On Wed, Jul 01, 2015 at 10:12:37AM -0700, Dylan Reid wrote:
> >
> > > > Thanks, I think the error checking is good to have anyway, but
> > > > should the interrupt also be disabled across suspend/resume?  I'd
> > > > hope this device's resume callback wouldn't happen until after the
> > > > parent i2c bus is ready.
> >
> > > I am looping Mika. I was expecting that interrupt would come after
> > > i2c bus is ready. but with current pinctrl-cherryview driver the
> > > interrupt comes in random order after resume.
> >
> > I wouldn't rely on this, it's not going to be true in general - the
> > interrupt could flag at any time after the interrupt controller is
> > resumed so unless the I2C controller takes steps to ensure it is
> > resumed before interrupts (which has its own complications) you could
> > get an interrupt delivered prior to the I2C controller being ready.
> > Look at how arizona handles this for one example of dealing with this
> problem, though it's not ideal.
> 
> Thanks. i did a quick look at Arizona-core.c it disabled irq on suspend and
> enable irq on resume.  I will give a try if this is what you referred to.
> 
> In addition, current patch can address the issue even if the interrupt came
> prior to I2c bus is reumed . can I keep the err checking ?

Disable irq on suspend and enable irq on resume works well. I saw interrupt
 occurs after TI resume. I will post V2 patch
