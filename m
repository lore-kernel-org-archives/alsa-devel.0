From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Fri, 9 May 2014 13:11:22 -0300
Message-ID: <CAOMZO5Cd2oZmOVcFQNRGsF=yPY+pdyWVftFBq3GxsuGc0xwuoA@mail.gmail.com>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
 <20140509150034.GH2870@dragon> <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f169.google.com (mail-vc0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5223F261A64
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 18:11:23 +0200 (CEST)
Received: by mail-vc0-f169.google.com with SMTP id ij19so5607836vcb.0
 for <alsa-devel@alsa-project.org>; Fri, 09 May 2014 09:11:22 -0700 (PDT)
In-Reply-To: <536CFBE7.3070805@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 9, 2014 at 1:01 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> I just tried 907fe36a2c, e2c330b9b5 and next/master. I get the same behavior
> with all 3, no errors when loading a state file and audio out on the
> headphones works. I disabled DRM though since it deadlocked the system,
> maybe that makes a difference.

Here is the fix for this hang  (which hasn't reached linux-next yet):
http://www.spinics.net/lists/arm-kernel/msg329063.html

>
> Is it possible that the error is coming from the I2C driver? Can you build
> the I2C driver with #define DEBUG and take a look at the output?

I will let Shawn to try it. With my minimal rootfs I do not see the
error messages when playing audio.
