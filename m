From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: I2S driver for implants
Date: Wed, 23 Jul 2014 17:16:02 +0300
Message-ID: <2430756.lOJscA1gsc@vasilykh-desktop-i5>
References: <53CF6DD8.3000507@flatmax.org>
 <9397069.ggOniReSfE@vasilykh-desktop-i5> <53CF979B.30702@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id D30812655FE
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 16:18:02 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id q58so1227710wes.7
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 07:17:59 -0700 (PDT)
In-Reply-To: <53CF979B.30702@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>, cw00.choi@samsung.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23 July 2014 21:08:11 Matt Flax wrote:

> > You'd probably need some codec stub, I'm not sure if it's possible to
> > instantiate soundcard with only i2s and without a codec.
> 
> Thats fine, I can implement the codec stub. I guess I was originally
> contacting you (and others) to get some pointers on how to do that. Is
> there perhaps a codec stub for some very simple hardware (only I2S)
> which I could use as a reference ?

You already have cpu dai (i2s), now you need codec dai (which is dummy).
Maybe I'm wrong, and you don't need a codec stub, I'm not an ASoC expert.

> Also would require an example dts
> file ... all for the Exynos.

Look for one in arch/arm/boot/dts?

> thanks
> Matt

Regards
Vasily
