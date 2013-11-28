From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv1] ASoC: SGTL5000: Fix kernel failed while
 getting regulator consumers
Date: Thu, 28 Nov 2013 03:31:03 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828CF777@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1385459713-6778-1-git-send-email-Li.Xiubo@freescale.com>
 <20131126134411.GQ14725@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F828CE2A8@039-SN2MPN1-012.039d.mgd.msft.net>
 <20131127112725.GT14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 by alsa0.perex.cz (Postfix) with ESMTP id C05FA2651A5
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 04:31:07 +0100 (CET)
In-Reply-To: <20131127112725.GT14725@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "oskar@scara.com" <oskar@scara.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCHv1] ASoC: SGTL5000: Fix kernel failed while getting
> regulator consumers
> 
> On Wed, Nov 27, 2013 at 08:13:03AM +0000, Li Xiubo wrote:
> 
> Please fix your mailer to word wrap within paragraphs, it makes your mail
> much more legible.
> 

Yes, I will.


> > There is one dependency patch: "regulator: core: Provide a dummy
> regulator with full constraints".
> 
> > From the dependency patch, we can see that using regulator_get_optional()
> instead can resovle the problem you descripted above.
> 
> > When or will this dependency patch be merged into the -next tree ?
> 
> That patch is already in mainline.
> 

Okey.

> > > I'd expect to see a commit description that describes how the driver
> > > currently tries to handle this, why it doesn't work and how the
> > > patch fixes it.
> 
> > The SGTL5000 requires 2 external power supplies: VDDA and VDDIO. An
> > optional third external power supply VDDD may be provided externally
> 
> You need to put your working through of this stuff in the commit message.

I did it already, please see the next version.

--
Best Regards,
