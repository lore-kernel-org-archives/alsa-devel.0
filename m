From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
	devm_input_allocate_device()
Date: Sun, 28 Apr 2013 08:00:29 +0300
Message-ID: <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D2D8261683
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2013 07:00:51 +0200 (CEST)
Received: by mail-vc0-f172.google.com with SMTP id hx10so4739967vcb.17
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2013 22:00:51 -0700 (PDT)
In-Reply-To: <20130425125234.GV5019@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
On Thu, Apr 25, 2013 at 3:52 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 24, 2013 at 04:50:48PM +0300, Leon Romanovsky wrote:
>> On Thu, Dec 20, 2012 at 4:18 PM, Mark Brown
>
>> >         ret = input_register_device(wm8962->beep);
>> >         if (ret != 0) {
>> > -               input_free_device(wm8962->beep);
>> >                 wm8962->beep = NULL;
>> >                 dev_err(codec->dev, "Failed to register beep device\n");
>> >         }
>
>> I'm not sure if this patch is correct.
>> According to comment of input_free_memory()
>> (http://lxr.free-electrons.com/source/drivers/input/input.c#L1825) you
>> need to call it if input_register_device failed.
>
> This seems like a bug that should be fixed on the API side, it's really
> not what you'd expect a devm function to do, and if you are explicitly
> freeing a devm allocated object there's an expectation that you need to
> call a corresponding devm cleanup function.

I can't agree with you about the "expectation" - device memory can be in use.
This code will free memory after all references will be freed.
Additionally it is up-to developer to decide what to do if
input_register_device call failed.
According to the code base
(http://lxr.free-electrons.com/ident?i=input_free_device)
the patch is not correct.

Thanks.

--
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
