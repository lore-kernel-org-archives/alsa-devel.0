From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Tue, 25 Sep 2012 12:43:53 +0100
Message-ID: <20120925114352.GE4428@opensource.wolfsonmicro.com>
References: <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <20120922152840.GM4495@opensource.wolfsonmicro.com>
 <505E80AD.9050000@wwwdotorg.org>
 <CACRpkdbewb0SVYJoT9O4PAajFWny+YOcmf2CLUKL1NzxGWoa5A@mail.gmail.com>
 <20120924101757.GC21375@opensource.wolfsonmicro.com>
 <CACRpkdZKL62n02maO7CJ4Q1mNFW+=nTFOF1CWcs3b1Od3mGBbg@mail.gmail.com>
 <20120925111146.GC4428@opensource.wolfsonmicro.com>
 <50619467.3040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF4B32616BA
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 13:43:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50619467.3040203@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 25, 2012 at 02:24:23PM +0300, Peter Ujfalusi wrote:

> During audio activity we obviously need to configure these pins to MODE0 but
> when there is not activity we could set them to SAFE_MODE which could result
> some power savings (preventing leakage, etc).

Right, this is Linus' power saving case.  It's going to be applicable in
some way to most devices, though the benefits will vary quite a bit.

> For this to work it would be ideal to use the pm_runtime as a centralized
> place to handle clocks, pinctrl, etc...
> But again, what to do with the cases when this is not needed (the pinctrl part
> for the devices)?

It's also not massively clear to me that generic pm_runtime code is a
good place to put all this stuff - it's too coarse grained for a lot of
things.  Devices that can be wake sources are an example here, if they
are doing that then turning them completely off may break functionality
but you can still turn some of the device (possibly a varying selection
depending on usage) off.  For simple cases it works well and it'd be
good to have it but you end up back into ignoring errors...
