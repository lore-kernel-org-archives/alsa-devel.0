From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: I2S driver for implants
Date: Wed, 23 Jul 2014 11:23:00 +0300
Message-ID: <CA+E=qVfJ47g76=Zzq+smQUR5UY0zRWjV8Aswx5D7AAfdKLPQmA@mail.gmail.com>
References: <53CF6DD8.3000507@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9993826563F
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 10:23:21 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id h136so609656oig.35
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 01:23:20 -0700 (PDT)
In-Reply-To: <53CF6DD8.3000507@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org
Cc: vano@ivankiten.com, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2014 at 11:10 AM, Matt Flax <flatmax@flatmax.org> wrote:
> Hi there,

Hi Matt,

I'd suggest you include alsa-devel ML next time (added it to CC)

> I saw your driver sound/soc/samsung
>
> I am wanting to look into an I2S driver for the Exynos 5250 for eye
> implants.

Driver for I2S in Exynos 5 is already included in mainline kernel.

> The implants use a serial bus and I am wanting to specify an I2S connection
> to them.
>
> In order to do that I would need to write an I2S driver to talk to them.
> Their bit rates are either 300 kbps or 600 kbps.
> They only need I2S and not I2C ... there are not controls, simply serial
> data in and out.

Are you sure that your implants can talk over I2S?

> I am wondering if I can do something simple ... I notice that your driver
> doesn't require too much code ...
> Do you think it is possible for me to take a similar approach in writing my
> implant driver ?

Don't know, you didn't share much details on your hardware.

> Can you give me advice - how to start ?

Start with reading specs and try to understand how your implants work,
then look at existing code and try to adapt it for your usage.
Then clean it up and prepare for submitting into mainline.

> thanks
> Matt

Regards,
Vasily
