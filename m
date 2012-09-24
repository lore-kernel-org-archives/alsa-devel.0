From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Mon, 24 Sep 2012 16:37:23 +0200
Message-ID: <CACRpkdZKL62n02maO7CJ4Q1mNFW+=nTFOF1CWcs3b1Od3mGBbg@mail.gmail.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 261A52615E7
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 16:37:24 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so3739572wgb.20
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 07:37:23 -0700 (PDT)
In-Reply-To: <20120924101757.GC21375@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 12:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Sep 24, 2012 at 11:20:16AM +0200, Linus Walleij wrote:
>> So the problem with the patch we're discussing is that it's
>> "too far up" in the framework, and handling pinctrl should be done
>> somewhere below.
>
> Well, the problem here is that people keep wanting to add one shot
> pinctrl calls in drivers which clearly suggests that it ought to be
> factored out.

OK so can we find some suitable middle ground here?

Something like drivers could add some boolean flag to
"opt-in" for the core to handle this or so?

After all only some MMC drivers call up to
mmc_regulator_set_ocr() to set voltages, it's optional
but centralized.

I'm not sure I'm familiar enough with ASoC to have a
good suggestion on how to do this though...

Yours,
Linus Walleij
