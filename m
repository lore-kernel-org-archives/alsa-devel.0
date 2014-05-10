From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Sat, 10 May 2014 13:07:49 +0800
Message-ID: <20140510050747.GI2870@dragon>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
 <20140509150034.GH2870@dragon> <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 by alsa0.perex.cz (Postfix) with ESMTP id 17CDB261AB0
 for <alsa-devel@alsa-project.org>; Sat, 10 May 2014 07:08:00 +0200 (CEST)
Content-Disposition: inline
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 09, 2014 at 06:01:43PM +0200, Lars-Peter Clausen wrote:
> On 05/09/2014 05:34 PM, Fabio Estevam wrote:
> >On Fri, May 9, 2014 at 12:17 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> >>The changes in the patch should mostly be transparent. But what changed is
> >>how error reporting is handled. If there is a error reading/writing a
> >>register in the kcontrol callbacks that error is passed on to userspace
> >>whereas previously it was silently ignored.
> >>
> >>There is also the possibility that there is a bug somewhere in the patch
> >>causing this.
> >>
> >>Does the board otherwise work fine?
> >>
> >>I actually have the board here, if you tell me which devictree/defconfig I
> >>can use with an upstream kernel I can give things a try.
> >
> >make imx_v6_v7_defconfig
> >make imx6q-sabresd.dtb
> 
> I just tried 907fe36a2c, e2c330b9b5 and next/master. I get the same
> behavior with all 3, no errors when loading a state file and audio
> out on the headphones works.

For me, e2c330b9b5 is good while 907fe36a2c and next/master expose this
error message.

> I disabled DRM though since it
> deadlocked the system, maybe that makes a difference.

It does not make a difference.

> 
> Is it possible that the error is coming from the I2C driver? Can you
> build the I2C driver with #define DEBUG and take a look at the
> output?

I tried to turn on DEBUG in I2C driver, and did not notice any I2C
message when above error appears.

The error message only shows up with Debian wheezy and does not with
yocto rootfs.  And even when the error message shows, the audio still
functions well on Debian wheezy.  So it's just a noisy error message
for me which is only seen after your kernel patch.

Shawn
