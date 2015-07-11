From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: How to activate DAI link to dummy codec?
Date: Sat, 11 Jul 2015 11:58:49 +0200
Message-ID: <55A0E8D9.2010801@metafoo.de>
References: <CAOMFOmUeF_LbfYyGGaCZG690Wow7FdiZtVTFHo7FyXdRMsYpnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D389260541
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 11:58:53 +0200 (CEST)
In-Reply-To: <CAOMFOmUeF_LbfYyGGaCZG690Wow7FdiZtVTFHo7FyXdRMsYpnQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/10/2015 11:50 PM, Anatol Pomozov wrote:
> Hi
>
> I have following hardware configuration
>
> [SoC] <=> [RT5677] <=> [MAX98357A]
>
> MAX98357A is a simple speaker amplifier with I2S data interface and no
> I2C control. The chip automatically configures itself (rate/block
> frequency) when I2S is started streaming to the chip. This chip does
> not need a driver (there is nothing to configure) and we can use
> "dummy-codec" for it.

The dummy CODEC is only meant to be used in situations where there is no 
actual hardware.

If there is actual hardware even if it does not have a control bus the 
hardware will still have constraints like supported samplerates, etc. which 
should be modeled. And the data flow graph also should be modeled using DAPM.

>
> There is a DAI link between RT5677 and MAX and it should be configured
> from RT5677 side. RT5677 is master here and it need to set I2S bus
> parameters. Configuration happens in rt5677 hw_params() function and
> it is triggered by dai link activation.
>
> My question is how to tell DAPM that I need to activate this link?
>
> If MAX98357A was a real codec then it would have an OUTPUT widget that
> I can activate, this would trigger dai link in between to be activated
> as well. But dummy codec does not have any widgets, so how I suppose
> to activate link to dummy codec?

You just gave the answer yourself, make it a real CODEC :)

- Lars
