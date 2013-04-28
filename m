From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
	devm_input_allocate_device()
Date: Sun, 28 Apr 2013 21:32:18 +0300
Message-ID: <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com>
 <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
 <20130428094745.GA5877@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E593261722
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2013 20:32:39 +0200 (CEST)
Received: by mail-vb0-f48.google.com with SMTP id p12so520281vbe.7
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2013 11:32:38 -0700 (PDT)
In-Reply-To: <20130428094745.GA5877@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 28, 2013 at 12:47 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Apr 28, 2013 at 08:00:29AM +0300, Leon Romanovsky wrote:
>> On Thu, Apr 25, 2013 at 3:52 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > This seems like a bug that should be fixed on the API side, it's really
>> > not what you'd expect a devm function to do, and if you are explicitly
>> > freeing a devm allocated object there's an expectation that you need to
>> > call a corresponding devm cleanup function.
>
>> I can't agree with you about the "expectation" - device memory can be in use.
>> This code will free memory after all references will be freed.
>> Additionally it is up-to developer to decide what to do if
>> input_register_device call failed.
>> According to the code base
>> (http://lxr.free-electrons.com/ident?i=input_free_device)
>> the patch is not correct.
>
> Right, but what I'm saying is that this is not how a devm_ API is
> expected to behave and is therefore at best error prone on two fronts -
> both due to the fact that you need to clean up explicitly even if the
> resource is not actually managed and also due to the fact that the
> regular free function is being used rather than a devm_ one when
> explicit deallocation is done.  Neither of these things is normal for a
> devm_ API.  The behaviour you're describing says that the managed
> function should actually be registration not allocation.
I think the reason of our misunderstanding is due to the name of
input_free_device call. From the code, it is device destroy function,
and the freeing itself done as an error handling of
input_register_device
(http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).

How do you think we need to proceed? Do I need to send patches with
explicit call to input_free_device function?

--
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
