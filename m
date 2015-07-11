From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: How to activate DAI link to dummy codec?
Date: Sat, 11 Jul 2015 16:37:45 -0700
Message-ID: <CAOMFOmVbhRs-cakKSC=eMPONCSK4Qjnod63ZwjDkmQFxRGRa+g@mail.gmail.com>
References: <CAOMFOmUeF_LbfYyGGaCZG690Wow7FdiZtVTFHo7FyXdRMsYpnQ@mail.gmail.com>
 <55A0E8D9.2010801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f52.google.com (mail-vn0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E03AA2605D9
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 01:37:46 +0200 (CEST)
Received: by vnbf62 with SMTP id f62so25525309vnb.8
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:37:46 -0700 (PDT)
In-Reply-To: <55A0E8D9.2010801@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Sat, Jul 11, 2015 at 2:58 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/10/2015 11:50 PM, Anatol Pomozov wrote:
>>
>> Hi
>>
>> I have following hardware configuration
>>
>> [SoC] <=> [RT5677] <=> [MAX98357A]
>>
>> MAX98357A is a simple speaker amplifier with I2S data interface and no
>> I2C control. The chip automatically configures itself (rate/block
>> frequency) when I2S is started streaming to the chip. This chip does
>> not need a driver (there is nothing to configure) and we can use
>> "dummy-codec" for it.
>
>
> The dummy CODEC is only meant to be used in situations where there is no
> actual hardware.

Thanks Lars-Peter, this is the answer I was looking for.

I created a simple driver for MAX98357 and it works fine. Will share
it later after more testing.

>
> If there is actual hardware even if it does not have a control bus the
> hardware will still have constraints like supported samplerates, etc. which
> should be modeled. And the data flow graph also should be modeled using
> DAPM.
>
>>
>> There is a DAI link between RT5677 and MAX and it should be configured
>> from RT5677 side. RT5677 is master here and it need to set I2S bus
>> parameters. Configuration happens in rt5677 hw_params() function and
>> it is triggered by dai link activation.
>>
>> My question is how to tell DAPM that I need to activate this link?
>>
>> If MAX98357A was a real codec then it would have an OUTPUT widget that
>> I can activate, this would trigger dai link in between to be activated
>> as well. But dummy codec does not have any widgets, so how I suppose
>> to activate link to dummy codec?
>
>
> You just gave the answer yourself, make it a real CODEC :)
