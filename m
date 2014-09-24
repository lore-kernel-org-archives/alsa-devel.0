From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] ASoC: blackfin: add bf6xx audio dma driver
Date: Wed, 24 Sep 2014 18:02:40 +0800
Message-ID: <CAHG8p1BxYz1ZunaGRo0ruJPSU17uF5XRttqn--QeWEExMWWNtw@mail.gmail.com>
References: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
 <20140924082622.GW4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E3444261A0D
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 12:02:41 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id hq12so21565vcb.26
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 03:02:40 -0700 (PDT)
In-Reply-To: <20140924082622.GW4015@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, adi-buildroot-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

2014-09-24 16:26 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, Sep 24, 2014 at 05:55:20PM +0800, Scott Jiang wrote:
>> Bf5xx and bf6xx reused bf5xx-i2s-pcm.c before. Recently tdm driver
>> has been merged into bf5xx-i2s-pcm.c and it's not compatible with
>> bf6xx audio. So create this dma driver and add tdm support later.
>
> Can you go into a bit more detail on the differences - clearly there's
> some similarlities since the drivers got merged, can we really not share
> any code?

First, sport2 only supports i2s and left justified mode, while sport3
adds i2s packed
and right justified mode. Second, in tdm mode for sport2, tx and rx
are dependent and have
a window granularity of 8 channel. While sport3 doesn't have these
limits. What's more,
sport3 is not only used on blackfin. That means many patches can only
apply to this driver.

Thanks,
Scott
