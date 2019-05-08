From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: max98357a: release GPIO when
	component removing
Date: Wed, 8 May 2019 17:27:35 +0800
Message-ID: <CA+Px+wWQpvE5H=vM+0u_c3xpuZ8ivfgy0_xB84Ty_dvMAqBSVg@mail.gmail.com>
References: <20190507051140.240245-1-tzungbi@google.com>
 <20190508063318.GL14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA74CF807B5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 11:27:48 +0200 (CEST)
Received: by mail-ot1-x344.google.com with SMTP id v17so9645338otp.13
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2019 02:27:48 -0700 (PDT)
In-Reply-To: <20190508063318.GL14916@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@google.com>, tiwai@suse.com, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

> On Tue, May 07, 2019 at 01:11:40PM +0800, Tzung-Bi Shih wrote:
>
> > +static void max98357a_component_remove(struct snd_soc_component *component)
> > +{
> > +     struct max98357a_priv *max98357a =
> > +                     snd_soc_component_get_drvdata(component);
> > +
> > +     if (max98357a->sdmode)
> > +             devm_gpiod_put(component->dev, max98357a->sdmode);
> > +}
>
> This is an obvious mess, if you're explicitly freeing devm_ allocated
> resources in the common case something is going wrong.  Just move the
> initial allocation to the device level probe so devm can do what it's
> supposed to.

Move the GPIO allocation to max98357a_platform_probe() should work but
I am wondering the difference between device's probe() and component's
probe().  What do we expect to do in component's probe()?
As component's probe() is later than device's, I thought we tend to
put resource allocation in component's probe() for reasons:
- to speed up the booting *maybe* a little
- to allocate resources when really need them

I am using devm_gpiod_put() instead of gpiod_put() so that I suppose
devm_ should take care of the rest of cleanup.  Do you think this is
still a mess?
